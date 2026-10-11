package com.dlu.lmsmobile;

import com.dlu.lmsmobile.controller.StudentInsightsController;
import com.dlu.lmsmobile.controller.TeacherInsightsController;
import com.dlu.lmsmobile.exception.GlobalExceptionHandler;
import com.dlu.lmsmobile.repository.InsightsRepository;
import com.dlu.lmsmobile.repository.StudentRepository;
import com.dlu.lmsmobile.repository.TeacherRepository;
import com.dlu.lmsmobile.service.ClassInsightsService;
import com.dlu.lmsmobile.service.GoalService;
import com.dlu.lmsmobile.service.InsightsService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.Clock;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.*;

import static org.hamcrest.Matchers.*;
import static org.junit.jupiter.api.Assertions.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

/**
 * Standalone MVC tests for learning insights, goals and class insights.
 * Repositories are in-memory fixtures; no Spring context or database is started.
 */
class InsightsApiTest {
    private static final ZoneId ZONE = ZoneId.of("Asia/Ho_Chi_Minh");
    private final Clock clock = Clock.fixed(Instant.parse("2026-10-09T03:00:00Z"), ZONE);
    private final LocalDate today = LocalDate.of(2026, 10, 9);
    private final long now = clock.instant().getEpochSecond();

    private final List<String> reads = new ArrayList<>();
    private final List<Map<String, Object>> courses = new ArrayList<>();
    private final List<Map<String, Object>> tasks = new ArrayList<>();
    private FakeInsights fake;
    private List<Map<String, Object>> roster = new ArrayList<>();
    private List<Map<String, Object>> activities = new ArrayList<>();
    private MockMvc mvc;

    /** In-memory stand-in for InsightsRepository. Goals are keyed by owner like the real SQL. */
    private class FakeInsights extends InsightsRepository {
        final Map<LocalDate, Long> events = new HashMap<>();
        final List<Map<String, Object>> completions = new ArrayList<>();
        final List<Map<String, Object>> analytics = new ArrayList<>();
        final List<Map<String, Object>> goalRows = new ArrayList<>();
        final Set<String> enrolled = new HashSet<>(Set.of("205:14"));
        long nextId = 1;

        FakeInsights() {
            super(null);
        }

        @Override
        public List<Map<String, Object>> findStudentActivityByDay(Long userId, long since) {
            reads.add("events:" + userId);
            List<Map<String, Object>> rows = new ArrayList<>();
            events.forEach((d, n) -> rows.add(Map.of("day", d, "events", n)));
            return rows;
        }

        @Override
        public List<Map<String, Object>> findStudentCompletionsByDay(Long userId) {
            return completions;
        }

        @Override
        public List<Map<String, Object>> findLearningAnalytics(Long userId) {
            return analytics;
        }

        @Override
        public boolean isEnrolled(Long userId, Long courseId) {
            return enrolled.contains(userId + ":" + courseId);
        }

        @Override
        public List<Map<String, Object>> findGoals(Long userId) {
            return goalRows.stream().filter(g -> userId.equals(g.get("user_id"))).toList();
        }

        @Override
        public List<Map<String, Object>> findGoal(Long userId, Long goalId) {
            return goalRows.stream().filter(g -> userId.equals(g.get("user_id")) && goalId.equals(g.get("id"))).toList();
        }

        @Override
        public int countActiveGoals(Long userId) {
            return (int) goalRows.stream()
                .filter(g -> userId.equals(g.get("user_id")) && "active".equals(g.get("status"))).count();
        }

        @Override
        public long insertGoal(Long userId, Long courseId, String type, BigDecimal target, LocalDate start, LocalDate end) {
            return addGoal(userId, courseId, type, target.doubleValue(), start, end, "active");
        }

        @Override
        public int cancelGoal(Long userId, Long goalId) {
            for (Map<String, Object> g : goalRows) {
                if (userId.equals(g.get("user_id")) && goalId.equals(g.get("id")) && "active".equals(g.get("status"))) {
                    g.put("status", "cancelled");
                    return 1;
                }
            }
            return 0;
        }

        long addGoal(Long userId, Long courseId, String type, double target, LocalDate start, LocalDate end, String status) {
            Map<String, Object> row = new HashMap<>();
            row.put("id", nextId);
            row.put("user_id", userId);
            row.put("course_id", courseId);
            row.put("course_name", courseId == null ? null : "Mobile");
            row.put("goal_type", type);
            row.put("target_value", target);
            row.put("start_date", start);
            row.put("end_date", end);
            row.put("status", status);
            row.put("created_at", Timestamp.from(clock.instant()));
            goalRows.add(row);
            return nextId++;
        }

        // Teacher-side aggregates
        List<Map<String, Object>> classTasks = new ArrayList<>();
        List<Map<String, Object>> classEngagement = new ArrayList<>();
        List<Map<String, Object>> classCompletions = new ArrayList<>();

        @Override
        public List<Map<String, Object>> findClassTaskStatus(Long teacherId, Long courseId) {
            reads.add("classTasks:" + teacherId + ":" + courseId);
            return classTasks;
        }

        @Override
        public List<Map<String, Object>> findClassEngagementByWeek(Long teacherId, Long courseId, long since) {
            reads.add("classEngagement");
            return classEngagement;
        }

        @Override
        public List<Map<String, Object>> findClassCompletionsByWeek(Long teacherId, Long courseId, long since) {
            return classCompletions;
        }
    }

    private Map<String, Object> course(double progress, Integer inactiveDays) {
        Map<String, Object> c = new HashMap<>();
        c.put("courseid", 14L);
        c.put("course_name", "Mobile");
        c.put("progress_percentage", progress);
        c.put("total_tracked_activities", 10L);
        c.put("completed_activities", Math.round(progress / 10));
        c.put("pending_tasks", 2L);
        c.put("overdue_tasks", 0L);
        c.put("days_since_last_activity", inactiveDays);
        return c;
    }

    private Map<String, Object> task(String status, long dueOffsetHours) {
        Map<String, Object> t = new HashMap<>();
        t.put("title", "Bài " + tasks.size());
        t.put("task_type", "assignment");
        t.put("courseid", 14L);
        t.put("course_name", "Mobile");
        t.put("task_status", status);
        t.put("due_time", now + dueOffsetHours * 3600);
        t.put("coursemoduleid", 24000L + tasks.size());
        t.put("moodle_path", "/mod/assign/view.php?id=" + (24000 + tasks.size()));
        return t;
    }

    @BeforeEach
    void setup() {
        fake = new FakeInsights();
        var students = new StudentRepository(null) {
            @Override
            public List<Map<String, Object>> findCoursesByUserId(Long userId) {
                return courses;
            }

            @Override
            public List<Map<String, Object>> findAllTasks(Long userId) {
                return tasks;
            }
        };
        var teachers = new TeacherRepository(null) {
            @Override
            public boolean hasCourse(Long teacherId, Long courseId) {
                reads.add("hasCourse:" + teacherId + ":" + courseId);
                return teacherId == 102 && courseId == 14;
            }

            @Override
            public List<Map<String, Object>> findStudents(Long teacherId, Long courseId) {
                reads.add("roster");
                return roster;
            }

            @Override
            public List<Map<String, Object>> findActivities(Long teacherId, Long courseId, String type) {
                return activities.stream().filter(a -> type.equals(a.get("task_type"))).toList();
            }
        };
        var goals = new GoalService(fake, students, clock);
        var insights = new InsightsService(fake, students, goals, clock, "demo");
        var classInsights = new ClassInsightsService(teachers, fake, clock, "demo");
        mvc = MockMvcBuilders.standaloneSetup(new StudentInsightsController(insights, goals),
                new TeacherInsightsController(classInsights))
            .setControllerAdvice(new GlobalExceptionHandler()).build();
    }

    // ------------------------------------------------------------------ student insights

    @Test
    void insightsReportStreakHeatmapAndTaskDistribution() throws Exception {
        fake.events.put(today, 3L);
        fake.events.put(today.minusDays(1), 2L);
        fake.events.put(today.minusDays(2), 1L);
        fake.events.put(today.minusDays(4), 4L);
        courses.add(course(60, 1));
        tasks.add(task("completed", -5));
        tasks.add(task("overdue", -30));
        tasks.add(task("pending", 5));
        tasks.add(task("pending", 20));
        tasks.add(task("pending", 40));
        tasks.add(task("pending", 200));

        mvc.perform(get("/api/v1/dev/students/205/insights")).andExpect(status().isOk())
            .andExpect(jsonPath("$.data_mode").value("demo"))
            .andExpect(jsonPath("$.data_notice").isNotEmpty())
            .andExpect(jsonPath("$.range_days").value(56))
            .andExpect(jsonPath("$.activity_heatmap.days", hasSize(56)))
            .andExpect(jsonPath("$.activity_heatmap.total_events").value(10))
            .andExpect(jsonPath("$.activity_heatmap.active_days").value(4))
            .andExpect(jsonPath("$.activity_heatmap.days[55].date").value("2026-10-09"))
            .andExpect(jsonPath("$.activity_heatmap.days[55].events").value(3))
            .andExpect(jsonPath("$.streak.current_days").value(3))
            .andExpect(jsonPath("$.streak.longest_days").value(3))
            .andExpect(jsonPath("$.streak.last_active_date").value("2026-10-09"))
            .andExpect(jsonPath("$.task_status.total").value(6))
            .andExpect(jsonPath("$.task_status.completed").value(1))
            .andExpect(jsonPath("$.task_status.overdue").value(1))
            .andExpect(jsonPath("$.task_status.due_soon").value(3))
            .andExpect(jsonPath("$.task_status.pending").value(1))
            .andExpect(jsonPath("$.upcoming_deadlines[0].hours_left").value(5))
            .andExpect(jsonPath("$.upcoming_deadlines[0].moodle_path", startsWith("/mod/assign/view.php?id=")))
            .andExpect(jsonPath("$.course_progress[0].progress_percentage").value(60.0));
        assertEquals(List.of("events:205"), reads);
    }

    @Test
    void streakIsNotBrokenBeforeTodaysFirstActivity() throws Exception {
        fake.events.put(today.minusDays(1), 2L);
        fake.events.put(today.minusDays(2), 1L);
        mvc.perform(get("/api/v1/dev/students/205/insights")).andExpect(status().isOk())
            .andExpect(jsonPath("$.streak.current_days").value(2));
    }

    @Test
    void emptyDataDoesNotInventTrendsOrReassurance() throws Exception {
        mvc.perform(get("/api/v1/dev/students/205/insights")).andExpect(status().isOk())
            .andExpect(jsonPath("$.activity_heatmap.has_data").value(false))
            .andExpect(jsonPath("$.streak.current_days").value(0))
            .andExpect(jsonPath("$.progress_timeline.available").value(false))
            .andExpect(jsonPath("$.progress_timeline.trend.direction").value("insufficient"))
            .andExpect(jsonPath("$.suggestions", hasSize(0)));
    }

    @Test
    void rangeIsClampedAndWeeklyTimelineUsesCompletionHistory() throws Exception {
        courses.add(course(40, 0));
        fake.completions.add(Map.of("day", today.minusDays(40), "courseid", 14L, "completed", 1L));
        fake.completions.add(Map.of("day", today.minusDays(9), "courseid", 14L, "completed", 1L));
        fake.completions.add(Map.of("day", today.minusDays(2), "courseid", 14L, "completed", 2L));
        mvc.perform(get("/api/v1/dev/students/205/insights").param("days", "7")).andExpect(status().isOk())
            .andExpect(jsonPath("$.range_days").value(14))
            .andExpect(jsonPath("$.progress_timeline.available").value(true))
            .andExpect(jsonPath("$.progress_timeline.total_completed_activities").value(4))
            // 1 of 10 tracked activities was completed before the window; all 4 by the last week.
            .andExpect(jsonPath("$.progress_timeline.points[0].cumulative_percent").value(10.0))
            .andExpect(jsonPath("$.progress_timeline.points[-1:].cumulative_percent").value(hasItem(40.0)))
            .andExpect(jsonPath("$.progress_timeline.trend.recent_7d").value(2))
            .andExpect(jsonPath("$.progress_timeline.trend.previous_7d").value(1))
            .andExpect(jsonPath("$.progress_timeline.trend.direction").value("up"));
    }

    @Test
    void suggestionsCarryReasonEvidenceAndAction() throws Exception {
        courses.add(course(20, 15));
        tasks.add(task("overdue", -30));
        tasks.add(task("pending", 5));
        tasks.add(task("pending", 10));
        tasks.add(task("pending", 20));
        mvc.perform(get("/api/v1/dev/students/205/insights")).andExpect(status().isOk())
            .andExpect(jsonPath("$.suggestions[?(@.code=='OVERDUE_TASKS')].severity").value(hasItem("attention")))
            .andExpect(jsonPath("$.suggestions[?(@.code=='DUE_SOON')].evidence.due_soon").value(hasItem(3)))
            .andExpect(jsonPath("$.suggestions[?(@.code=='INACTIVE_COURSE')].action.type").value(hasItem("open_course")))
            .andExpect(jsonPath("$.suggestions[?(@.code=='INACTIVE_COURSE')].action.course_id").value(hasItem(14)))
            .andExpect(jsonPath("$.suggestions[?(@.code=='LOW_PROGRESS')].reason").isNotEmpty())
            .andExpect(jsonPath("$.suggestions[0].severity").value("attention"))
            .andExpect(jsonPath("$.suggestions[?(@.code=='ALL_CLEAR')]").isEmpty());
    }

    @Test
    void allClearOnlyWhenTasksExistAndNothingNeedsAttention() throws Exception {
        courses.add(course(80, 1));
        tasks.add(task("completed", -5));
        tasks.add(task("pending", 200));
        mvc.perform(get("/api/v1/dev/students/205/insights")).andExpect(status().isOk())
            .andExpect(jsonPath("$.suggestions[0].code").value("ALL_CLEAR"))
            .andExpect(jsonPath("$.suggestions[0].severity").value("positive"));
    }

    // ------------------------------------------------------------------ goals

    @Test
    void createGoalReturnsComputedProgressForOwnerOnly() throws Exception {
        courses.add(course(60, 1));
        mvc.perform(post("/api/v1/dev/students/205/goals").contentType(MediaType.APPLICATION_JSON)
                .content("{\"goal_type\":\"completion_percentage\",\"target_value\":80,\"course_id\":14,"
                    + "\"end_date\":\"2026-12-01\"}"))
            .andExpect(status().isCreated())
            .andExpect(jsonPath("$.goal_type").value("completion_percentage"))
            .andExpect(jsonPath("$.current_value").value(60.0))
            .andExpect(jsonPath("$.progress_percent").value(75.0))
            .andExpect(jsonPath("$.status").value("active"))
            .andExpect(jsonPath("$.start_date").value("2026-10-09"))
            .andExpect(jsonPath("$.end_date").value("2026-12-01"));
        mvc.perform(get("/api/v1/dev/students/205/goals")).andExpect(status().isOk())
            .andExpect(jsonPath("$", hasSize(1)));
        mvc.perform(get("/api/v1/dev/students/206/goals")).andExpect(status().isOk())
            .andExpect(jsonPath("$", hasSize(0)));
    }

    @Test
    void invalidGoalsAreRejectedWithoutWriting() throws Exception {
        String[] bodies = {
            "{\"goal_type\":\"study_minutes\",\"target_value\":300}",
            "{\"goal_type\":\"mystery\",\"target_value\":5}",
            "{\"goal_type\":\"completion_percentage\",\"target_value\":150}",
            "{\"goal_type\":\"activity_count\",\"target_value\":2.5}",
            "{\"goal_type\":\"activity_count\",\"target_value\":5,\"course_id\":99}",
            "{\"goal_type\":\"activity_count\",\"target_value\":5,\"end_date\":\"2026-01-01\"}",
            "{\"target_value\":5}"
        };
        for (String body : bodies) {
            mvc.perform(post("/api/v1/dev/students/205/goals").contentType(MediaType.APPLICATION_JSON).content(body))
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.message").isNotEmpty());
        }
        assertTrue(fake.goalRows.isEmpty());
    }

    @Test
    void goalLimitIsEnforced() throws Exception {
        for (int i = 0; i < 10; i++) fake.addGoal(205L, null, "activity_count", 5, today, null, "active");
        mvc.perform(post("/api/v1/dev/students/205/goals").contentType(MediaType.APPLICATION_JSON)
                .content("{\"goal_type\":\"activity_count\",\"target_value\":5}"))
            .andExpect(status().isBadRequest());
    }

    @Test
    void cancelIsSoftAndCannotTouchAnotherStudentsGoal() throws Exception {
        long id = fake.addGoal(205L, null, "activity_count", 5, today, null, "active");
        mvc.perform(post("/api/v1/dev/students/206/goals/" + id + "/cancel")).andExpect(status().isNotFound());
        assertEquals("active", fake.goalRows.get(0).get("status"));
        mvc.perform(post("/api/v1/dev/students/205/goals/" + id + "/cancel")).andExpect(status().isOk())
            .andExpect(jsonPath("$.status").value("cancelled"));
        mvc.perform(post("/api/v1/dev/students/205/goals/" + id + "/cancel")).andExpect(status().isNotFound());
        assertEquals(1, fake.goalRows.size(), "goals are never deleted");
    }

    @Test
    void goalStatusIsDerivedFromDataWithoutWritingBack() throws Exception {
        courses.add(course(90, 1));
        fake.addGoal(205L, 14L, "completion_percentage", 80, today.minusDays(10), today.plusDays(20), "active");
        fake.addGoal(205L, 14L, "completion_percentage", 95, today.minusDays(40), today.minusDays(1), "active");
        mvc.perform(get("/api/v1/dev/students/205/goals")).andExpect(status().isOk())
            .andExpect(jsonPath("$[?(@.target_value==80.0)].status").value(hasItem("completed")))
            .andExpect(jsonPath("$[?(@.target_value==95.0)].status").value(hasItem("expired")))
            .andExpect(jsonPath("$[?(@.target_value==95.0)].stored_status").value(hasItem("active")));
        assertTrue(fake.goalRows.stream().allMatch(g -> "active".equals(g.get("status"))),
            "reading goals must not write derived statuses back to the database");
    }

    @Test
    void activityCountGoalCountsOnlyCompletionsInsideTheGoalWindowAndFlagsPace() throws Exception {
        fake.completions.add(Map.of("day", today.minusDays(20), "courseid", 14L, "completed", 5L));
        fake.completions.add(Map.of("day", today.minusDays(3), "courseid", 14L, "completed", 1L));
        fake.completions.add(Map.of("day", today.minusDays(1), "courseid", 15L, "completed", 4L));
        // Window 10 days ago..today+9 (20 days): half elapsed, so 50% expected; 1 of 10 = 10% is behind.
        fake.addGoal(205L, 14L, "activity_count", 10, today.minusDays(10), today.plusDays(9), "active");
        mvc.perform(get("/api/v1/dev/students/205/goals")).andExpect(status().isOk())
            .andExpect(jsonPath("$[0].current_value").value(1.0))
            .andExpect(jsonPath("$[0].progress_percent").value(10.0))
            .andExpect(jsonPath("$[0].expected_percent").value(55.0))
            .andExpect(jsonPath("$[0].attention").value("BEHIND_PACE"));
        mvc.perform(get("/api/v1/dev/students/205/insights")).andExpect(status().isOk())
            .andExpect(jsonPath("$.suggestions[?(@.code=='GOAL_BEHIND')].action.type").value(hasItem("open_goals")));
    }

    @Test
    void gradeGoalWithoutGradedItemsHasNoProgressInsteadOfZero() throws Exception {
        fake.analytics.add(new HashMap<>(Map.of("courseid", 14L)));
        fake.addGoal(205L, null, "target_grade", 80, today, null, "active");
        mvc.perform(get("/api/v1/dev/students/205/goals")).andExpect(status().isOk())
            .andExpect(jsonPath("$[0].current_value").doesNotExist())
            .andExpect(jsonPath("$[0].progress_percent").doesNotExist())
            .andExpect(jsonPath("$[0].status").value("active"));
    }

    // ------------------------------------------------------------------ teacher class insights

    private Map<String, Object> student(long id, String name, double progress, String risk, long overdue, Integer inactive) {
        Map<String, Object> s = new HashMap<>();
        s.put("userid", id);
        s.put("fullname", name);
        s.put("student_code", "SV" + id);
        s.put("progress", progress);
        s.put("risk_level", risk);
        s.put("overdue_tasks", overdue);
        s.put("days_since_last_activity", inactive);
        s.put("average_grade", 70.0);
        return s;
    }

    @Test
    void classInsightsAggregateRosterWithExplainedAttentionList() throws Exception {
        roster = List.of(
            student(1, "An", 10, "HIGH", 3, 15),
            student(2, "Bình", 55, "MEDIUM", 0, 3),
            student(3, "Chi", 90, "LOW", 0, 0),
            student(4, "Dũng", 80, "LOW", 0, 1));
        fake.classTasks = List.of(
            Map.of("task_type", "assignment", "task_status", "completed", "tasks", 5L),
            Map.of("task_type", "assignment", "task_status", "overdue", "tasks", 3L),
            Map.of("task_type", "quiz", "task_status", "pending", "tasks", 2L));
        fake.classEngagement = List.of(
            Map.of("week_start", LocalDate.of(2026, 10, 5), "active_students", 3L, "events", 20L));
        activities = List.of(
            Map.of("source_id", 1L, "task_type", "assignment", "title", "Bài 1", "due_time", now - 86400,
                "student_count", 4L, "done_count", 1L),
            Map.of("source_id", 2L, "task_type", "quiz", "title", "Quiz 2", "due_time", now + 86400 * 5,
                "student_count", 4L, "done_count", 0L),
            Map.of("source_id", 3L, "task_type", "assignment", "title", "Bài 3", "due_time", now - 86400,
                "student_count", 4L, "done_count", 4L));

        mvc.perform(get("/api/v1/dev/teachers/102/courses/14/class-insights")).andExpect(status().isOk())
            .andExpect(jsonPath("$.weeks").value(8))
            .andExpect(jsonPath("$.summary.student_count").value(4))
            .andExpect(jsonPath("$.summary.average_progress").value(58.8))
            .andExpect(jsonPath("$.summary.watch_count").value(2))
            .andExpect(jsonPath("$.watch_groups.on_track").value(2))
            .andExpect(jsonPath("$.watch_groups.watch").value(1))
            .andExpect(jsonPath("$.watch_groups.needs_support").value(1))
            .andExpect(jsonPath("$.watch_criteria", not(empty())))
            .andExpect(jsonPath("$.progress_distribution[0].students").value(1))
            .andExpect(jsonPath("$.progress_distribution[3].students").value(2))
            .andExpect(jsonPath("$.attention_students", hasSize(2)))
            .andExpect(jsonPath("$.attention_students[0].fullname").value("An"))
            .andExpect(jsonPath("$.attention_students[0].reasons", hasItems("3 bài đã quá hạn",
                "15 ngày chưa hoạt động", "Tiến độ học tập dưới 30%")))
            .andExpect(jsonPath("$.attention_students[0].suggested_actions", not(empty())))
            .andExpect(jsonPath("$.task_status.total").value(10))
            .andExpect(jsonPath("$.task_status.overdue").value(3))
            .andExpect(jsonPath("$.weekly_trend.engagement_available").value(true))
            .andExpect(jsonPath("$.weekly_trend.completion_available").value(false))
            .andExpect(jsonPath("$.weekly_trend.points", hasSize(8)))
            .andExpect(jsonPath("$.weekly_trend.points[7].active_students").value(3))
            .andExpect(jsonPath("$.low_completion_activities", hasSize(2)))
            .andExpect(jsonPath("$.low_completion_activities[0].title").value("Bài 1"))
            .andExpect(jsonPath("$.low_completion_activities[0].due_passed").value(true))
            .andExpect(jsonPath("$.low_completion_activities[1].due_passed").value(false))
            .andExpect(jsonPath("$.low_completion_activities[1].note").isNotEmpty())
            .andExpect(jsonPath("$.suggested_interventions[?(@.code=='CONTACT_SUPPORT_GROUP')]").isNotEmpty());
    }

    @Test
    void teacherCannotReadClassInsightsForUnassignedCourseAndNothingIsQueried() throws Exception {
        mvc.perform(get("/api/v1/dev/teachers/101/courses/14/class-insights")).andExpect(status().isNotFound());
        mvc.perform(get("/api/v1/dev/teachers/102/courses/99/class-insights")).andExpect(status().isNotFound());
        assertEquals(List.of("hasCourse:101:14", "hasCourse:102:99"), reads);
    }

    @Test
    void classInsightsWithNoActivityDataSaysSoInsteadOfShowingZeroTrend() throws Exception {
        roster = List.of(student(1, "An", 50, "LOW", 0, null));
        mvc.perform(get("/api/v1/dev/teachers/102/courses/14/class-insights").param("weeks", "99"))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$.weeks").value(16))
            .andExpect(jsonPath("$.weekly_trend.engagement_available").value(false))
            .andExpect(jsonPath("$.attention_students", hasSize(0)))
            .andExpect(jsonPath("$.suggested_interventions", hasSize(0)));
        mvc.perform(get("/api/v1/dev/teachers/102/courses/14/class-insights").param("weeks", "0"))
            .andExpect(status().isBadRequest());
    }
}
