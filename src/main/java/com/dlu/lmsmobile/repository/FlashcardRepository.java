package com.dlu.lmsmobile.repository;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class FlashcardRepository {
    private final JdbcTemplate jdbc;

    public FlashcardRepository(JdbcTemplate jdbc) {
        this.jdbc = jdbc;
    }

    public List<Map<String, Object>> findByCourseIdAndUserId(Long courseId, Long userId) {
        return jdbc.queryForList("SELECT * FROM app.flashcards WHERE course_id = ? AND userid = ? ORDER BY created_at DESC", courseId, userId);
    }

    public void save(Long courseId, Long userId, String frontText, String backText) {
        jdbc.update("INSERT INTO app.flashcards (course_id, userid, front_text, back_text) VALUES (?, ?, ?, ?)",
                courseId, userId, frontText, backText);
    }

    public int update(Long id, Long userId, String frontText, String backText) {
        return jdbc.update("UPDATE app.flashcards SET front_text = ?, back_text = ? WHERE id = ? AND userid = ?",
                frontText, backText, id, userId);
    }

    public int delete(Long id, Long userId) {
        return jdbc.update("DELETE FROM app.flashcards WHERE id = ? AND userid = ?", id, userId);
    }

}
