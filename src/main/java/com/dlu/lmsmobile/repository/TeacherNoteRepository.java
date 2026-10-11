package com.dlu.lmsmobile.repository;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class TeacherNoteRepository {
    private final JdbcTemplate jdbc;

    public TeacherNoteRepository(JdbcTemplate jdbc) {
        this.jdbc = jdbc;
    }

    public List<Map<String, Object>> findByTeacherId(Long teacherId, Long courseId, Long studentId) {
        StringBuilder sql = new StringBuilder("SELECT * FROM app.teacher_notes WHERE teacher_id = ?");
        if (courseId != null) sql.append(" AND course_id = ").append(courseId);
        if (studentId != null) sql.append(" AND student_id = ").append(studentId);
        sql.append(" ORDER BY created_at DESC");
        return jdbc.queryForList(sql.toString(), teacherId);
    }

    public void save(Long teacherId, Long studentId, Long courseId, String note, String status) {
        jdbc.update("INSERT INTO app.teacher_notes (teacher_id, student_id, course_id, note, status) VALUES (?, ?, ?, ?, ?)",
                teacherId, studentId, courseId, note, status != null ? status : "active");
    }

    public int updateStatus(Long id, Long teacherId, String status) {
        return jdbc.update("UPDATE app.teacher_notes SET status = ? WHERE id = ? AND teacher_id = ?",
                status, id, teacherId);
    }
}
