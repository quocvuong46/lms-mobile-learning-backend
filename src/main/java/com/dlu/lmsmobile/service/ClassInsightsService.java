package com.dlu.lmsmobile.service;

import com.dlu.lmsmobile.exception.InvalidRequestException;
import com.dlu.lmsmobile.exception.ResourceNotFoundException;
import com.dlu.lmsmobile.repository.InsightsRepository;
import com.dlu.lmsmobile.repository.TeacherRepository;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Clock;
import java.time.DayOfWeek;
import java.time.Instant;
import java.time.LocalDate;
import java.time.temporal.TemporalAdjusters;
import java.util.*;

import static com.dlu.lmsmobile.service.Values.*;

/**
 * Class-level learning insights for a teacher. Access is limited to courses the teacher is
 * assigned to (same check as the monitoring endpoints). Output is aggregate plus a short list
 * of students with plain-language reasons; it never states a conclusion about ability.
 */
@Service
@Transactional(readOnly = true)
public class ClassInsightsService {
    static final int MIN_WEEKS = 4, MAX_WEEKS = 16;
    static final double LOW_COMPLETION_RATE = 50.0;
    static final int MAX_ATTENTION_STUDENTS = 10, MAX_LOW_ACTIVITIES = 5;

    private final TeacherRepository teachers;
    private final InsightsRepository insights;
    private final Clock clock;
    private final String dataMode;

    public ClassInsightsService(TeacherRepository teachers, InsightsRepository insights, Clock clock,
                                @Value("${app.data-source.mode:demo}") String dataMode) {
        this.teachers = teachers;
        this.insights = insights;
        this.clock = clock;
        this.dataMode = "live".equalsIgnoreCase(dataMode) ? "live" : "demo";
    }

    public Map<String, Object> getClassInsights(Long teacherId, Long courseId, int requestedWeeks) {
        if (requestedWeeks < 1) throw new InvalidRequestException("Số tuần phải lớn hơn 0");
        if (!teachers.hasCourse(teacherId, courseId)) throw new ResourceNotFoundException("Teacher course not found");
        int weeks = Math.max(MIN_WEEKS, Math.min(MAX_WEEKS, requestedWeeks));
        LocalDate today = LocalDate.now(clock);
        LocalDate firstWeek = today.with(TemporalAdjusters.previousOrSame(DayOfWeek.MONDAY)).minusWeeks(weeks - 1L);
        long since = firstWeek.atStartOfDay(clock.getZone()).toEpochSecond();
        long nowEpoch = Instant.now(clock).getEpochSecond();

        List<Map<String, Object>> roster = teachers.findStudents(teacherId, courseId);
        List<Map<String, Object>> taskRows = insights.findClassTaskStatus(teacherId, courseId);
        List<Map<String, Object>> engagementRows = insights.findClassEngagementByWeek(teacherId, courseId, since);
        List<Map<String, Object>> completionRows = insights.findClassCompletionsByWeek(teacherId, courseId, since);
        List<Map<String, Object>> activities = new ArrayList<>(teachers.findActivities(teacherId, courseId, "assignment"));
        activities.addAll(teachers.findActivities(teacherId, courseId, "quiz"));

        Map<String, Object> groups = watchGroups(roster);
        List<Map<String, Object>> attention = attentionStudents(roster);
        List<Map<String, Object>> lowActivities = lowCompletionActivities(activities, nowEpoch);
        Map<String, Object> tasks = taskDistribution(taskRows);
        Map<String, Object> weekly = weekly(engagementRows, completionRows, firstWeek, today, roster.size());

        Map<String, Object> summary = new LinkedHashMap<>();
        summary.put("student_count", roster.size());
        summary.put("average_progress", round1(mean(roster, "progress")));
        summary.put("average_grade_percentage", round1(mean(roster, "average_grade")));
        summary.put("watch_count", lng(groups.get("watch")) + lng(groups.get("needs_support")));

        Map<String, Object> out = new LinkedHashMap<>();
        out.put("teacher_id", teacherId);
        out.put("course_id", courseId);
        out.put("generated_at", Instant.now(clock).toString());
        out.put("timezone", clock.getZone().getId());
        out.put("weeks", weeks);
        out.put("range_start", firstWeek.toString());
        out.put("range_end", today.toString());
        out.put("data_mode", dataMode);
        out.put("data_notice", "demo".equals(dataMode)
            ? "Dữ liệu minh họa từ môi trường phát triển, không phải kết quả học tập thật." : null);
        out.put("summary", summary);
        out.put("progress_distribution", progressDistribution(roster));
        out.put("watch_groups", groups);
        out.put("watch_criteria", WATCH_CRITERIA);
        out.put("attention_students", attention);
        out.put("task_status", tasks);
        out.put("weekly_trend", weekly);
        out.put("low_completion_activities", lowActivities);
        out.put("suggested_interventions", interventions(groups, tasks, lowActivities));
        return out;
    }

    /** Mirrors the scoring in derived.student_risk_indicator so teachers can verify a label. */
    static final List<String> WATCH_CRITERIA = List.of(
        "Không hoạt động 7–13 ngày: +25 điểm; từ 14 ngày: +40 điểm",
        "1–2 việc quá hạn: +15 điểm; từ 3 việc: +30 điểm",
        "Tiến độ dưới 30%: +25 điểm; dưới 60%: +10 điểm",
        "Không có sự kiện học tập trong 7 ngày: +10 điểm",
        "Từ 30 điểm: cần theo dõi; từ 60 điểm: cần hỗ trợ sớm");

    static List<Map<String, Object>> progressDistribution(List<Map<String, Object>> roster) {
        String[] labels = {"0–24%", "25–49%", "50–74%", "75–100%"};
        long[] counts = new long[4];
        long noData = 0;
        for (Map<String, Object> s : roster) {
            Double p = num(s.get("progress"));
            if (p == null) {
                noData++;
                continue;
            }
            counts[p < 25 ? 0 : p < 50 ? 1 : p < 75 ? 2 : 3]++;
        }
        List<Map<String, Object>> out = new ArrayList<>();
        for (int i = 0; i < 4; i++) out.add(Map.of("label", labels[i], "students", counts[i]));
        if (noData > 0) out.add(Map.of("label", "Chưa có dữ liệu", "students", noData));
        return out;
    }

    static Map<String, Object> watchGroups(List<Map<String, Object>> roster) {
        long onTrack = 0, watch = 0, support = 0, unknown = 0;
        for (Map<String, Object> s : roster) {
            switch (str(s.get("risk_level")) == null ? "" : str(s.get("risk_level")).toUpperCase()) {
                case "LOW" -> onTrack++;
                case "MEDIUM" -> watch++;
                case "HIGH" -> support++;
                default -> unknown++;
            }
        }
        Map<String, Object> out = new LinkedHashMap<>();
        out.put("on_track", onTrack);
        out.put("watch", watch);
        out.put("needs_support", support);
        out.put("unknown", unknown);
        out.put("unit", "sinh viên");
        return out;
    }

    static List<Map<String, Object>> attentionStudents(List<Map<String, Object>> roster) {
        List<Map<String, Object>> picked = new ArrayList<>();
        for (Map<String, Object> s : roster) {
            String risk = str(s.get("risk_level")) == null ? "" : str(s.get("risk_level")).toUpperCase();
            if (!risk.equals("MEDIUM") && !risk.equals("HIGH")) continue;
            List<String> reasons = new ArrayList<>(), actions = new ArrayList<>();
            long overdue = lng(s.get("overdue_tasks"));
            Double progress = num(s.get("progress"));
            Object inactive = s.get("days_since_last_activity");
            if (overdue > 0) {
                reasons.add(overdue + " bài đã quá hạn");
                actions.add("Nhắc sinh viên về các bài đã quá hạn và hỏi về khó khăn khi hoàn thành");
            }
            if (inactive instanceof Number n && n.intValue() >= 7) {
                reasons.add(n.intValue() + " ngày chưa hoạt động");
                actions.add("Liên hệ để biết sinh viên có gặp khó khăn khi truy cập khóa học không");
            }
            if (progress != null && progress < 30) {
                reasons.add("Tiến độ học tập dưới 30%");
                actions.add("Gợi ý nội dung hoặc tài liệu nên xem trước để theo kịp lớp");
            } else if (progress != null && progress < 60) {
                reasons.add("Tiến độ học tập còn thấp");
            }
            Map<String, Object> m = new LinkedHashMap<>();
            m.put("userid", s.get("userid"));
            m.put("fullname", s.get("fullname"));
            m.put("student_code", s.get("student_code"));
            m.put("risk_level", risk);
            m.put("progress", num(s.get("progress")));
            m.put("overdue_tasks", overdue);
            m.put("days_since_last_activity", inactive);
            m.put("reasons", reasons);
            m.put("suggested_actions", actions);
            if (reasons.isEmpty()) {
                m.put("note", "Mức theo dõi do hệ thống tính; chưa xác định được nguyên nhân cụ thể từ dữ liệu hiện có.");
            }
            picked.add(m);
        }
        picked.sort(Comparator
            .comparingInt((Map<String, Object> m) -> "HIGH".equals(m.get("risk_level")) ? 0 : 1)
            .thenComparing(m -> -lng(m.get("overdue_tasks"))));
        return picked.size() > MAX_ATTENTION_STUDENTS ? new ArrayList<>(picked.subList(0, MAX_ATTENTION_STUDENTS)) : picked;
    }

    static Map<String, Object> taskDistribution(List<Map<String, Object>> rows) {
        long completed = 0, pending = 0, overdue = 0;
        for (Map<String, Object> r : rows) {
            long n = lng(r.get("tasks"));
            switch (str(r.get("task_status")) == null ? "" : str(r.get("task_status"))) {
                case "completed" -> completed += n;
                case "overdue" -> overdue += n;
                case "pending" -> pending += n;
                default -> {
                }
            }
        }
        Map<String, Object> out = new LinkedHashMap<>();
        out.put("total", completed + pending + overdue);
        out.put("completed", completed);
        out.put("pending", pending);
        out.put("overdue", overdue);
        out.put("unit", "lượt giao bài (sinh viên × bài tập/bài kiểm tra)");
        return out;
    }

    static Map<String, Object> weekly(List<Map<String, Object>> engagement, List<Map<String, Object>> completions,
                                      LocalDate firstWeek, LocalDate today, int studentCount) {
        Map<LocalDate, Map<String, Object>> eng = new HashMap<>();
        for (Map<String, Object> r : engagement) {
            LocalDate d = date(r.get("week_start"));
            if (d != null) eng.put(d, r);
        }
        Map<LocalDate, Long> comp = new HashMap<>();
        for (Map<String, Object> r : completions) {
            LocalDate d = date(r.get("week_start"));
            if (d != null) comp.merge(d, lng(r.get("completed_activities")), Long::sum);
        }
        List<Map<String, Object>> points = new ArrayList<>();
        long totalEvents = 0, totalCompleted = 0;
        for (LocalDate w = firstWeek; !w.isAfter(today); w = w.plusWeeks(1)) {
            Map<String, Object> e = eng.get(w);
            long active = e == null ? 0 : lng(e.get("active_students"));
            long events = e == null ? 0 : lng(e.get("events"));
            long done = comp.getOrDefault(w, 0L);
            totalEvents += events;
            totalCompleted += done;
            Map<String, Object> p = new LinkedHashMap<>();
            p.put("week_start", w.toString());
            p.put("active_students", active);
            p.put("events", events);
            p.put("completed_activities", done);
            points.add(p);
        }
        Map<String, Object> out = new LinkedHashMap<>();
        out.put("student_count", studentCount);
        out.put("engagement_available", totalEvents > 0);
        out.put("completion_available", totalCompleted > 0);
        out.put("engagement_unit", "số sinh viên có hoạt động trong tuần");
        out.put("completion_unit", "số hoạt động được hoàn thành trong tuần");
        out.put("points", points);
        return out;
    }

    static List<Map<String, Object>> lowCompletionActivities(List<Map<String, Object>> activities, long nowEpoch) {
        List<Map<String, Object>> out = new ArrayList<>();
        for (Map<String, Object> a : activities) {
            long students = lng(a.get("student_count"));
            if (students <= 0) continue;
            double rate = lng(a.get("done_count")) * 100.0 / students;
            if (rate >= LOW_COMPLETION_RATE) continue;
            long due = lng(a.get("due_time"));
            boolean duePassed = due > 0 && due < nowEpoch;
            Map<String, Object> m = new LinkedHashMap<>();
            m.put("source_id", a.get("source_id"));
            m.put("task_type", a.get("task_type"));
            m.put("title", a.get("title"));
            m.put("due_time", due > 0 ? due : null);
            m.put("due_passed", duePassed);
            m.put("student_count", students);
            m.put("done_count", lng(a.get("done_count")));
            m.put("completion_rate", round1(rate));
            m.put("coursemoduleid", a.get("coursemoduleid"));
            m.put("moodle_path", a.get("moodle_path"));
            m.put("note", duePassed ? null : "Chưa đến hạn nên tỷ lệ thấp có thể là bình thường.");
            out.add(m);
        }
        out.sort(Comparator
            .comparingInt((Map<String, Object> m) -> Boolean.TRUE.equals(m.get("due_passed")) ? 0 : 1)
            .thenComparingDouble(m -> num(m.get("completion_rate"))));
        return out.size() > MAX_LOW_ACTIVITIES ? new ArrayList<>(out.subList(0, MAX_LOW_ACTIVITIES)) : out;
    }

    static List<Map<String, Object>> interventions(Map<String, Object> groups, Map<String, Object> tasks,
                                                   List<Map<String, Object>> lowActivities) {
        List<Map<String, Object>> out = new ArrayList<>();
        long support = lng(groups.get("needs_support")), watch = lng(groups.get("watch"));
        if (support > 0) {
            out.add(intervention("CONTACT_SUPPORT_GROUP", "Liên hệ " + support + " sinh viên cần hỗ trợ sớm",
                "Các sinh viên này đạt từ 60 điểm theo tiêu chí theo dõi. Mở danh sách để xem lý do từng người."));
        }
        if (watch > 0) {
            out.add(intervention("CHECK_IN_WATCH_GROUP", "Hỏi thăm " + watch + " sinh viên cần theo dõi",
                "Có dấu hiệu chậm tiến độ ở mức vừa; một lời nhắc ngắn thường là đủ."));
        }
        if (lng(tasks.get("overdue")) > 0) {
            out.add(intervention("REMIND_OVERDUE", "Nhắc cả lớp về " + lng(tasks.get("overdue")) + " lượt bài quá hạn",
                "Số lượt giao bài đã quá hạn nhưng chưa nộp hoặc chưa hoàn tất."));
        }
        for (Map<String, Object> a : lowActivities) {
            if (Boolean.TRUE.equals(a.get("due_passed"))) {
                out.add(intervention("REVIEW_LOW_ACTIVITY", "Xem lại \"" + a.get("title") + "\"",
                    "Chỉ " + a.get("completion_rate") + "% sinh viên hoàn thành sau hạn; có thể cần giải thích lại yêu cầu."));
                break;
            }
        }
        return out;
    }

    private static Map<String, Object> intervention(String code, String title, String reason) {
        Map<String, Object> m = new LinkedHashMap<>();
        m.put("code", code);
        m.put("title", title);
        m.put("reason", reason);
        m.put("created_at", Instant.now().toString());
        return m;
    }

    private static Double mean(List<Map<String, Object>> rows, String column) {
        double sum = 0;
        int n = 0;
        for (Map<String, Object> r : rows) {
            Double v = num(r.get(column));
            if (v != null) {
                sum += v;
                n++;
            }
        }
        return n == 0 ? null : sum / n;
    }
}
