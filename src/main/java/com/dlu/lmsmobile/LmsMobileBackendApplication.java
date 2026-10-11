package com.dlu.lmsmobile;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.jdbc.core.JdbcTemplate;

@SpringBootApplication
public class LmsMobileBackendApplication {

    public static void main(String[] args) {
        SpringApplication.run(LmsMobileBackendApplication.class, args);
    }

    @Bean
    public CommandLineRunner runPhaseCMigration(JdbcTemplate jdbc) {
        return args -> {
            jdbc.execute("""
                CREATE TABLE IF NOT EXISTS app.learning_reflections (
                    id BIGSERIAL PRIMARY KEY,
                    user_id BIGINT NOT NULL,
                    course_id BIGINT,
                    content TEXT NOT NULL,
                    understanding_level INT,
                    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
                );
            """);
            jdbc.execute("""
                CREATE TABLE IF NOT EXISTS app.teacher_notes (
                    id BIGSERIAL PRIMARY KEY,
                    teacher_id BIGINT NOT NULL,
                    student_id BIGINT NOT NULL,
                    course_id BIGINT,
                    note TEXT NOT NULL,
                    status VARCHAR(50) DEFAULT 'active',
                    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
                );
            """);
            jdbc.execute("""
                CREATE TABLE IF NOT EXISTS app.flashcards (
                    id BIGSERIAL PRIMARY KEY,
                    course_id BIGINT NOT NULL,
                    front_text TEXT NOT NULL,
                    back_text TEXT NOT NULL,
                    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
                );
            """);
            jdbc.execute("ALTER TABLE app.flashcards ADD COLUMN IF NOT EXISTS userid BIGINT DEFAULT 205;");
            System.out.println("PHASE C & D MIGRATION SUCCESSFUL!");
        };
    }
}
