package com.dlu.lmsmobile.repository;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@Repository
public class TeacherRepository {
    public boolean hasCourse(Long teacherId, Long courseId) {
        return Boolean.TRUE.equals(jdbcTemplate.queryForObject("""
            SELECT EXISTS (SELECT 1 FROM derived.teacher_course_overview WHERE teacherid = ? AND courseid = ?)
            """, Boolean.class, teacherId, courseId));
    }

    public List<Map<String, Object>> findStudents(Long teacherId, Long courseId) {
        // Sources and column names verified in db/schema/lms_mobile_learning_schema.sql.
        return jdbcTemplate.queryForList("""
            SELECT m.studentid AS userid, m.student_name AS fullname,
                   COALESCE(NULLIF(u.idnumber, ''), sap.student_code) AS student_code,
                   sap.cohort_code, sap.class_code, sap.major_name,
                   m.courseid, m.email, m.progress_percentage AS progress, (m.pending_tasks + m.overdue_tasks) AS pending_tasks, m.overdue_tasks,
                   m.days_since_last_activity, m.risk_level,
                   (m.risk_level IN ('MEDIUM', 'HIGH')) AS needs_attention,
                   (SELECT avg(attendance_percentage) FROM derived.student_attendance_summary att
                    WHERE att.userid = m.studentid AND att.courseid = m.courseid) AS attendance,
                   (SELECT avg(grade_percentage) FROM derived.student_grade_overview g
                    WHERE g.userid = m.studentid AND g.courseid = m.courseid) AS average_grade
            FROM derived.teacher_student_monitoring m
            JOIN lms."user" u ON u.id = m.studentid
            """ + AcademicProfileSql.leftJoin("m.studentid") + """
            WHERE m.teacherid = ? AND m.courseid = ? ORDER BY m.student_name, m.studentid
            """, teacherId, courseId);
    }

    public List<Map<String, Object>> findActivities(Long teacherId, Long courseId, String type) {
        if ("assignment".equals(type)) {
            return jdbcTemplate.queryForList("""
                SELECT a.assignment_id AS source_id, 'assignment' AS task_type, a.assignment_name AS title,
                       a.duedate AS due_time, a.student_count, a.submitted_count AS done_count,
                       a.not_submitted_count AS not_done_count, 0 AS unknown_count, a.needs_grading_count,
                       NULL::numeric AS average_grade_percentage, cm.id AS coursemoduleid,
                       CASE WHEN cm.id IS NOT NULL THEN '/mod/assign/view.php?id=' || cm.id END AS moodle_path
                FROM derived.teacher_assignment_monitoring a
                LEFT JOIN LATERAL (SELECT c.id FROM lms.course_modules c JOIN lms.modules m ON m.id = c.module
                    WHERE c.course = a.courseid AND c.instance = a.assignment_id AND m.name = 'assign'
                    AND c.deletioninprogress = 0 ORDER BY c.id LIMIT 1) cm ON TRUE
                WHERE a.teacherid = ? AND a.courseid = ? ORDER BY NULLIF(a.duedate, 0) NULLS LAST, a.assignment_id
                """, teacherId, courseId);
        }
        if (!"quiz".equals(type)) throw new IllegalArgumentException("Unsupported activity type");
        return jdbcTemplate.queryForList("""
            SELECT a.quiz_id AS source_id, 'quiz' AS task_type, a.quiz_name AS title, a.timeclose AS due_time,
                   a.student_count, a.finished_count AS done_count, a.student_count - a.finished_count AS not_done_count,
                   a.not_attempted_count, a.inprogress_count, 0 AS unknown_count, NULL::bigint AS needs_grading_count,
                   round(a.average_grade / NULLIF(q.grade, 0) * 100, 2) AS average_grade_percentage,
                   cm.id AS coursemoduleid, CASE WHEN cm.id IS NOT NULL THEN '/mod/quiz/view.php?id=' || cm.id END AS moodle_path
            FROM derived.teacher_quiz_monitoring a JOIN lms.quiz q ON q.id = a.quiz_id
            LEFT JOIN LATERAL (SELECT c.id FROM lms.course_modules c JOIN lms.modules m ON m.id = c.module
                WHERE c.course = a.courseid AND c.instance = a.quiz_id AND m.name = 'quiz'
                AND c.deletioninprogress = 0 ORDER BY c.id LIMIT 1) cm ON TRUE
            WHERE a.teacherid = ? AND a.courseid = ? ORDER BY NULLIF(a.timeclose, 0) NULLS LAST, a.quiz_id
            """, teacherId, courseId);
    }

    public List<Map<String, Object>> findActivityStudents(Long teacherId, Long courseId, String type, Long sourceId) {
        return jdbcTemplate.queryForList("""
            SELECT m.studentid AS userid, m.student_name AS fullname, NULLIF(u.idnumber, '') AS student_code,
                   m.progress_percentage AS progress, (m.pending_tasks + m.overdue_tasks) AS pending_tasks, m.overdue_tasks, m.days_since_last_activity, m.risk_level,
                   t.task_status, t.source_status, t.quiz_state,
                   CASE WHEN ? = 'assignment' THEN COALESCE(t.source_status = 'submitted', false)
                        ELSE COALESCE(t.quiz_state = 'finished', false) END AS done,
                   g.finalgrade, g.grade_percentage
            FROM derived.teacher_student_monitoring m JOIN lms."user" u ON u.id = m.studentid
            LEFT JOIN derived.unified_tasks t ON t.userid = m.studentid AND t.courseid = m.courseid
                 AND t.task_type = ? AND t.source_id = ?
            LEFT JOIN LATERAL (SELECT finalgrade, grade_percentage FROM derived.student_grade_overview gg
                WHERE gg.userid = m.studentid AND gg.courseid = m.courseid AND gg.source_id = ?
                  AND gg.activity_type = CASE WHEN ? = 'assignment' THEN 'assign' ELSE 'quiz' END
                ORDER BY gg.grade_item_id LIMIT 1) g ON TRUE
            WHERE m.teacherid = ? AND m.courseid = ? ORDER BY m.student_name, m.studentid
            """, type, type, sourceId, sourceId, type, teacherId, courseId);
    }

    private final JdbcTemplate jdbcTemplate;

    public TeacherRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<Map<String, Object>> findCoursesByTeacherId(Long teacherId) {
        String sql = "SELECT * FROM derived.teacher_course_overview WHERE teacherid = ? ORDER BY courseid";
        return jdbcTemplate.queryForList(sql, teacherId);
    }

    public Optional<Map<String, Object>> findCourseAnalyticsByTeacherIdAndCourseId(Long teacherId, Long courseId) {
        String sql = "SELECT * FROM derived.teacher_course_analytics WHERE teacherid = ? AND courseid = ?";
        List<Map<String, Object>> list = jdbcTemplate.queryForList(sql, teacherId, courseId);
        if (list.isEmpty()) {
            return Optional.empty();
        }
        return Optional.of(list.get(0));
    }
}
