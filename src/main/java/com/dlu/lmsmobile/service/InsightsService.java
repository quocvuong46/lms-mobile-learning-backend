package com.dlu.lmsmobile.service;

import com.dlu.lmsmobile.repository.InsightsRepository;
import com.dlu.lmsmobile.repository.StudentRepository;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.time.Clock;
import java.time.DayOfWeek;
import java.time.Instant;
import java.time.LocalDate;
import java.time.temporal.TemporalAdjusters;
import java.util.*;

import static com.dlu.lmsmobile.service.Values.*;

/**
 * Personal learning insights for one student: activity heatmap, streak, completion timeline,
 * task distribution, per-course progress and rule-based suggestions.
 *
 * <p>Every number is derived from LMS data on read. When data is too thin to support a
 * statement (no events, no completions, fewer than three completions in two weeks) the
 * response says so instead of producing a trend.
 */
@Service
public class InsightsService {
    static final int MIN_DAYS = 14, MAX_DAYS = 180, STREAK_HORIZON_DAYS = 180;
    static final int DUE_SOON_HOURS = 48;
    static final int INACTIVE_NOTICE_DAYS = 7, INACTIVE_ATTENTION_DAYS = 14;
    static final double LOW_PROGRESS_PERCENT = 30.0;
    static final int MIN_COMPLETIONS_FOR_TREND = 3;
    static final int MAX_SUGGESTIONS = 5;

    private final InsightsRepository insights;
    private final StudentRepository students;
    private final GoalService goals;
    private final Clock clock;
    private final String dataMode;

    public InsightsService(InsightsRepository insights, StudentRepository students, GoalService goals, Clock clock,
                           @Value("${app.data-source.mode:demo}") String dataMode) {
        this.insights = insights;
        this.students = students;
        this.goals = goals;
        this.clock = clock;
        this.dataMode = "live".equalsIgnoreCase(dataMode) ? "live" : "demo";
    }

    public Map<String, Object> getStudentInsights(Long userId, int requestedDays) {
        int days = Math.max(MIN_DAYS, Math.min(MAX_DAYS, requestedDays));
        LocalDate today = LocalDate.now(clock);
        LocalDate windowStart = today.minusDays(days - 1L);
        long since = today.minusDays(STREAK_HORIZON_DAYS - 1L).atStartOfDay(clock.getZone()).toEpochSecond();
        long nowEpoch = Instant.now(clock).getEpochSecond();

        List<Map<String, Object>> courses = students.findCoursesByUserId(userId);
        List<Map<String, Object>> tasks = students.findAllTasks(userId);
        Map<LocalDate, Long> events = eventsByDay(insights.findStudentActivityByDay(userId, since));
        List<Map<String, Object>> completions = insights.findStudentCompletionsByDay(userId);
        List<Map<String, Object>> goalList = goals.list(userId);

        Map<String, Object> heatmap = heatmap(events, windowStart, today);
        Map<String, Object> streak = streak(events, today);
        Map<String, Object> timeline = timeline(completions, courses, windowStart, today);
        Map<String, Object> taskStatus = taskStatus(tasks, nowEpoch);
        List<Map<String, Object>> courseProgress = courseProgress(courses);
        List<Map<String, Object>> deadlines = upcomingDeadlines(tasks, nowEpoch);
        List<Map<String, Object>> suggestions = suggestions(taskStatus, courses, streak, goalList);

        Map<String, Object> summary = new LinkedHashMap<>();
        summary.put("course_count", courses.size());
        summary.put("average_progress", round1(mean(courses, "progress_percentage")));
        summary.put("current_streak_days", streak.get("current_days"));
        summary.put("longest_streak_days", streak.get("longest_days"));
        summary.put("active_days_in_range", heatmap.get("active_days"));
        summary.put("active_goals", goalList.stream().filter(g -> "active".equals(g.get("status"))).count());
        summary.put("achieved_goals", goalList.stream().filter(g -> "completed".equals(g.get("status"))).count());
        summary.put("due_soon_goals", goalList.stream().filter(g -> "NEAR_DEADLINE".equals(g.get("attention"))).count());

        Map<String, Object> out = new LinkedHashMap<>();
        out.put("user_id", userId);
        out.put("generated_at", Instant.now(clock).toString());
        out.put("timezone", clock.getZone().getId());
        out.put("range_days", days);
        out.put("range_start", windowStart.toString());
        out.put("range_end", today.toString());
        out.put("data_mode", dataMode);
        out.put("data_notice", "demo".equals(dataMode)
            ? "Dữ liệu minh họa từ môi trường phát triển, không phải kết quả học tập thật." : null);
        out.put("summary", summary);
        out.put("task_status", taskStatus);
        out.put("course_progress", courseProgress);
        out.put("upcoming_deadlines", deadlines);
        out.put("activity_heatmap", heatmap);
        out.put("streak", streak);
        out.put("progress_timeline", timeline);
        out.put("suggestions", suggestions);
        return out;
    }

    // ------------------------------------------------------------------ building blocks

    private static Map<LocalDate, Long> eventsByDay(List<Map<String, Object>> rows) {
        Map<LocalDate, Long> out = new HashMap<>();
        for (Map<String, Object> r : rows) {
            LocalDate d = date(r.get("day"));
            if (d != null) out.merge(d, lng(r.get("events")), Long::sum);
        }
        return out;
    }

    static Map<String, Object> heatmap(Map<LocalDate, Long> events, LocalDate from, LocalDate to) {
        List<Map<String, Object>> cells = new ArrayList<>();
        long total = 0, max = 0;
        int active = 0;
        for (LocalDate d = from; !d.isAfter(to); d = d.plusDays(1)) {
            long n = events.getOrDefault(d, 0L);
            cells.add(Map.of("date", d.toString(), "events", n));
            total += n;
            max = Math.max(max, n);
            if (n > 0) active++;
        }
        Map<String, Object> out = new LinkedHashMap<>();
        out.put("from", from.toString());
        out.put("to", to.toString());
        out.put("unit", "sự kiện học tập / ngày");
        out.put("total_events", total);
        out.put("active_days", active);
        out.put("max_events", max);
        out.put("has_data", total > 0);
        out.put("days", cells);
        return out;
    }

    /**
     * The current streak counts consecutive active days ending today, or ending yesterday when
     * today has no activity yet, so a student is never shown a broken streak mid-day.
     */
    static Map<String, Object> streak(Map<LocalDate, Long> events, LocalDate today) {
        LocalDate cursor = events.getOrDefault(today, 0L) > 0 ? today : today.minusDays(1);
        int current = 0;
        while (events.getOrDefault(cursor, 0L) > 0) {
            current++;
            cursor = cursor.minusDays(1);
        }
        int longest = 0, run = 0;
        LocalDate last = null;
        for (LocalDate d = today.minusDays(STREAK_HORIZON_DAYS - 1L); !d.isAfter(today); d = d.plusDays(1)) {
            if (events.getOrDefault(d, 0L) > 0) {
                run++;
                longest = Math.max(longest, run);
                last = d;
            } else {
                run = 0;
            }
        }
        Map<String, Object> out = new LinkedHashMap<>();
        out.put("current_days", current);
        out.put("longest_days", longest);
        out.put("horizon_days", STREAK_HORIZON_DAYS);
        out.put("last_active_date", last == null ? null : last.toString());
        out.put("note", "Chuỗi ngày tính theo ngày có ít nhất một hoạt động học tập được LMS ghi nhận. "
            + "Nghỉ ngơi hợp lý cũng là một phần của việc học.");
        return out;
    }

    static Map<String, Object> timeline(List<Map<String, Object>> completions, List<Map<String, Object>> courses,
                                        LocalDate windowStart, LocalDate today) {
        long totalTracked = 0;
        for (Map<String, Object> c : courses) totalTracked += lng(c.get("total_tracked_activities"));
        long totalCompleted = 0;
        for (Map<String, Object> c : completions) totalCompleted += lng(c.get("completed"));

        LocalDate firstWeek = windowStart.with(TemporalAdjusters.previousOrSame(DayOfWeek.MONDAY));
        long baseline = 0;
        Map<LocalDate, Long> perWeek = new HashMap<>();
        long recent = 0, previous = 0;
        for (Map<String, Object> c : completions) {
            LocalDate d = date(c.get("day"));
            if (d == null) continue;
            long n = lng(c.get("completed"));
            if (d.isBefore(firstWeek)) baseline += n;
            else if (!d.isAfter(today)) perWeek.merge(d.with(TemporalAdjusters.previousOrSame(DayOfWeek.MONDAY)), n, Long::sum);
            if (!d.isBefore(today.minusDays(6)) && !d.isAfter(today)) recent += n;
            else if (!d.isBefore(today.minusDays(13)) && d.isBefore(today.minusDays(6))) previous += n;
        }

        List<Map<String, Object>> points = new ArrayList<>();
        long cumulative = baseline;
        for (LocalDate w = firstWeek; !w.isAfter(today); w = w.plusWeeks(1)) {
            long n = perWeek.getOrDefault(w, 0L);
            cumulative += n;
            Map<String, Object> p = new LinkedHashMap<>();
            p.put("week_start", w.toString());
            p.put("completed_in_week", n);
            p.put("cumulative_completed", cumulative);
            p.put("cumulative_percent", totalTracked > 0 ? round1(cumulative * 100.0 / totalTracked) : null);
            points.add(p);
        }

        String direction;
        if (recent + previous < MIN_COMPLETIONS_FOR_TREND) direction = "insufficient";
        else if (recent > previous) direction = "up";
        else if (recent < previous) direction = "down";
        else direction = "flat";

        Map<String, Object> trend = new LinkedHashMap<>();
        trend.put("direction", direction);
        trend.put("recent_7d", recent);
        trend.put("previous_7d", previous);

        Map<String, Object> out = new LinkedHashMap<>();
        out.put("available", totalTracked > 0 && totalCompleted > 0);
        out.put("unit", "% hoạt động đã hoàn thành (tích lũy)");
        out.put("total_tracked_activities", totalTracked);
        out.put("total_completed_activities", totalCompleted);
        out.put("points", points);
        out.put("trend", trend);
        out.put("note", "Thời điểm hoàn thành lấy theo lần cập nhật trạng thái cuối cùng trong LMS nên chỉ mang tính xấp xỉ.");
        return out;
    }

    static Map<String, Object> taskStatus(List<Map<String, Object>> tasks, long nowEpoch) {
        long completed = 0, pending = 0, dueSoon = 0, overdue = 0;
        for (Map<String, Object> t : tasks) {
            String status = str(t.get("task_status"));
            long due = lng(t.get("due_time"));
            if ("completed".equals(status)) completed++;
            else if ("overdue".equals(status)) overdue++;
            else if ("pending".equals(status)) {
                if (due > nowEpoch && due <= nowEpoch + DUE_SOON_HOURS * 3600L) dueSoon++;
                else pending++;
            }
        }
        Map<String, Object> out = new LinkedHashMap<>();
        out.put("total", tasks.size());
        out.put("completed", completed);
        out.put("pending", pending);
        out.put("due_soon", dueSoon);
        out.put("overdue", overdue);
        out.put("unit", "bài tập và bài kiểm tra");
        out.put("due_soon_hours", DUE_SOON_HOURS);
        return out;
    }

    static List<Map<String, Object>> courseProgress(List<Map<String, Object>> courses) {
        List<Map<String, Object>> out = new ArrayList<>();
        for (Map<String, Object> c : courses) {
            Map<String, Object> m = new LinkedHashMap<>();
            m.put("course_id", c.get("courseid"));
            m.put("course_name", c.get("course_name"));
            m.put("progress_percentage", num(c.get("progress_percentage")));
            m.put("completed_activities", c.get("completed_activities"));
            m.put("total_tracked_activities", c.get("total_tracked_activities"));
            m.put("pending_tasks", c.get("pending_tasks"));
            m.put("overdue_tasks", c.get("overdue_tasks"));
            m.put("days_since_last_activity", c.get("days_since_last_activity"));
            out.add(m);
        }
        return out;
    }

    static List<Map<String, Object>> upcomingDeadlines(List<Map<String, Object>> tasks, long nowEpoch) {
        List<Map<String, Object>> upcoming = new ArrayList<>();
        for (Map<String, Object> t : tasks) {
            long due = lng(t.get("due_time"));
            if (!"pending".equals(str(t.get("task_status"))) || due <= nowEpoch) continue;
            Map<String, Object> m = new LinkedHashMap<>();
            m.put("title", t.get("title"));
            m.put("task_type", t.get("task_type"));
            m.put("course_id", t.get("courseid"));
            m.put("course_name", t.get("course_name"));
            m.put("due_time", due);
            m.put("hours_left", (due - nowEpoch) / 3600);
            m.put("coursemoduleid", t.get("coursemoduleid"));
            m.put("moodle_path", t.get("moodle_path"));
            upcoming.add(m);
        }
        upcoming.sort(Comparator.comparingLong(m -> (Long) m.get("due_time")));
        return upcoming.size() > 6 ? new ArrayList<>(upcoming.subList(0, 6)) : upcoming;
    }

    // ------------------------------------------------------------------ rule-based suggestions

    static List<Map<String, Object>> suggestions(Map<String, Object> taskStatus, List<Map<String, Object>> courses,
                                                 Map<String, Object> streak, List<Map<String, Object>> goalList) {
        List<Map<String, Object>> out = new ArrayList<>();
        long overdue = lng(taskStatus.get("overdue")), dueSoon = lng(taskStatus.get("due_soon"));
        long total = lng(taskStatus.get("total"));

        if (overdue > 0) {
            out.add(suggestion("OVERDUE_TASKS", "attention", "Có " + overdue + " việc đã quá hạn",
                "Hạn nộp trong LMS đã qua và chưa ghi nhận bài nộp hoặc lượt làm bài hoàn tất.",
                Map.of("overdue", overdue), action("open_tasks", null)));
        }
        if (dueSoon >= 3) {
            out.add(suggestion("DUE_SOON", "attention", dueSoon + " việc sắp đến hạn trong " + DUE_SOON_HOURS + " giờ",
                "Nhiều việc cùng gần hạn. Nên sắp xếp thứ tự ưu tiên sớm.",
                Map.of("due_soon", dueSoon), action("open_tasks", null)));
        } else if (dueSoon > 0) {
            out.add(suggestion("DUE_SOON", "info", dueSoon + " việc sắp đến hạn trong " + DUE_SOON_HOURS + " giờ",
                "Có việc chưa hoàn thành với hạn trong " + DUE_SOON_HOURS + " giờ tới.",
                Map.of("due_soon", dueSoon), action("open_tasks", null)));
        }
        for (Map<String, Object> c : courses) {
            Double progress = num(c.get("progress_percentage"));
            Long courseId = lng(c.get("courseid"));
            String name = str(c.get("course_name"));
            Object inactive = c.get("days_since_last_activity");
            if (inactive instanceof Number n && n.intValue() >= INACTIVE_NOTICE_DAYS) {
                int d = n.intValue();
                out.add(suggestion("INACTIVE_COURSE", d >= INACTIVE_ATTENTION_DAYS ? "attention" : "info",
                    "Chưa có hoạt động ở " + name + " trong " + d + " ngày",
                    "Lần hoạt động gần nhất ở khóa học này cách đây " + d + " ngày theo nhật ký LMS.",
                    Map.of("days_since_last_activity", d, "course_id", courseId), action("open_course", courseId)));
            }
            if (progress != null && lng(c.get("total_tracked_activities")) > 0 && progress < LOW_PROGRESS_PERCENT) {
                out.add(suggestion("LOW_PROGRESS", "info", "Tiến độ " + name + " đang ở " + round1(progress) + "%",
                    "Mức này thấp hơn mốc " + (int) LOW_PROGRESS_PERCENT
                        + "% mà ứng dụng dùng để nhắc. Xem nội dung tiếp theo có thể giúp bạn tiến nhanh hơn.",
                    Map.of("progress_percentage", round1(progress), "course_id", courseId),
                    action("open_course", courseId)));
            }
        }
        for (Map<String, Object> g : goalList) {
            if (!"active".equals(g.get("status"))) continue;
            String attention = str(g.get("attention"));
            if (attention == null) continue;
            String label = goalLabel(g);
            out.add(suggestion("GOAL_BEHIND", "attention", "Mục tiêu \"" + label + "\" cần được chú ý",
                "BEHIND_PACE".equals(attention)
                    ? "Tiến độ thực tế thấp hơn tiến độ kỳ vọng theo thời gian còn lại."
                    : "Mục tiêu sắp đến hạn nhưng chưa đạt.",
                Map.of("goal_id", g.get("id"), "progress_percent", String.valueOf(g.get("progress_percent"))),
                action("open_goals", null)));
        }
        for (Map<String, Object> g : goalList) {
            if ("completed".equals(g.get("status")) && "active".equals(g.get("stored_status"))) {
                out.add(suggestion("GOAL_ACHIEVED", "positive", "Bạn đã đạt mục tiêu \"" + goalLabel(g) + "\"",
                    "Số liệu hiện tại đã đạt hoặc vượt giá trị mục tiêu.",
                    Map.of("goal_id", g.get("id")), action("open_goals", null)));
                break;
            }
        }
        long current = lng(streak.get("current_days"));
        if (current >= 3) {
            out.add(suggestion("STREAK_POSITIVE", "positive", "Bạn đã học " + current + " ngày liên tiếp",
                "Duy trì nhịp học đều là tốt; hãy nhớ nghỉ ngơi hợp lý.",
                Map.of("current_days", current), action("none", null)));
        }
        if (out.stream().noneMatch(s -> "attention".equals(s.get("severity"))) && total > 0 && overdue == 0) {
            out.add(suggestion("ALL_CLEAR", "positive", "Bạn đang theo kịp các việc cần làm",
                "Không có việc quá hạn và không có cụm hạn nộp dồn trong " + DUE_SOON_HOURS + " giờ tới.",
                Map.of("total_tasks", total), action("none", null)));
        }
        out.sort(Comparator.comparingInt(s -> severityRank(str(s.get("severity")))));
        return out.size() > MAX_SUGGESTIONS ? new ArrayList<>(out.subList(0, MAX_SUGGESTIONS)) : out;
    }

    private static int severityRank(String severity) {
        return switch (severity == null ? "" : severity) {
            case "attention" -> 0;
            case "info" -> 1;
            default -> 2;
        };
    }

    private static Map<String, Object> suggestion(String code, String severity, String title, String reason,
                                                  Map<String, Object> evidence, Map<String, Object> action) {
        Map<String, Object> m = new LinkedHashMap<>();
        m.put("code", code);
        m.put("severity", severity);
        m.put("title", title);
        m.put("reason", reason);
        m.put("evidence", evidence);
        m.put("action", action);
        m.put("created_at", Instant.now().toString());
        return m;
    }

    private static Map<String, Object> action(String type, Long courseId) {
        Map<String, Object> m = new LinkedHashMap<>();
        m.put("type", type);
        m.put("course_id", courseId);
        return m;
    }

    static String goalLabel(Map<String, Object> goal) {
        String type = str(goal.get("goal_type"));
        Object target = goal.get("target_value");
        String t = target instanceof Number n && n.doubleValue() % 1 == 0 ? String.valueOf(n.longValue()) : String.valueOf(target);
        return switch (type == null ? "" : type) {
            case "completion_percentage" -> "Hoàn thành " + t + "% tiến độ";
            case "target_grade" -> "Điểm trung bình " + t + "%";
            case "activity_count" -> "Hoàn thành " + t + " hoạt động";
            default -> "Mục tiêu học tập";
        };
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
