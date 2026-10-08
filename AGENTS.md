# LMS Mobile Backend - Agent Instructions

## Project goal
Đây là backend Spring Boot cho đề tài:
"Xây dựng ứng dụng di động và hỗ trợ học tập trên nền tảng LMS".

Trọng tâm là HỖ TRỢ HỌC TẬP.
Learning Analytics chỉ là chức năng phụ trợ.

## Architecture
Flutter -> REST API -> Spring Boot -> PostgreSQL

PostgreSQL database:
lms_mobile_learning

Schemas:
- lms: Moodle/source representation
- app: application-owned data
- derived: read models / analytics views

## Technology
- Java
- Spring Boot
- Maven
- JdbcTemplate
- PostgreSQL

## Database safety - CRITICAL
NEVER:
- ALTER USER
- ALTER ROLE
- change PostgreSQL passwords
- edit pg_hba.conf
- brute-force or guess passwords
- DROP DATABASE
- DROP SCHEMA
- DROP TABLE
- TRUNCATE
- DELETE data unless explicitly requested by the user
- modify PostgreSQL server configuration
- invent tables or columns

If database authentication fails:
STOP and report the error.
Do not attempt to repair credentials automatically.

## Moodle boundary
The mobile app must NOT rebuild Moodle core operations.

Mobile may:
- aggregate tasks
- show progress
- show grades
- show attendance
- show reminders
- show learning content
- show submission/quiz status
- navigate to Moodle

Moodle remains responsible for:
- assignment submission
- quiz taking
- grading
- other core LMS operations

## Moodle deep links
Moodle activity links must use course_modules.id.

Example:
/mod/assign/view.php?id=<coursemoduleid>

Do not use assign.id or quiz.id as the URL id.

## Testing
After backend changes run:

.\mvnw.cmd clean test

Do not claim success unless tests pass.