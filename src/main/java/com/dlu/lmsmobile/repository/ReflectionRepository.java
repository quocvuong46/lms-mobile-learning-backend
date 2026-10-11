package com.dlu.lmsmobile.repository;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class ReflectionRepository {
    private final JdbcTemplate jdbc;

    public ReflectionRepository(JdbcTemplate jdbc) {
        this.jdbc = jdbc;
    }

    public List<Map<String, Object>> findByUserId(Long userId, Long courseId) {
        if (courseId != null) {
            return jdbc.queryForList("SELECT * FROM app.learning_reflections WHERE user_id = ? AND course_id = ? ORDER BY created_at DESC", userId, courseId);
        }
        return jdbc.queryForList("SELECT * FROM app.learning_reflections WHERE user_id = ? ORDER BY created_at DESC", userId);
    }

    public void save(Long userId, Long courseId, String content, Integer understandingLevel) {
        jdbc.update("INSERT INTO app.learning_reflections (user_id, course_id, content, understanding_level) VALUES (?, ?, ?, ?)",
                userId, courseId, content, understandingLevel);
    }
}
