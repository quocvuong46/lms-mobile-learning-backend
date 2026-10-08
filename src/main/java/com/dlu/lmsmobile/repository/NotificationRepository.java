package com.dlu.lmsmobile.repository;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Map;

@Repository
public class NotificationRepository {
    private final JdbcTemplate jdbc;
    public NotificationRepository(JdbcTemplate jdbc) { this.jdbc = jdbc; }
    public List<Map<String, Object>> findByUser(Long userId) {
        return jdbc.queryForList("""
            WITH messages AS (
                SELECT id, 'notification' AS source_kind, title, message, course_id, source_type, source_id,
                       created_at AS event_time, is_read FROM app.notifications WHERE user_id = ?
                UNION ALL
                SELECT id, 'reminder' AS source_kind, title, message, course_id, source_type, source_id,
                       remind_at AS event_time, NULL::boolean AS is_read FROM app.learning_reminders
                WHERE user_id = ? AND status IN ('scheduled', 'sent')
            )
            SELECT n.*, c.fullname AS course_name, link.coursemoduleid, link.moodle_path
            FROM messages n LEFT JOIN lms.course c ON c.id = n.course_id
            LEFT JOIN LATERAL (
                SELECT cm.id AS coursemoduleid, '/mod/' || m.name || '/view.php?id=' || cm.id AS moodle_path
                FROM lms.course_modules cm JOIN lms.modules m ON m.id = cm.module
                WHERE cm.course = n.course_id AND cm.instance = n.source_id
                  AND m.name = CASE WHEN n.source_type = 'assignment' THEN 'assign' ELSE n.source_type END
                  AND cm.deletioninprogress = 0 ORDER BY cm.id LIMIT 1
            ) link ON TRUE ORDER BY n.event_time DESC, n.source_kind, n.id DESC
            """, userId, userId);
    }
}
