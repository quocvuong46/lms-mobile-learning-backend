package com.dlu.lmsmobile;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.List;
import java.util.Map;

@SpringBootTest
class SchemaVerificationTest {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Test
    void verifyColumns() {
        String sql = """
            SELECT
                table_name,
                column_name,
                data_type
            FROM information_schema.columns
            WHERE table_schema = 'derived'
              AND table_name IN (
                  'student_course_learning_items',
                  'student_grade_overview',
                  'student_grade_category_summary',
                  'student_attendance_summary'
              )
            ORDER BY table_name, ordinal_position;
            """;
        List<Map<String, Object>> columns = jdbcTemplate.queryForList(sql);
        System.out.println("=== DB COLUMNS VERIFICATION START ===");
        for (Map<String, Object> col : columns) {
            System.out.println(col.get("table_name") + " | " + col.get("column_name") + " | " + col.get("data_type"));
        }
        System.out.println("=== DB COLUMNS VERIFICATION END ===");
    }
}
