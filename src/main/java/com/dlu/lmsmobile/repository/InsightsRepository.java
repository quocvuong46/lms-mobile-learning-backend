package com.dlu.lmsmobile.repository;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

/**
 * Read models for learning insights and CRUD for app-owned learning goals.
 *
 * <p>Sources and column names are taken from db/schema/lms_mobile_learning_schema.sql.
 * Completion filters mirror derived.student_course_progress so numbers stay consistent with
 * the progress percentage shown elsewhere. The only writes are INSERT/UPDATE on
 * app.learning_goals; nothing is ever deleted.
 */
@Repository
public class InsightsRepository {
    /** Same zone as ClockConfig.ANALYTICS_ZONE; used to bucket epoch seconds into local days. */
    private static final String ZONE = "Asia/Ho_Chi_Minh";

    private final JdbcTemplate jdbc;

    public InsightsRepository(JdbcTemplate jdbc) {
        this.jdbc = jdbc;
    }

    // ---------------------------------------------------------------- student read models

    /** Learning events per local day, limited to courses the student is enrolled in. */
    public List<Map<String, Object>> findStudentActivityByDay(Long userId, long sinceEpochSeconds) {
        return jdbc.queryForList("""
            SELECT (to_timestamp(l.timecreated) AT TIME ZONE '%s')::date AS day, count(*) AS events
            FROM lms.logstore_standard_log l
            WHERE l.userid = ? AND l.anonymous = 0 AND l.timecreated >= ?
              AND l.courseid IN (SELECT p.courseid FROM derived.student_course_progress p WHERE p.userid = ?)
            GROUP BY 1 ORDER BY 1
            """.formatted(ZONE), userId, sinceEpochSeconds, userId);
    }

    /**
     * Activity completions per local day and course. {@code day} is the last time Moodle
     * updated the completion state, which only approximates when it was completed.
     */
    public List<Map<String, Object>> findStudentCompletionsByDay(Long userId) {
        return jdbc.queryForList("""
            SELECT (to_timestamp(cmc.timemodified) AT TIME ZONE '%s')::date AS day,
                   cm.course AS courseid, count(*) AS completed
            FROM lms.course_modules_completion cmc
            JOIN lms.course_modules cm ON cm.id = cmc.coursemoduleid
            JOIN derived.student_course_progress p ON p.userid = cmc.userid AND p.courseid = cm.course
            WHERE cmc.userid = ? AND cmc.completionstate IN (1, 2, 3) AND cmc.timemodified > 0
              AND cm.completion <> 0 AND cm.deletioninprogress = 0 AND cm.visible = 1
            GROUP BY 1, 2 ORDER BY 1
            """.formatted(ZONE), userId);
    }

    public List<Map<String, Object>> findLearningAnalytics(Long userId) {
        return jdbc.queryForList(
            "SELECT * FROM derived.student_learning_analytics WHERE userid = ? ORDER BY courseid", userId);
    }

    public boolean isEnrolled(Long userId, Long courseId) {
        return Boolean.TRUE.equals(jdbc.queryForObject("""
            SELECT EXISTS (SELECT 1 FROM derived.student_course_progress WHERE userid = ? AND courseid = ?)
            """, Boolean.class, userId, courseId));
    }

    // ---------------------------------------------------------------- learning goals

    public List<Map<String, Object>> findGoals(Long userId) {
        return jdbc.queryForList(GOAL_SELECT + " WHERE g.user_id = ? "
            + "ORDER BY (g.status = 'active') DESC, g.created_at DESC, g.id DESC", userId);
    }

    public List<Map<String, Object>> findGoal(Long userId, Long goalId) {
        return jdbc.queryForList(GOAL_SELECT + " WHERE g.user_id = ? AND g.id = ?", userId, goalId);
    }

    public int countActiveGoals(Long userId) {
        Integer count = jdbc.queryForObject(
            "SELECT count(*) FROM app.learning_goals WHERE user_id = ? AND status = 'active'",
            Integer.class, userId);
        return count == null ? 0 : count;
    }

    public long insertGoal(Long userId, Long courseId, String goalType, BigDecimal targetValue,
                           LocalDate startDate, LocalDate endDate) {
        Long id = jdbc.queryForObject("""
            INSERT INTO app.learning_goals (user_id, course_id, goal_type, target_value, start_date, end_date)
            VALUES (?, ?, ?, ?, ?, ?) RETURNING id
            """, Long.class, userId, courseId, goalType, targetValue,
            java.sql.Date.valueOf(startDate), endDate == null ? null : java.sql.Date.valueOf(endDate));
        return id == null ? 0L : id;
    }

    /** Soft-cancels a goal owned by the user. Returns the number of rows changed (0 or 1). */
    public int cancelGoal(Long userId, Long goalId) {
        return jdbc.update("""
            UPDATE app.learning_goals SET status = 'cancelled', updated_at = CURRENT_TIMESTAMP
            WHERE id = ? AND user_id = ? AND status = 'active'
            """, goalId, userId);
    }

    private static final String GOAL_SELECT = """
        SELECT g.id, g.course_id, c.fullname AS course_name, g.goal_type, g.target_value,
               g.start_date, g.end_date, g.status, g.created_at, g.updated_at
        FROM app.learning_goals g LEFT JOIN lms.course c ON c.id = g.course_id
        """;

    // ---------------------------------------------------------------- teacher class read models

    private static final String ROSTER_IDS = """
        (SELECT m.studentid FROM derived.teacher_student_monitoring m WHERE m.teacherid = ? AND m.courseid = ?)
        """;

    /** Task counts by type and status for the students the teacher is responsible for. */
    public List<Map<String, Object>> findClassTaskStatus(Long teacherId, Long courseId) {
        return jdbc.queryForList("""
            SELECT ut.task_type, ut.task_status, count(*) AS tasks
            FROM derived.unified_tasks ut
            WHERE ut.courseid = ? AND ut.userid IN\s""" + ROSTER_IDS + """
            GROUP BY ut.task_type, ut.task_status
            """, courseId, teacherId, courseId);
    }

    /** Distinct active students and event counts per Monday-start week. */
    public List<Map<String, Object>> findClassEngagementByWeek(Long teacherId, Long courseId, long sinceEpochSeconds) {
        return jdbc.queryForList("""
            SELECT date_trunc('week', (to_timestamp(l.timecreated) AT TIME ZONE '%s'))::date AS week_start,
                   count(DISTINCT l.userid) AS active_students, count(*) AS events
            FROM lms.logstore_standard_log l
            WHERE l.courseid = ? AND l.anonymous = 0 AND l.timecreated >= ? AND l.userid IN\s
            """.formatted(ZONE) + ROSTER_IDS + " GROUP BY 1 ORDER BY 1",
            courseId, sinceEpochSeconds, teacherId, courseId);
    }

    /** Activity completions per Monday-start week for the teacher's students in a course. */
    public List<Map<String, Object>> findClassCompletionsByWeek(Long teacherId, Long courseId, long sinceEpochSeconds) {
        return jdbc.queryForList("""
            SELECT date_trunc('week', (to_timestamp(cmc.timemodified) AT TIME ZONE '%s'))::date AS week_start,
                   count(*) AS completed_activities
            FROM lms.course_modules_completion cmc
            JOIN lms.course_modules cm ON cm.id = cmc.coursemoduleid
            WHERE cm.course = ? AND cmc.completionstate IN (1, 2, 3) AND cmc.timemodified >= ?
              AND cm.completion <> 0 AND cm.deletioninprogress = 0 AND cm.visible = 1
              AND cmc.userid IN\s""".formatted(ZONE) + ROSTER_IDS + " GROUP BY 1 ORDER BY 1",
            courseId, sinceEpochSeconds, teacherId, courseId);
    }
}
