package com.dlu.lmsmobile.repository;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@Repository
public class StudentRepository {

    private final JdbcTemplate jdbcTemplate;

    public StudentRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    // The activity link and course name come from the already verified learning-items view.
    public List<Map<String, Object>> findAllTasks(Long userId) {
        return jdbcTemplate.queryForList(taskSelect() + " WHERE ut.userid = ? ORDER BY ut.due_time NULLS LAST, ut.courseid, ut.source_id", userId);
    }

    public List<Map<String, Object>> findContinueLearning(Long userId, Long courseId) {
        String sql = """
            SELECT cl.*, li.moodle_path, li.completion_tracking
            FROM derived.student_continue_learning cl
            JOIN derived.student_course_learning_items li ON li.userid = cl.userid AND li.coursemoduleid = cl.coursemoduleid
            LEFT JOIN derived.unified_tasks ut ON ut.userid = cl.userid AND ut.courseid = cl.courseid
              AND ut.source_id = cl.source_id AND ut.task_type = CASE WHEN cl.activity_type = 'assign' THEN 'assignment' ELSE cl.activity_type END
            WHERE cl.userid = ? AND li.visible = 1 AND li.visibleoncoursepage = 1
              AND COALESCE(ut.task_status, 'pending') <> 'completed'
            """;
        if (courseId != null) return jdbcTemplate.queryForList(sql + " AND cl.courseid = ? ORDER BY cl.courseid LIMIT 3", userId, courseId);
        return jdbcTemplate.queryForList(sql + " ORDER BY cl.courseid LIMIT 3", userId);
    }

    private String taskSelect() {
        return """
            SELECT ut.*, li.coursemoduleid, li.moodle_path
            FROM derived.unified_tasks ut
            LEFT JOIN LATERAL (
                SELECT course_name, coursemoduleid, moodle_path
                FROM derived.student_course_learning_items i
                WHERE i.userid = ut.userid AND i.courseid = ut.courseid
                  AND i.source_id = ut.source_id
                  AND i.activity_type = CASE WHEN ut.task_type = 'assignment' THEN 'assign' ELSE ut.task_type END
                ORDER BY coursemoduleid LIMIT 1
            ) li ON TRUE
            """;
    }

    public Optional<Map<String, Object>> findDashboardByUserId(Long userId) {
        String sql = """
            SELECT d.*, sap.student_code, sap.cohort_code, sap.class_code, sap.major_name
            FROM derived.student_dashboard d
            """ + AcademicProfileSql.leftJoin("d.userid") + " WHERE d.userid = ?";
        List<Map<String, Object>> list = jdbcTemplate.queryForList(sql, userId);
        if (list.isEmpty()) {
            return Optional.empty();
        }
        return Optional.of(list.get(0));
    }

    public List<Map<String, Object>> findCoursesByUserId(Long userId) {
        String sql = "SELECT * FROM derived.student_course_overview WHERE userid = ? ORDER BY courseid";
        return jdbcTemplate.queryForList(sql, userId);
    }

    public Optional<Map<String, Object>> findCourseAnalyticsByUserIdAndCourseId(Long userId, Long courseId) {
        String sql = "SELECT * FROM derived.student_learning_analytics WHERE userid = ? AND courseid = ?";
        List<Map<String, Object>> list = jdbcTemplate.queryForList(sql, userId, courseId);
        if (list.isEmpty()) {
            return Optional.empty();
        }
        return Optional.of(list.get(0));
    }

    public List<Map<String, Object>> findLearningItemsByUserIdAndCourseId(Long userId, Long courseId) {
        String sql = "SELECT * FROM derived.student_course_learning_items WHERE userid = ? AND courseid = ? ORDER BY section_number, coursemoduleid";
        return jdbcTemplate.queryForList(sql, userId, courseId);
    }

    public List<Map<String, Object>> findGradesByUserIdAndCourseId(Long userId, Long courseId) {
        String sql = "SELECT * FROM derived.student_grade_overview WHERE userid = ? AND courseid = ? ORDER BY grade_item_id";
        return jdbcTemplate.queryForList(sql, userId, courseId);
    }

    public List<Map<String, Object>> findGradeCategoriesByUserIdAndCourseId(Long userId, Long courseId) {
        String sql = "SELECT * FROM derived.student_grade_category_summary WHERE userid = ? AND courseid = ? ORDER BY category_id";
        return jdbcTemplate.queryForList(sql, userId, courseId);
    }

    public Optional<Map<String, Object>> findAttendanceByUserIdAndCourseId(Long userId, Long courseId) {
        String sql = "SELECT * FROM derived.student_attendance_summary WHERE userid = ? AND courseid = ?";
        List<Map<String, Object>> list = jdbcTemplate.queryForList(sql, userId, courseId);
        if (list.isEmpty()) {
            return Optional.empty();
        }
        return Optional.of(list.get(0));
    }

    public List<Map<String, Object>> findTasksByUserIdAndCourseId(Long userId, Long courseId) {
        String sql = """
                SELECT
                    ut.userid,
                    ut.courseid,
                    ut.task_type,
                    ut.source_id,
                    ut.title,
                    ut.due_time,
                    ut.task_status,
                    ut.source_status,
                    ut.attemptnumber,
                    ut.quiz_attempt,
                    ut.quiz_state,
                    li.coursemoduleid,
                    li.moodle_path
                FROM derived.unified_tasks ut
                LEFT JOIN derived.student_course_learning_items li
                    ON  li.userid    = ut.userid
                    AND li.courseid  = ut.courseid
                    AND li.source_id = ut.source_id
                    AND li.activity_type = CASE
                            WHEN ut.task_type = 'assignment' THEN 'assign'
                            ELSE ut.task_type
                        END
                WHERE ut.userid   = ?
                  AND ut.courseid = ?
                ORDER BY ut.due_time NULLS LAST, ut.task_type, ut.source_id
                """;
        return jdbcTemplate.queryForList(sql, userId, courseId);
    }
}
