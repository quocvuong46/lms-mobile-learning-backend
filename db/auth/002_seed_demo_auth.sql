-- REVIEW AND RUN MANUALLY ONLY. Does not change existing accounts or Moodle passwords.
BEGIN;
INSERT INTO app.auth_account (userid, username, password_hash, enabled, created_at, updated_at)
VALUES (205, 'student205', '$2a$10$uJyr.yPWEiPZDQf9bNJ7Ve90lUfMoDNdeXxOTajHNRAwh9H774CuO', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
ON CONFLICT (username) DO NOTHING;

INSERT INTO app.auth_account (userid, username, password_hash, enabled, created_at, updated_at)
VALUES (102, 'teacher102', '$2a$10$UP4ieYOOzMiv70g0FT0fGew1ED/BUsU7l1n6VmerS7uQJhDyKf5LK', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
ON CONFLICT (username) DO NOTHING;

COMMIT;
