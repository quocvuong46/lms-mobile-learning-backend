package com.dlu.lmsmobile.service;

import com.dlu.lmsmobile.exception.InvalidRequestException;
import com.dlu.lmsmobile.exception.ResourceNotFoundException;
import com.dlu.lmsmobile.repository.InsightsRepository;
import com.dlu.lmsmobile.repository.StudentRepository;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.Clock;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.*;

import static com.dlu.lmsmobile.service.Values.*;

/**
 * Personal learning goals. Goals are app-owned data (app.learning_goals). Progress is always
 * computed on read from LMS-derived data, and "completed"/"expired" are derived, not stored.
 */
@Service
public class GoalService {
    static final int MAX_ACTIVE_GOALS = 10;
    static final Set<String> SUPPORTED_TYPES = Set.of("completion_percentage", "activity_count", "target_grade");
    /** A goal is flagged when actual progress trails the linear expectation by more than this. */
    static final double PACE_TOLERANCE_POINTS = 20.0;
    static final int NEAR_DEADLINE_DAYS = 3;

    private final InsightsRepository insights;
    private final StudentRepository students;
    private final Clock clock;

    public GoalService(InsightsRepository insights, StudentRepository students, Clock clock) {
        this.insights = insights;
        this.students = students;
        this.clock = clock;
    }

    public List<Map<String, Object>> list(Long userId) {
        return evaluate(userId, insights.findGoals(userId));
    }

    public Map<String, Object> create(Long userId, String goalType, BigDecimal target, Long courseId,
                                      LocalDate startDate, LocalDate endDate) {
        LocalDate today = LocalDate.now(clock);
        if (goalType == null || goalType.isBlank()) throw new InvalidRequestException("Thiếu loại mục tiêu");
        if ("study_minutes".equals(goalType)) {
            throw new InvalidRequestException(
                "Chưa hỗ trợ mục tiêu thời gian học vì hệ thống không ghi nhận thời lượng học.");
        }
        if (!SUPPORTED_TYPES.contains(goalType)) throw new InvalidRequestException("Loại mục tiêu không hợp lệ");
        if (target == null) throw new InvalidRequestException("Thiếu giá trị mục tiêu");
        if ("activity_count".equals(goalType)) {
            if (target.stripTrailingZeros().scale() > 0 || target.compareTo(BigDecimal.ONE) < 0
                || target.compareTo(BigDecimal.valueOf(500)) > 0) {
                throw new InvalidRequestException("Số hoạt động mục tiêu phải là số nguyên từ 1 đến 500");
            }
        } else if (target.compareTo(BigDecimal.ONE) < 0 || target.compareTo(BigDecimal.valueOf(100)) > 0) {
            throw new InvalidRequestException("Mục tiêu phần trăm phải nằm trong khoảng 1 đến 100");
        }
        LocalDate start = startDate == null ? today : startDate;
        if (start.isBefore(today.minusDays(30)) || start.isAfter(today.plusDays(365))) {
            throw new InvalidRequestException("Ngày bắt đầu phải trong khoảng 30 ngày trước đến 1 năm sau");
        }
        if (endDate != null) {
            if (endDate.isBefore(start)) throw new InvalidRequestException("Ngày kết thúc phải sau ngày bắt đầu");
            if (endDate.isAfter(start.plusDays(730))) {
                throw new InvalidRequestException("Mục tiêu không được kéo dài quá 2 năm");
            }
        }
        if (courseId != null && !insights.isEnrolled(userId, courseId)) {
            throw new InvalidRequestException("Khóa học không nằm trong danh sách khóa học của bạn");
        }
        if (insights.countActiveGoals(userId) >= MAX_ACTIVE_GOALS) {
            throw new InvalidRequestException("Bạn đã có tối đa " + MAX_ACTIVE_GOALS
                + " mục tiêu đang thực hiện. Hãy hủy bớt trước khi thêm mục tiêu mới.");
        }
        long id = insights.insertGoal(userId, courseId, goalType, target.setScale(2, java.math.RoundingMode.HALF_UP),
            start, endDate);
        return evaluate(userId, insights.findGoal(userId, id)).stream().findFirst()
            .orElseThrow(() -> new ResourceNotFoundException("Goal not found after creation"));
    }

    public Map<String, Object> cancel(Long userId, Long goalId) {
        if (insights.cancelGoal(userId, goalId) == 0) {
            throw new ResourceNotFoundException("Active goal not found");
        }
        return evaluate(userId, insights.findGoal(userId, goalId)).stream().findFirst()
            .orElseThrow(() -> new ResourceNotFoundException("Goal not found"));
    }

    /** Adds computed progress to goal rows. Package-private for unit tests. */
    List<Map<String, Object>> evaluate(Long userId, List<Map<String, Object>> rows) {
        if (rows.isEmpty()) return List.of();
        LocalDate today = LocalDate.now(clock);
        List<Map<String, Object>> courses = students.findCoursesByUserId(userId);
        List<Map<String, Object>> analytics = insights.findLearningAnalytics(userId);
        List<Map<String, Object>> completions = insights.findStudentCompletionsByDay(userId);
        List<Map<String, Object>> result = new ArrayList<>();
        for (Map<String, Object> row : rows) result.add(evaluateOne(row, today, courses, analytics, completions));
        return result;
    }

    private Map<String, Object> evaluateOne(Map<String, Object> row, LocalDate today,
                                            List<Map<String, Object>> courses,
                                            List<Map<String, Object>> analytics,
                                            List<Map<String, Object>> completions) {
        String type = str(row.get("goal_type"));
        String storedStatus = str(row.get("status"));
        Long courseId = row.get("course_id") == null ? null : lng(row.get("course_id"));
        double target = num(row.get("target_value")) == null ? 0 : num(row.get("target_value"));
        LocalDate start = date(row.get("start_date"));
        LocalDate end = date(row.get("end_date"));

        Double current;
        String unit;
        switch (type == null ? "" : type) {
            case "completion_percentage" -> {
                unit = "%";
                current = average(courses, "progress_percentage", courseId);
            }
            case "target_grade" -> {
                unit = "%";
                current = average(analytics, "average_grade_percentage", courseId);
            }
            case "activity_count" -> {
                unit = "hoạt động";
                LocalDate until = end != null && end.isBefore(today) ? end : today;
                long count = 0;
                for (Map<String, Object> c : completions) {
                    LocalDate day = date(c.get("day"));
                    if (day == null || start == null || day.isBefore(start) || day.isAfter(until)) continue;
                    if (courseId != null && lng(c.get("courseid")) != courseId) continue;
                    count += lng(c.get("completed"));
                }
                current = (double) count;
            }
            default -> {
                unit = "";
                current = null;
            }
        }

        Double progress = current == null || target <= 0 ? null : Math.min(100.0, current / target * 100.0);
        boolean achieved = current != null && target > 0 && current >= target;
        String status = switch (storedStatus == null ? "" : storedStatus) {
            case "active" -> achieved ? "completed" : (end != null && today.isAfter(end) ? "expired" : "active");
            default -> storedStatus;
        };

        Long daysLeft = end == null ? null : ChronoUnit.DAYS.between(today, end);
        String attention = null;
        Double expected = null;
        if ("active".equals(status) && progress != null) {
            if (end != null && start != null && end.isAfter(start) && "activity_count".equals(type)) {
                double span = ChronoUnit.DAYS.between(start, end) + 1;
                double elapsed = Math.max(0, Math.min(span, ChronoUnit.DAYS.between(start, today) + 1));
                expected = round1(elapsed / span * 100.0);
                if (progress < expected - PACE_TOLERANCE_POINTS) attention = "BEHIND_PACE";
            }
            if (attention == null && daysLeft != null && daysLeft <= NEAR_DEADLINE_DAYS) attention = "NEAR_DEADLINE";
        }

        Map<String, Object> out = new LinkedHashMap<>();
        out.put("id", row.get("id"));
        out.put("goal_type", type);
        out.put("course_id", courseId);
        out.put("course_name", row.get("course_name"));
        out.put("target_value", round1(target));
        out.put("unit", unit);
        out.put("start_date", start == null ? null : start.toString());
        out.put("end_date", end == null ? null : end.toString());
        out.put("stored_status", storedStatus);
        out.put("status", status);
        out.put("current_value", round1(current));
        out.put("progress_percent", round1(progress));
        out.put("expected_percent", expected);
        out.put("achieved", achieved);
        out.put("attention", attention);
        out.put("days_left", daysLeft);
        out.put("created_at", instant(row.get("created_at")));
        out.put("basis", basisFor(type, courseId == null));
        return out;
    }

    private static String basisFor(String type, boolean allCourses) {
        String scope = allCourses ? "trung bình các khóa học" : "khóa học đã chọn";
        return switch (type == null ? "" : type) {
            case "completion_percentage" -> "Tiến độ hoàn thành hoạt động có theo dõi (" + scope + ").";
            case "target_grade" -> "Trung bình điểm các hoạt động đã chấm (" + scope
                + "). Chỉ tính các hoạt động đã có điểm.";
            case "activity_count" ->
                "Số hoạt động được LMS ghi nhận hoàn thành kể từ ngày bắt đầu (" + scope + ").";
            default -> "";
        };
    }

    /** Mean of a numeric column, optionally for one course. Null when no row has a value. */
    private static Double average(List<Map<String, Object>> rows, String column, Long courseId) {
        double sum = 0;
        int n = 0;
        for (Map<String, Object> r : rows) {
            if (courseId != null && lng(r.get("courseid")) != courseId) continue;
            Double v = num(r.get(column));
            if (v == null) continue;
            sum += v;
            n++;
        }
        return n == 0 ? null : sum / n;
    }
}
