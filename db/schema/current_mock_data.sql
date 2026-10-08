--
-- PostgreSQL database dump
--

\restrict swZ4xpAnzS6df6K2lyeZezkPpSdQir0UTS7R6xCzgacAHwCAElB93MfKXIW8Go8

-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: learning_goals; Type: TABLE DATA; Schema: app; Owner: -
--

INSERT INTO app.learning_goals (id, user_id, course_id, goal_type, target_value, start_date, end_date, status, created_at, updated_at) VALUES (1, 201, 11, 'completion_percentage', 100.00, '2026-09-01', '2026-09-15', 'active', '2026-09-08 22:25:49.880305+07', '2026-09-08 22:25:49.880305+07');
INSERT INTO app.learning_goals (id, user_id, course_id, goal_type, target_value, start_date, end_date, status, created_at, updated_at) VALUES (2, 202, 11, 'completion_percentage', 80.00, '2026-09-01', '2026-09-15', 'active', '2026-09-08 22:25:49.880305+07', '2026-09-08 22:25:49.880305+07');
INSERT INTO app.learning_goals (id, user_id, course_id, goal_type, target_value, start_date, end_date, status, created_at, updated_at) VALUES (3, 203, 11, 'activity_count', 3.00, '2026-09-08', '2026-09-15', 'active', '2026-09-08 22:25:49.880305+07', '2026-09-08 22:25:49.880305+07');
INSERT INTO app.learning_goals (id, user_id, course_id, goal_type, target_value, start_date, end_date, status, created_at, updated_at) VALUES (4, 205, 13, 'target_grade', 85.00, '2026-09-01', '2026-09-22', 'active', '2026-09-08 22:25:49.880305+07', '2026-09-08 22:25:49.880305+07');
INSERT INTO app.learning_goals (id, user_id, course_id, goal_type, target_value, start_date, end_date, status, created_at, updated_at) VALUES (5, 206, 14, 'completion_percentage', 80.00, '2026-09-08', '2026-09-22', 'active', '2026-09-08 22:25:49.880305+07', '2026-09-08 22:25:49.880305+07');
INSERT INTO app.learning_goals (id, user_id, course_id, goal_type, target_value, start_date, end_date, status, created_at, updated_at) VALUES (6, 208, 14, 'study_minutes', 180.00, '2026-09-08', '2026-09-15', 'active', '2026-09-08 22:25:49.880305+07', '2026-09-08 22:25:49.880305+07');


--
-- Data for Name: learning_reminders; Type: TABLE DATA; Schema: app; Owner: -
--

INSERT INTO app.learning_reminders (id, user_id, course_id, source_type, source_id, title, message, remind_at, created_by_type, status, created_at, sent_at) VALUES (1, 202, 11, 'assignment', 11102, 'SQL Query Assignment', 'The assignment deadline is approaching.', '2026-09-09 22:25:49.880305+07', 'system', 'scheduled', '2026-09-08 22:25:49.880305+07', NULL);
INSERT INTO app.learning_reminders (id, user_id, course_id, source_type, source_id, title, message, remind_at, created_by_type, status, created_at, sent_at) VALUES (2, 203, 11, 'course', 11, 'Continue Database Systems', 'You have not accessed Database Systems recently.', '2026-09-08 23:25:49.880305+07', 'system', 'scheduled', '2026-09-08 22:25:49.880305+07', NULL);
INSERT INTO app.learning_reminders (id, user_id, course_id, source_type, source_id, title, message, remind_at, created_by_type, status, created_at, sent_at) VALUES (3, 203, 12, 'course', 12, 'Continue Java Programming', 'You have not accessed Java Programming recently.', '2026-09-09 00:25:49.880305+07', 'system', 'scheduled', '2026-09-08 22:25:49.880305+07', NULL);
INSERT INTO app.learning_reminders (id, user_id, course_id, source_type, source_id, title, message, remind_at, created_by_type, status, created_at, sent_at) VALUES (4, 207, 13, 'course', 13, 'Continue Software Testing', 'Your recent learning activity in Software Testing is low.', '2026-09-08 23:25:49.880305+07', 'system', 'scheduled', '2026-09-08 22:25:49.880305+07', NULL);
INSERT INTO app.learning_reminders (id, user_id, course_id, source_type, source_id, title, message, remind_at, created_by_type, status, created_at, sent_at) VALUES (5, 207, 14, 'course', 14, 'Continue Mobile Development', 'Your recent learning activity in Mobile Development is low.', '2026-09-09 00:25:49.880305+07', 'system', 'scheduled', '2026-09-08 22:25:49.880305+07', NULL);
INSERT INTO app.learning_reminders (id, user_id, course_id, source_type, source_id, title, message, remind_at, created_by_type, status, created_at, sent_at) VALUES (6, 208, 14, 'quiz', 14201, 'Android Quiz', 'The Android Quiz deadline is approaching.', '2026-09-09 10:25:49.880305+07', 'system', 'scheduled', '2026-09-08 22:25:49.880305+07', NULL);


--
-- Data for Name: notification_preferences; Type: TABLE DATA; Schema: app; Owner: -
--

INSERT INTO app.notification_preferences (id, user_id, push_enabled, assignment_reminder_enabled, quiz_reminder_enabled, grade_notification_enabled, learning_reminder_enabled, teacher_alert_enabled, default_reminder_before_hours, created_at, updated_at) VALUES (1, 101, true, false, false, false, false, true, 24, '2026-09-08 22:25:49.880305+07', '2026-09-08 22:25:49.880305+07');
INSERT INTO app.notification_preferences (id, user_id, push_enabled, assignment_reminder_enabled, quiz_reminder_enabled, grade_notification_enabled, learning_reminder_enabled, teacher_alert_enabled, default_reminder_before_hours, created_at, updated_at) VALUES (2, 102, true, false, false, false, false, true, 24, '2026-09-08 22:25:49.880305+07', '2026-09-08 22:25:49.880305+07');
INSERT INTO app.notification_preferences (id, user_id, push_enabled, assignment_reminder_enabled, quiz_reminder_enabled, grade_notification_enabled, learning_reminder_enabled, teacher_alert_enabled, default_reminder_before_hours, created_at, updated_at) VALUES (3, 201, true, true, true, true, true, false, 24, '2026-09-08 22:25:49.880305+07', '2026-09-08 22:25:49.880305+07');
INSERT INTO app.notification_preferences (id, user_id, push_enabled, assignment_reminder_enabled, quiz_reminder_enabled, grade_notification_enabled, learning_reminder_enabled, teacher_alert_enabled, default_reminder_before_hours, created_at, updated_at) VALUES (4, 202, true, true, true, true, true, false, 24, '2026-09-08 22:25:49.880305+07', '2026-09-08 22:25:49.880305+07');
INSERT INTO app.notification_preferences (id, user_id, push_enabled, assignment_reminder_enabled, quiz_reminder_enabled, grade_notification_enabled, learning_reminder_enabled, teacher_alert_enabled, default_reminder_before_hours, created_at, updated_at) VALUES (5, 203, true, true, true, true, true, false, 24, '2026-09-08 22:25:49.880305+07', '2026-09-08 22:25:49.880305+07');
INSERT INTO app.notification_preferences (id, user_id, push_enabled, assignment_reminder_enabled, quiz_reminder_enabled, grade_notification_enabled, learning_reminder_enabled, teacher_alert_enabled, default_reminder_before_hours, created_at, updated_at) VALUES (6, 204, true, true, true, true, true, false, 24, '2026-09-08 22:25:49.880305+07', '2026-09-08 22:25:49.880305+07');
INSERT INTO app.notification_preferences (id, user_id, push_enabled, assignment_reminder_enabled, quiz_reminder_enabled, grade_notification_enabled, learning_reminder_enabled, teacher_alert_enabled, default_reminder_before_hours, created_at, updated_at) VALUES (7, 205, true, true, true, true, true, false, 24, '2026-09-08 22:25:49.880305+07', '2026-09-08 22:25:49.880305+07');
INSERT INTO app.notification_preferences (id, user_id, push_enabled, assignment_reminder_enabled, quiz_reminder_enabled, grade_notification_enabled, learning_reminder_enabled, teacher_alert_enabled, default_reminder_before_hours, created_at, updated_at) VALUES (8, 206, true, true, true, true, true, false, 24, '2026-09-08 22:25:49.880305+07', '2026-09-08 22:25:49.880305+07');
INSERT INTO app.notification_preferences (id, user_id, push_enabled, assignment_reminder_enabled, quiz_reminder_enabled, grade_notification_enabled, learning_reminder_enabled, teacher_alert_enabled, default_reminder_before_hours, created_at, updated_at) VALUES (9, 207, true, true, true, true, true, false, 24, '2026-09-08 22:25:49.880305+07', '2026-09-08 22:25:49.880305+07');
INSERT INTO app.notification_preferences (id, user_id, push_enabled, assignment_reminder_enabled, quiz_reminder_enabled, grade_notification_enabled, learning_reminder_enabled, teacher_alert_enabled, default_reminder_before_hours, created_at, updated_at) VALUES (10, 208, true, true, true, true, true, false, 24, '2026-09-08 22:25:49.880305+07', '2026-09-08 22:25:49.880305+07');


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: app; Owner: -
--

INSERT INTO app.notifications (id, user_id, notification_type, title, message, course_id, source_type, source_id, is_read, created_at, read_at) VALUES (1, 202, 'assignment_due', 'Assignment deadline approaching', 'SQL Query Assignment is approaching its deadline.', 11, 'assignment', 11102, false, '2026-09-08 22:25:49.880305+07', NULL);
INSERT INTO app.notifications (id, user_id, notification_type, title, message, course_id, source_type, source_id, is_read, created_at, read_at) VALUES (2, 203, 'learning_reminder', 'Continue learning', 'You have not accessed Database Systems recently.', 11, 'course', 11, false, '2026-09-08 22:25:49.880305+07', NULL);
INSERT INTO app.notifications (id, user_id, notification_type, title, message, course_id, source_type, source_id, is_read, created_at, read_at) VALUES (3, 203, 'learning_reminder', 'Continue learning', 'You have not accessed Java Programming recently.', 12, 'course', 12, false, '2026-09-08 22:25:49.880305+07', NULL);
INSERT INTO app.notifications (id, user_id, notification_type, title, message, course_id, source_type, source_id, is_read, created_at, read_at) VALUES (4, 207, 'learning_reminder', 'Continue learning', 'Your Software Testing learning activity has been inactive.', 13, 'course', 13, false, '2026-09-08 22:25:49.880305+07', NULL);
INSERT INTO app.notifications (id, user_id, notification_type, title, message, course_id, source_type, source_id, is_read, created_at, read_at) VALUES (5, 207, 'learning_reminder', 'Continue learning', 'Your Mobile Development learning activity has been inactive.', 14, 'course', 14, false, '2026-09-08 22:25:49.880305+07', NULL);
INSERT INTO app.notifications (id, user_id, notification_type, title, message, course_id, source_type, source_id, is_read, created_at, read_at) VALUES (6, 208, 'quiz_due', 'Quiz deadline approaching', 'Android Quiz is approaching its deadline.', 14, 'quiz', 14201, false, '2026-09-08 22:25:49.880305+07', NULL);
INSERT INTO app.notifications (id, user_id, notification_type, title, message, course_id, source_type, source_id, is_read, created_at, read_at) VALUES (7, 201, 'grade_updated', 'Grade updated', 'Your Database Design Assignment grade is available.', 11, 'assignment', 11101, true, '2026-09-08 22:25:49.880305+07', '2026-09-08 20:25:49.880305+07');
INSERT INTO app.notifications (id, user_id, notification_type, title, message, course_id, source_type, source_id, is_read, created_at, read_at) VALUES (8, 101, 'risk_alert', 'Students need attention', '1 student(s) are currently classified as high learning risk.', 11, 'course', 11, false, '2026-09-08 22:25:49.880305+07', NULL);
INSERT INTO app.notifications (id, user_id, notification_type, title, message, course_id, source_type, source_id, is_read, created_at, read_at) VALUES (9, 101, 'risk_alert', 'Students need attention', '1 student(s) are currently classified as high learning risk.', 12, 'course', 12, false, '2026-09-08 22:25:49.880305+07', NULL);
INSERT INTO app.notifications (id, user_id, notification_type, title, message, course_id, source_type, source_id, is_read, created_at, read_at) VALUES (10, 102, 'risk_alert', 'Students need attention', '1 student(s) are currently classified as high learning risk.', 13, 'course', 13, false, '2026-09-08 22:25:49.880305+07', NULL);
INSERT INTO app.notifications (id, user_id, notification_type, title, message, course_id, source_type, source_id, is_read, created_at, read_at) VALUES (11, 102, 'risk_alert', 'Students need attention', '1 student(s) are currently classified as high learning risk.', 14, 'course', 14, false, '2026-09-08 22:25:49.880305+07', NULL);


--
-- Data for Name: assign; Type: TABLE DATA; Schema: lms; Owner: -
--

INSERT INTO lms.assign (id, course, name, intro, introformat, allowsubmissionsfromdate, duedate, grade, timemodified, requiresubmissionstatement, completionsubmit, cutoffdate, gradingduedate, teamsubmission, requireallteammemberssubmit, attemptreopenmethod, maxattempts) VALUES (11101, 11, 'Database Design Assignment', 'Design a relational database schema.', 1, 1788016434, 1788707634, 100, 1788880434, 0, 1, 1788966834, 1789312434, 0, 0, 'none', 3);
INSERT INTO lms.assign (id, course, name, intro, introformat, allowsubmissionsfromdate, duedate, grade, timemodified, requiresubmissionstatement, completionsubmit, cutoffdate, gradingduedate, teamsubmission, requireallteammemberssubmit, attemptreopenmethod, maxattempts) VALUES (11102, 11, 'SQL Query Assignment', 'Practice SQL SELECT, JOIN and GROUP BY queries.', 1, 1788621234, 1789053234, 100, 1788880434, 0, 1, 1789226034, 1789485234, 0, 0, 'none', 3);
INSERT INTO lms.assign (id, course, name, intro, introformat, allowsubmissionsfromdate, duedate, grade, timemodified, requiresubmissionstatement, completionsubmit, cutoffdate, gradingduedate, teamsubmission, requireallteammemberssubmit, attemptreopenmethod, maxattempts) VALUES (12101, 12, 'Java OOP Assignment', 'Object-oriented programming exercise.', 1, 1788448434, 1788966834, 100, 1788880434, 0, 1, 1789139634, 1789312434, 0, 0, 'none', 3);
INSERT INTO lms.assign (id, course, name, intro, introformat, allowsubmissionsfromdate, duedate, grade, timemodified, requiresubmissionstatement, completionsubmit, cutoffdate, gradingduedate, teamsubmission, requireallteammemberssubmit, attemptreopenmethod, maxattempts) VALUES (12102, 12, 'Java Collections Assignment', 'Practice Java Collections Framework.', 1, 1788880434, 1789398834, 100, 1788880434, 0, 1, 1789571634, 1789744434, 0, 0, 'none', 3);
INSERT INTO lms.assign (id, course, name, intro, introformat, allowsubmissionsfromdate, duedate, grade, timemodified, requiresubmissionstatement, completionsubmit, cutoffdate, gradingduedate, teamsubmission, requireallteammemberssubmit, attemptreopenmethod, maxattempts) VALUES (13101, 13, 'Boundary Value Assignment', 'Practice boundary value analysis.', 1, 1788016434, 1788534834, 100, 1788880434, 0, 1, 1788880434, 1789139634, 0, 0, 'none', 3);
INSERT INTO lms.assign (id, course, name, intro, introformat, allowsubmissionsfromdate, duedate, grade, timemodified, requiresubmissionstatement, completionsubmit, cutoffdate, gradingduedate, teamsubmission, requireallteammemberssubmit, attemptreopenmethod, maxattempts) VALUES (13102, 13, 'Decision Table Assignment', 'Practice decision table testing.', 1, 1788707634, 1789139634, 100, 1788880434, 0, 1, 1789312434, 1789485234, 0, 0, 'none', 3);
INSERT INTO lms.assign (id, course, name, intro, introformat, allowsubmissionsfromdate, duedate, grade, timemodified, requiresubmissionstatement, completionsubmit, cutoffdate, gradingduedate, teamsubmission, requireallteammemberssubmit, attemptreopenmethod, maxattempts) VALUES (14101, 14, 'Android UI Assignment', 'Create an Android user interface.', 1, 1788275634, 1788794034, 100, 1788880434, 0, 1, 1789053234, 1789312434, 0, 0, 'none', 3);
INSERT INTO lms.assign (id, course, name, intro, introformat, allowsubmissionsfromdate, duedate, grade, timemodified, requiresubmissionstatement, completionsubmit, cutoffdate, gradingduedate, teamsubmission, requireallteammemberssubmit, attemptreopenmethod, maxattempts) VALUES (14102, 14, 'Android API Assignment', 'Consume a REST API from an Android application.', 1, 1788880434, 1789485234, 100, 1788880434, 0, 1, 1789658034, 1789917234, 0, 0, 'none', 3);


--
-- Data for Name: assign_grades; Type: TABLE DATA; Schema: lms; Owner: -
--

INSERT INTO lms.assign_grades (id, assignment, userid, timecreated, timemodified, grader, grade, attemptnumber) VALUES (1, 11101, 201, 1788880434, 1788880434, 101, 90.00000, 0);
INSERT INTO lms.assign_grades (id, assignment, userid, timecreated, timemodified, grader, grade, attemptnumber) VALUES (2, 11101, 204, 1788880434, 1788880434, 101, 75.00000, 0);
INSERT INTO lms.assign_grades (id, assignment, userid, timecreated, timemodified, grader, grade, attemptnumber) VALUES (3, 11102, 201, 1788880434, 1788880434, 101, 85.00000, 0);
INSERT INTO lms.assign_grades (id, assignment, userid, timecreated, timemodified, grader, grade, attemptnumber) VALUES (4, 12101, 201, 1788880434, 1788880434, 101, 88.00000, 0);
INSERT INTO lms.assign_grades (id, assignment, userid, timecreated, timemodified, grader, grade, attemptnumber) VALUES (5, 13101, 205, 1788880434, 1788880434, 102, 95.00000, 0);
INSERT INTO lms.assign_grades (id, assignment, userid, timecreated, timemodified, grader, grade, attemptnumber) VALUES (6, 13101, 208, 1788880434, 1788880434, 102, 78.00000, 0);
INSERT INTO lms.assign_grades (id, assignment, userid, timecreated, timemodified, grader, grade, attemptnumber) VALUES (7, 13102, 205, 1788880434, 1788880434, 102, 92.00000, 0);
INSERT INTO lms.assign_grades (id, assignment, userid, timecreated, timemodified, grader, grade, attemptnumber) VALUES (8, 14101, 205, 1788880434, 1788880434, 102, 90.00000, 0);
INSERT INTO lms.assign_grades (id, assignment, userid, timecreated, timemodified, grader, grade, attemptnumber) VALUES (9, 14101, 206, 1788880434, 1788880434, 102, 70.00000, 0);
INSERT INTO lms.assign_grades (id, assignment, userid, timecreated, timemodified, grader, grade, attemptnumber) VALUES (10, 14102, 208, 1788880434, 1788880434, 102, 85.00000, 0);


--
-- Data for Name: assign_submission; Type: TABLE DATA; Schema: lms; Owner: -
--

INSERT INTO lms.assign_submission (id, assignment, userid, timecreated, timemodified, status, groupid, attemptnumber, latest) VALUES (1, 11101, 201, 1788621234, 1788621234, 'submitted', 0, 0, 1);
INSERT INTO lms.assign_submission (id, assignment, userid, timecreated, timemodified, status, groupid, attemptnumber, latest) VALUES (2, 11101, 202, 1788621234, 1788621234, 'submitted', 0, 0, 1);
INSERT INTO lms.assign_submission (id, assignment, userid, timecreated, timemodified, status, groupid, attemptnumber, latest) VALUES (3, 11101, 204, 1788707634, 1788707634, 'submitted', 0, 0, 1);
INSERT INTO lms.assign_submission (id, assignment, userid, timecreated, timemodified, status, groupid, attemptnumber, latest) VALUES (4, 11102, 201, 1788794034, 1788794034, 'submitted', 0, 0, 1);
INSERT INTO lms.assign_submission (id, assignment, userid, timecreated, timemodified, status, groupid, attemptnumber, latest) VALUES (5, 12101, 201, 1788794034, 1788794034, 'submitted', 0, 0, 1);
INSERT INTO lms.assign_submission (id, assignment, userid, timecreated, timemodified, status, groupid, attemptnumber, latest) VALUES (6, 12101, 204, 1788794034, 1788794034, 'submitted', 0, 0, 1);
INSERT INTO lms.assign_submission (id, assignment, userid, timecreated, timemodified, status, groupid, attemptnumber, latest) VALUES (7, 13101, 205, 1788448434, 1788448434, 'submitted', 0, 0, 1);
INSERT INTO lms.assign_submission (id, assignment, userid, timecreated, timemodified, status, groupid, attemptnumber, latest) VALUES (8, 13101, 206, 1788448434, 1788448434, 'submitted', 0, 0, 1);
INSERT INTO lms.assign_submission (id, assignment, userid, timecreated, timemodified, status, groupid, attemptnumber, latest) VALUES (9, 13101, 208, 1788534834, 1788534834, 'submitted', 0, 0, 1);
INSERT INTO lms.assign_submission (id, assignment, userid, timecreated, timemodified, status, groupid, attemptnumber, latest) VALUES (10, 13102, 205, 1788794034, 1788794034, 'submitted', 0, 0, 1);
INSERT INTO lms.assign_submission (id, assignment, userid, timecreated, timemodified, status, groupid, attemptnumber, latest) VALUES (11, 14101, 205, 1788707634, 1788707634, 'submitted', 0, 0, 1);
INSERT INTO lms.assign_submission (id, assignment, userid, timecreated, timemodified, status, groupid, attemptnumber, latest) VALUES (12, 14101, 206, 1788707634, 1788707634, 'submitted', 0, 0, 1);
INSERT INTO lms.assign_submission (id, assignment, userid, timecreated, timemodified, status, groupid, attemptnumber, latest) VALUES (13, 14101, 208, 1788707634, 1788707634, 'submitted', 0, 0, 1);
INSERT INTO lms.assign_submission (id, assignment, userid, timecreated, timemodified, status, groupid, attemptnumber, latest) VALUES (14, 14102, 208, 1788794034, 1788794034, 'submitted', 0, 0, 1);


--
-- Data for Name: attendance; Type: TABLE DATA; Schema: lms; Owner: -
--

INSERT INTO lms.attendance (id, course, name, grade, timemodified, intro, introformat, subnet, sessiondetailspos, showsessiondetails, showextrauserdetails) VALUES (14401, 14, 'Điểm danh', 10, 1789369539, 'Theo dõi chuyên cần của sinh viên trong học phần.', 1, NULL, 'left', 1, 1);


--
-- Data for Name: attendance_log; Type: TABLE DATA; Schema: lms; Owner: -
--

INSERT INTO lms.attendance_log (id, sessionid, studentid, statusid, statusset, timetaken, takenby, remarks, ipaddress) VALUES (1, 14601, 205, 14501, NULL, 1786950371, 102, NULL, '');
INSERT INTO lms.attendance_log (id, sessionid, studentid, statusid, statusset, timetaken, takenby, remarks, ipaddress) VALUES (2, 14602, 205, 14501, NULL, 1787555171, 102, NULL, '');
INSERT INTO lms.attendance_log (id, sessionid, studentid, statusid, statusset, timetaken, takenby, remarks, ipaddress) VALUES (3, 14603, 205, 14501, NULL, 1788159971, 102, NULL, '');
INSERT INTO lms.attendance_log (id, sessionid, studentid, statusid, statusset, timetaken, takenby, remarks, ipaddress) VALUES (4, 14604, 205, 14501, NULL, 1788764771, 102, NULL, '');
INSERT INTO lms.attendance_log (id, sessionid, studentid, statusid, statusset, timetaken, takenby, remarks, ipaddress) VALUES (5, 14605, 205, 14501, NULL, 1789283171, 102, NULL, '');
INSERT INTO lms.attendance_log (id, sessionid, studentid, statusid, statusset, timetaken, takenby, remarks, ipaddress) VALUES (6, 14601, 206, 14501, NULL, 1786950380, 102, NULL, '');
INSERT INTO lms.attendance_log (id, sessionid, studentid, statusid, statusset, timetaken, takenby, remarks, ipaddress) VALUES (7, 14602, 206, 14501, NULL, 1787555180, 102, NULL, '');
INSERT INTO lms.attendance_log (id, sessionid, studentid, statusid, statusset, timetaken, takenby, remarks, ipaddress) VALUES (8, 14603, 206, 14502, NULL, 1788159980, 102, NULL, '');
INSERT INTO lms.attendance_log (id, sessionid, studentid, statusid, statusset, timetaken, takenby, remarks, ipaddress) VALUES (9, 14604, 206, 14501, NULL, 1788764780, 102, NULL, '');
INSERT INTO lms.attendance_log (id, sessionid, studentid, statusid, statusset, timetaken, takenby, remarks, ipaddress) VALUES (10, 14605, 206, 14504, NULL, 1789283180, 102, NULL, '');
INSERT INTO lms.attendance_log (id, sessionid, studentid, statusid, statusset, timetaken, takenby, remarks, ipaddress) VALUES (11, 14601, 207, 14504, NULL, 1786950380, 102, NULL, '');
INSERT INTO lms.attendance_log (id, sessionid, studentid, statusid, statusset, timetaken, takenby, remarks, ipaddress) VALUES (12, 14602, 207, 14504, NULL, 1787555180, 102, NULL, '');
INSERT INTO lms.attendance_log (id, sessionid, studentid, statusid, statusset, timetaken, takenby, remarks, ipaddress) VALUES (13, 14603, 207, 14501, NULL, 1788159980, 102, NULL, '');
INSERT INTO lms.attendance_log (id, sessionid, studentid, statusid, statusset, timetaken, takenby, remarks, ipaddress) VALUES (14, 14604, 207, 14504, NULL, 1788764780, 102, NULL, '');
INSERT INTO lms.attendance_log (id, sessionid, studentid, statusid, statusset, timetaken, takenby, remarks, ipaddress) VALUES (15, 14605, 207, 14504, NULL, 1789283180, 102, NULL, '');
INSERT INTO lms.attendance_log (id, sessionid, studentid, statusid, statusset, timetaken, takenby, remarks, ipaddress) VALUES (16, 14601, 208, 14501, NULL, 1786950380, 102, NULL, '');
INSERT INTO lms.attendance_log (id, sessionid, studentid, statusid, statusset, timetaken, takenby, remarks, ipaddress) VALUES (17, 14602, 208, 14501, NULL, 1787555180, 102, NULL, '');
INSERT INTO lms.attendance_log (id, sessionid, studentid, statusid, statusset, timetaken, takenby, remarks, ipaddress) VALUES (18, 14603, 208, 14501, NULL, 1788159980, 102, NULL, '');
INSERT INTO lms.attendance_log (id, sessionid, studentid, statusid, statusset, timetaken, takenby, remarks, ipaddress) VALUES (19, 14604, 208, 14502, NULL, 1788764780, 102, NULL, '');
INSERT INTO lms.attendance_log (id, sessionid, studentid, statusid, statusset, timetaken, takenby, remarks, ipaddress) VALUES (20, 14605, 208, 14501, NULL, 1789283180, 102, NULL, '');


--
-- Data for Name: attendance_sessions; Type: TABLE DATA; Schema: lms; Owner: -
--

INSERT INTO lms.attendance_sessions (id, attendanceid, groupid, sessdate, duration, lasttaken, lasttakenby, timemodified, description, descriptionformat, studentscanmark, allowupdatestatus, studentsearlyopentime, autoassignstatus, studentpassword, subnet, automark, automarkcompleted, statusset, absenteereport, preventsharedip, preventsharediptime, caleventid, calendarevent, includeqrcode, rotateqrcode, rotateqrcodesecret, automarkcmid) VALUES (14601, 14401, 0, 1786950371, 7200, 1786950371, 102, 1789369571, 'Buổi học 1', 1, 0, 0, 0, 0, '', NULL, 0, 0, 0, 1, 0, NULL, 0, 1, 0, 0, NULL, 0);
INSERT INTO lms.attendance_sessions (id, attendanceid, groupid, sessdate, duration, lasttaken, lasttakenby, timemodified, description, descriptionformat, studentscanmark, allowupdatestatus, studentsearlyopentime, autoassignstatus, studentpassword, subnet, automark, automarkcompleted, statusset, absenteereport, preventsharedip, preventsharediptime, caleventid, calendarevent, includeqrcode, rotateqrcode, rotateqrcodesecret, automarkcmid) VALUES (14602, 14401, 0, 1787555171, 7200, 1787555171, 102, 1789369571, 'Buổi học 2', 1, 0, 0, 0, 0, '', NULL, 0, 0, 0, 1, 0, NULL, 0, 1, 0, 0, NULL, 0);
INSERT INTO lms.attendance_sessions (id, attendanceid, groupid, sessdate, duration, lasttaken, lasttakenby, timemodified, description, descriptionformat, studentscanmark, allowupdatestatus, studentsearlyopentime, autoassignstatus, studentpassword, subnet, automark, automarkcompleted, statusset, absenteereport, preventsharedip, preventsharediptime, caleventid, calendarevent, includeqrcode, rotateqrcode, rotateqrcodesecret, automarkcmid) VALUES (14603, 14401, 0, 1788159971, 7200, 1788159971, 102, 1789369571, 'Buổi học 3', 1, 0, 0, 0, 0, '', NULL, 0, 0, 0, 1, 0, NULL, 0, 1, 0, 0, NULL, 0);
INSERT INTO lms.attendance_sessions (id, attendanceid, groupid, sessdate, duration, lasttaken, lasttakenby, timemodified, description, descriptionformat, studentscanmark, allowupdatestatus, studentsearlyopentime, autoassignstatus, studentpassword, subnet, automark, automarkcompleted, statusset, absenteereport, preventsharedip, preventsharediptime, caleventid, calendarevent, includeqrcode, rotateqrcode, rotateqrcodesecret, automarkcmid) VALUES (14604, 14401, 0, 1788764771, 7200, 1788764771, 102, 1789369571, 'Buổi học 4', 1, 0, 0, 0, 0, '', NULL, 0, 0, 0, 1, 0, NULL, 0, 1, 0, 0, NULL, 0);
INSERT INTO lms.attendance_sessions (id, attendanceid, groupid, sessdate, duration, lasttaken, lasttakenby, timemodified, description, descriptionformat, studentscanmark, allowupdatestatus, studentsearlyopentime, autoassignstatus, studentpassword, subnet, automark, automarkcompleted, statusset, absenteereport, preventsharedip, preventsharediptime, caleventid, calendarevent, includeqrcode, rotateqrcode, rotateqrcodesecret, automarkcmid) VALUES (14605, 14401, 0, 1789283171, 7200, 1789283171, 102, 1789369571, 'Buổi học 5', 1, 0, 0, 0, 0, '', NULL, 0, 0, 0, 1, 0, NULL, 0, 1, 0, 0, NULL, 0);


--
-- Data for Name: attendance_statuses; Type: TABLE DATA; Schema: lms; Owner: -
--

INSERT INTO lms.attendance_statuses (id, attendanceid, acronym, description, grade, studentavailability, availablebeforesession, setunmarked, visible, deleted, setnumber) VALUES (14501, 14401, 'P', 'Present', 1.00, NULL, NULL, NULL, 1, 0, 0);
INSERT INTO lms.attendance_statuses (id, attendanceid, acronym, description, grade, studentavailability, availablebeforesession, setunmarked, visible, deleted, setnumber) VALUES (14502, 14401, 'L', 'Late', 0.50, NULL, NULL, NULL, 1, 0, 0);
INSERT INTO lms.attendance_statuses (id, attendanceid, acronym, description, grade, studentavailability, availablebeforesession, setunmarked, visible, deleted, setnumber) VALUES (14503, 14401, 'E', 'Excused', 1.00, NULL, NULL, NULL, 1, 0, 0);
INSERT INTO lms.attendance_statuses (id, attendanceid, acronym, description, grade, studentavailability, availablebeforesession, setunmarked, visible, deleted, setnumber) VALUES (14504, 14401, 'A', 'Absent', 0.00, NULL, NULL, NULL, 1, 0, 0);


--
-- Data for Name: context; Type: TABLE DATA; Schema: lms; Owner: -
--

INSERT INTO lms.context (id, contextlevel, instanceid, path, depth, locked) VALUES (5011, 50, 11, '/5011', 2, 0);
INSERT INTO lms.context (id, contextlevel, instanceid, path, depth, locked) VALUES (5012, 50, 12, '/5012', 2, 0);
INSERT INTO lms.context (id, contextlevel, instanceid, path, depth, locked) VALUES (5013, 50, 13, '/5013', 2, 0);
INSERT INTO lms.context (id, contextlevel, instanceid, path, depth, locked) VALUES (5014, 50, 14, '/5014', 2, 0);


--
-- Data for Name: course_categories; Type: TABLE DATA; Schema: lms; Owner: -
--

INSERT INTO lms.course_categories (id, name, idnumber, description, descriptionformat, parent, sortorder, coursecount, visible, visibleold, timemodified, depth, path, theme) VALUES (1001, 'Khoa Công nghệ Thông tin', 'DLU-IT', 'Mock category based on LMS DLU course hierarchy.', 1, NULL, 1000, 0, 1, 1, 1789368921, 1, '/1001', NULL);
INSERT INTO lms.course_categories (id, name, idnumber, description, descriptionformat, parent, sortorder, coursecount, visible, visibleold, timemodified, depth, path, theme) VALUES (1002, 'Chuyên ngành Kỹ thuật phần mềm', 'DLU-SE', 'Software Engineering specialization.', 1, 1001, 1100, 0, 1, 1, 1789368921, 2, '/1001/1002', NULL);
INSERT INTO lms.course_categories (id, name, idnumber, description, descriptionformat, parent, sortorder, coursecount, visible, visibleold, timemodified, depth, path, theme) VALUES (1003, 'Năm học 2025-2026', 'AY-2025-2026', 'Academic year 2025-2026.', 1, 1002, 1200, 0, 1, 1, 1789368921, 3, '/1001/1002/1003', NULL);
INSERT INTO lms.course_categories (id, name, idnumber, description, descriptionformat, parent, sortorder, coursecount, visible, visibleold, timemodified, depth, path, theme) VALUES (1004, 'Học kỳ 2', 'SEM-2-2025-2026', 'Semester 2.', 1, 1003, 1300, 0, 1, 1, 1789368921, 4, '/1001/1002/1003/1004', NULL);


--
-- Data for Name: course; Type: TABLE DATA; Schema: lms; Owner: -
--

INSERT INTO lms.course (id, category, sortorder, fullname, shortname, idnumber, summary, summaryformat, format, showgrades, newsitems, startdate, enddate, relativedatesmode, marker, maxbytes, legacyfiles, showreports, visible, visibleold, groupmode, groupmodeforce, defaultgroupingid, lang, calendartype, theme, timecreated, timemodified, requested, enablecompletion, completionnotify, cacherev) VALUES (11, 1004, 0, 'Database Systems', 'DB101', 'DB101-2026', 'Database fundamentals and relational database design.', 0, 'topics', 1, 1, 1783696160, 1794064160, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, '', '', '', 1781104160, 1788880160, 0, 1, 0, 0);
INSERT INTO lms.course (id, category, sortorder, fullname, shortname, idnumber, summary, summaryformat, format, showgrades, newsitems, startdate, enddate, relativedatesmode, marker, maxbytes, legacyfiles, showreports, visible, visibleold, groupmode, groupmodeforce, defaultgroupingid, lang, calendartype, theme, timecreated, timemodified, requested, enablecompletion, completionnotify, cacherev) VALUES (12, 1004, 0, 'Java Programming', 'JAVA101', 'JAVA101-2026', 'Object-oriented programming using Java.', 0, 'topics', 1, 1, 1783696160, 1794064160, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, '', '', '', 1781104160, 1788880160, 0, 1, 0, 0);
INSERT INTO lms.course (id, category, sortorder, fullname, shortname, idnumber, summary, summaryformat, format, showgrades, newsitems, startdate, enddate, relativedatesmode, marker, maxbytes, legacyfiles, showreports, visible, visibleold, groupmode, groupmodeforce, defaultgroupingid, lang, calendartype, theme, timecreated, timemodified, requested, enablecompletion, completionnotify, cacherev) VALUES (13, 1004, 0, 'Software Testing', 'TEST101', 'TEST101-2026', 'Software testing principles and techniques.', 0, 'topics', 1, 1, 1783696160, 1794064160, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, '', '', '', 1781104160, 1788880160, 0, 1, 0, 0);
INSERT INTO lms.course (id, category, sortorder, fullname, shortname, idnumber, summary, summaryformat, format, showgrades, newsitems, startdate, enddate, relativedatesmode, marker, maxbytes, legacyfiles, showreports, visible, visibleold, groupmode, groupmodeforce, defaultgroupingid, lang, calendartype, theme, timecreated, timemodified, requested, enablecompletion, completionnotify, cacherev) VALUES (14, 1004, 0, 'Mobile Application Development', 'MOBILE101', 'MOBILE101-2026', 'Mobile application development fundamentals.', 0, 'topics', 1, 1, 1783696160, 1794064160, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, '', '', '', 1781104160, 1788880160, 0, 1, 0, 0);


--
-- Data for Name: user; Type: TABLE DATA; Schema: lms; Owner: -
--

INSERT INTO lms."user" (id, auth, confirmed, policyagreed, deleted, suspended, mnethostid, username, password, idnumber, firstname, lastname, email, emailstop, institution, department, address, city, country, lang, calendartype, theme, timezone, firstaccess, lastaccess, lastlogin, currentlogin, lastip, secret, picture, url, description, descriptionformat, mailformat, maildigest) VALUES (101, 'manual', 1, 0, 0, 0, 0, 'teacher01', 'mock_password', NULL, 'Nguyen', 'Minh Anh', 'teacher01@example.edu.vn', 0, NULL, NULL, NULL, NULL, NULL, 'en', 'gregorian', NULL, '99', 0, 0, 0, 0, NULL, NULL, 0, NULL, NULL, 1, 1, 0);
INSERT INTO lms."user" (id, auth, confirmed, policyagreed, deleted, suspended, mnethostid, username, password, idnumber, firstname, lastname, email, emailstop, institution, department, address, city, country, lang, calendartype, theme, timezone, firstaccess, lastaccess, lastlogin, currentlogin, lastip, secret, picture, url, description, descriptionformat, mailformat, maildigest) VALUES (102, 'manual', 1, 0, 0, 0, 0, 'teacher02', 'mock_password', NULL, 'Tran', 'Thanh Hoa', 'teacher02@example.edu.vn', 0, NULL, NULL, NULL, NULL, NULL, 'en', 'gregorian', NULL, '99', 0, 0, 0, 0, NULL, NULL, 0, NULL, NULL, 1, 1, 0);
INSERT INTO lms."user" (id, auth, confirmed, policyagreed, deleted, suspended, mnethostid, username, password, idnumber, firstname, lastname, email, emailstop, institution, department, address, city, country, lang, calendartype, theme, timezone, firstaccess, lastaccess, lastlogin, currentlogin, lastip, secret, picture, url, description, descriptionformat, mailformat, maildigest) VALUES (201, 'manual', 1, 0, 0, 0, 0, 'student01', 'mock_password', NULL, 'Le', 'An', 'student01@example.edu.vn', 0, NULL, NULL, NULL, NULL, NULL, 'en', 'gregorian', NULL, '99', 0, 0, 0, 0, NULL, NULL, 0, NULL, NULL, 1, 1, 0);
INSERT INTO lms."user" (id, auth, confirmed, policyagreed, deleted, suspended, mnethostid, username, password, idnumber, firstname, lastname, email, emailstop, institution, department, address, city, country, lang, calendartype, theme, timezone, firstaccess, lastaccess, lastlogin, currentlogin, lastip, secret, picture, url, description, descriptionformat, mailformat, maildigest) VALUES (202, 'manual', 1, 0, 0, 0, 0, 'student02', 'mock_password', NULL, 'Nguyen', 'Binh', 'student02@example.edu.vn', 0, NULL, NULL, NULL, NULL, NULL, 'en', 'gregorian', NULL, '99', 0, 0, 0, 0, NULL, NULL, 0, NULL, NULL, 1, 1, 0);
INSERT INTO lms."user" (id, auth, confirmed, policyagreed, deleted, suspended, mnethostid, username, password, idnumber, firstname, lastname, email, emailstop, institution, department, address, city, country, lang, calendartype, theme, timezone, firstaccess, lastaccess, lastlogin, currentlogin, lastip, secret, picture, url, description, descriptionformat, mailformat, maildigest) VALUES (203, 'manual', 1, 0, 0, 0, 0, 'student03', 'mock_password', NULL, 'Tran', 'Cuong', 'student03@example.edu.vn', 0, NULL, NULL, NULL, NULL, NULL, 'en', 'gregorian', NULL, '99', 0, 0, 0, 0, NULL, NULL, 0, NULL, NULL, 1, 1, 0);
INSERT INTO lms."user" (id, auth, confirmed, policyagreed, deleted, suspended, mnethostid, username, password, idnumber, firstname, lastname, email, emailstop, institution, department, address, city, country, lang, calendartype, theme, timezone, firstaccess, lastaccess, lastlogin, currentlogin, lastip, secret, picture, url, description, descriptionformat, mailformat, maildigest) VALUES (204, 'manual', 1, 0, 0, 0, 0, 'student04', 'mock_password', NULL, 'Pham', 'Dung', 'student04@example.edu.vn', 0, NULL, NULL, NULL, NULL, NULL, 'en', 'gregorian', NULL, '99', 0, 0, 0, 0, NULL, NULL, 0, NULL, NULL, 1, 1, 0);
INSERT INTO lms."user" (id, auth, confirmed, policyagreed, deleted, suspended, mnethostid, username, password, idnumber, firstname, lastname, email, emailstop, institution, department, address, city, country, lang, calendartype, theme, timezone, firstaccess, lastaccess, lastlogin, currentlogin, lastip, secret, picture, url, description, descriptionformat, mailformat, maildigest) VALUES (205, 'manual', 1, 0, 0, 0, 0, 'student05', 'mock_password', NULL, 'Hoang', 'Giang', 'student05@example.edu.vn', 0, NULL, NULL, NULL, NULL, NULL, 'en', 'gregorian', NULL, '99', 0, 0, 0, 0, NULL, NULL, 0, NULL, NULL, 1, 1, 0);
INSERT INTO lms."user" (id, auth, confirmed, policyagreed, deleted, suspended, mnethostid, username, password, idnumber, firstname, lastname, email, emailstop, institution, department, address, city, country, lang, calendartype, theme, timezone, firstaccess, lastaccess, lastlogin, currentlogin, lastip, secret, picture, url, description, descriptionformat, mailformat, maildigest) VALUES (206, 'manual', 1, 0, 0, 0, 0, 'student06', 'mock_password', NULL, 'Vo', 'Hieu', 'student06@example.edu.vn', 0, NULL, NULL, NULL, NULL, NULL, 'en', 'gregorian', NULL, '99', 0, 0, 0, 0, NULL, NULL, 0, NULL, NULL, 1, 1, 0);
INSERT INTO lms."user" (id, auth, confirmed, policyagreed, deleted, suspended, mnethostid, username, password, idnumber, firstname, lastname, email, emailstop, institution, department, address, city, country, lang, calendartype, theme, timezone, firstaccess, lastaccess, lastlogin, currentlogin, lastip, secret, picture, url, description, descriptionformat, mailformat, maildigest) VALUES (207, 'manual', 1, 0, 0, 0, 0, 'student07', 'mock_password', NULL, 'Bui', 'Khanh', 'student07@example.edu.vn', 0, NULL, NULL, NULL, NULL, NULL, 'en', 'gregorian', NULL, '99', 0, 0, 0, 0, NULL, NULL, 0, NULL, NULL, 1, 1, 0);
INSERT INTO lms."user" (id, auth, confirmed, policyagreed, deleted, suspended, mnethostid, username, password, idnumber, firstname, lastname, email, emailstop, institution, department, address, city, country, lang, calendartype, theme, timezone, firstaccess, lastaccess, lastlogin, currentlogin, lastip, secret, picture, url, description, descriptionformat, mailformat, maildigest) VALUES (208, 'manual', 1, 0, 0, 0, 0, 'student08', 'mock_password', NULL, 'Do', 'Linh', 'student08@example.edu.vn', 0, NULL, NULL, NULL, NULL, NULL, 'en', 'gregorian', NULL, '99', 0, 0, 0, 0, NULL, NULL, 0, NULL, NULL, 1, 1, 0);


--
-- Data for Name: course_completions; Type: TABLE DATA; Schema: lms; Owner: -
--

INSERT INTO lms.course_completions (id, userid, course, timeenrolled, timestarted, timecompleted, reaggregate) VALUES (1, 201, 11, 1783696822, 1784128822, 1788794422, 0);
INSERT INTO lms.course_completions (id, userid, course, timeenrolled, timestarted, timecompleted, reaggregate) VALUES (2, 202, 11, 1783696822, 1784128822, NULL, 0);
INSERT INTO lms.course_completions (id, userid, course, timeenrolled, timestarted, timecompleted, reaggregate) VALUES (3, 203, 11, 1783696822, 1784128822, NULL, 0);
INSERT INTO lms.course_completions (id, userid, course, timeenrolled, timestarted, timecompleted, reaggregate) VALUES (4, 204, 11, 1783696822, 1784128822, NULL, 0);
INSERT INTO lms.course_completions (id, userid, course, timeenrolled, timestarted, timecompleted, reaggregate) VALUES (5, 201, 12, 1783696822, 1784128822, 1788794422, 0);
INSERT INTO lms.course_completions (id, userid, course, timeenrolled, timestarted, timecompleted, reaggregate) VALUES (6, 202, 12, 1783696822, 1784128822, NULL, 0);
INSERT INTO lms.course_completions (id, userid, course, timeenrolled, timestarted, timecompleted, reaggregate) VALUES (7, 203, 12, 1783696822, 1784128822, NULL, 0);
INSERT INTO lms.course_completions (id, userid, course, timeenrolled, timestarted, timecompleted, reaggregate) VALUES (8, 204, 12, 1783696822, 1784128822, NULL, 0);
INSERT INTO lms.course_completions (id, userid, course, timeenrolled, timestarted, timecompleted, reaggregate) VALUES (9, 205, 13, 1783696822, 1784128822, 1788794422, 0);
INSERT INTO lms.course_completions (id, userid, course, timeenrolled, timestarted, timecompleted, reaggregate) VALUES (10, 206, 13, 1783696822, 1784128822, NULL, 0);
INSERT INTO lms.course_completions (id, userid, course, timeenrolled, timestarted, timecompleted, reaggregate) VALUES (11, 207, 13, 1783696822, 1784128822, NULL, 0);
INSERT INTO lms.course_completions (id, userid, course, timeenrolled, timestarted, timecompleted, reaggregate) VALUES (12, 208, 13, 1783696822, 1784128822, NULL, 0);
INSERT INTO lms.course_completions (id, userid, course, timeenrolled, timestarted, timecompleted, reaggregate) VALUES (13, 205, 14, 1783696822, 1784128822, NULL, 0);
INSERT INTO lms.course_completions (id, userid, course, timeenrolled, timestarted, timecompleted, reaggregate) VALUES (14, 206, 14, 1783696822, 1784128822, NULL, 0);
INSERT INTO lms.course_completions (id, userid, course, timeenrolled, timestarted, timecompleted, reaggregate) VALUES (15, 207, 14, 1783696822, 1784128822, NULL, 0);
INSERT INTO lms.course_completions (id, userid, course, timeenrolled, timestarted, timecompleted, reaggregate) VALUES (16, 208, 14, 1783696822, 1784128822, 1788794422, 0);


--
-- Data for Name: groupings; Type: TABLE DATA; Schema: lms; Owner: -
--

INSERT INTO lms.groupings (id, courseid, name, idnumber, description, descriptionformat, configdata, timecreated, timemodified) VALUES (14101, 14, 'Lớp thực hành', 'PRACTICE-GROUPING', 'Grouping containing practice class groups.', 1, NULL, 1789368921, 1789368921);
INSERT INTO lms.groupings (id, courseid, name, idnumber, description, descriptionformat, configdata, timecreated, timemodified) VALUES (14102, 14, 'Nhóm bài tập / seminar', 'ASSIGNMENT-GROUPING', 'Grouping containing assignment groups.', 1, NULL, 1789368921, 1789368921);


--
-- Data for Name: modules; Type: TABLE DATA; Schema: lms; Owner: -
--

INSERT INTO lms.modules (id, name, cron, lastcron, search, visible) VALUES (1, 'assign', 0, 0, NULL, 1);
INSERT INTO lms.modules (id, name, cron, lastcron, search, visible) VALUES (2, 'quiz', 0, 0, NULL, 1);
INSERT INTO lms.modules (id, name, cron, lastcron, search, visible) VALUES (3, 'resource', 0, 0, NULL, 1);
INSERT INTO lms.modules (id, name, cron, lastcron, search, visible) VALUES (4, 'folder', 0, 0, NULL, 1);
INSERT INTO lms.modules (id, name, cron, lastcron, search, visible) VALUES (5, 'forum', 0, 0, NULL, 1);
INSERT INTO lms.modules (id, name, cron, lastcron, search, visible) VALUES (6, 'attendance', 0, 0, NULL, 1);


--
-- Data for Name: course_modules; Type: TABLE DATA; Schema: lms; Owner: -
--

INSERT INTO lms.course_modules (id, course, module, instance, section, idnumber, added, completionexpected, showdescription, availability, deletioninprogress, visible, visibleoncoursepage, completion, completiongradeitemnumber, completionview, score, indent, visibleold, groupmode, groupingid) VALUES (21101, 11, 1, 11101, 111, 'DB-A1', 1788016434, 1788707634, 1, NULL, 0, 1, 1, 1, NULL, 1, 0, 0, 1, 0, NULL);
INSERT INTO lms.course_modules (id, course, module, instance, section, idnumber, added, completionexpected, showdescription, availability, deletioninprogress, visible, visibleoncoursepage, completion, completiongradeitemnumber, completionview, score, indent, visibleold, groupmode, groupingid) VALUES (21102, 11, 1, 11102, 111, 'DB-A2', 1788621234, 1789053234, 1, NULL, 0, 1, 1, 1, NULL, 1, 0, 0, 1, 0, NULL);
INSERT INTO lms.course_modules (id, course, module, instance, section, idnumber, added, completionexpected, showdescription, availability, deletioninprogress, visible, visibleoncoursepage, completion, completiongradeitemnumber, completionview, score, indent, visibleold, groupmode, groupingid) VALUES (21201, 11, 2, 11201, 111, 'DB-Q1', 1788707634, 1789226034, 1, NULL, 0, 1, 1, 1, NULL, 1, 0, 0, 1, 0, NULL);
INSERT INTO lms.course_modules (id, course, module, instance, section, idnumber, added, completionexpected, showdescription, availability, deletioninprogress, visible, visibleoncoursepage, completion, completiongradeitemnumber, completionview, score, indent, visibleold, groupmode, groupingid) VALUES (22101, 12, 1, 12101, 121, 'JAVA-A1', 1788448434, 1788966834, 1, NULL, 0, 1, 1, 1, NULL, 1, 0, 0, 1, 0, NULL);
INSERT INTO lms.course_modules (id, course, module, instance, section, idnumber, added, completionexpected, showdescription, availability, deletioninprogress, visible, visibleoncoursepage, completion, completiongradeitemnumber, completionview, score, indent, visibleold, groupmode, groupingid) VALUES (22102, 12, 1, 12102, 121, 'JAVA-A2', 1788880434, 1789398834, 1, NULL, 0, 1, 1, 1, NULL, 1, 0, 0, 1, 0, NULL);
INSERT INTO lms.course_modules (id, course, module, instance, section, idnumber, added, completionexpected, showdescription, availability, deletioninprogress, visible, visibleoncoursepage, completion, completiongradeitemnumber, completionview, score, indent, visibleold, groupmode, groupingid) VALUES (22201, 12, 2, 12201, 121, 'JAVA-Q1', 1788275634, 1788794034, 1, NULL, 0, 1, 1, 1, NULL, 1, 0, 0, 1, 0, NULL);
INSERT INTO lms.course_modules (id, course, module, instance, section, idnumber, added, completionexpected, showdescription, availability, deletioninprogress, visible, visibleoncoursepage, completion, completiongradeitemnumber, completionview, score, indent, visibleold, groupmode, groupingid) VALUES (23101, 13, 1, 13101, 131, 'TEST-A1', 1788016434, 1788534834, 1, NULL, 0, 1, 1, 1, NULL, 1, 0, 0, 1, 0, NULL);
INSERT INTO lms.course_modules (id, course, module, instance, section, idnumber, added, completionexpected, showdescription, availability, deletioninprogress, visible, visibleoncoursepage, completion, completiongradeitemnumber, completionview, score, indent, visibleold, groupmode, groupingid) VALUES (23102, 13, 1, 13102, 131, 'TEST-A2', 1788707634, 1789139634, 1, NULL, 0, 1, 1, 1, NULL, 1, 0, 0, 1, 0, NULL);
INSERT INTO lms.course_modules (id, course, module, instance, section, idnumber, added, completionexpected, showdescription, availability, deletioninprogress, visible, visibleoncoursepage, completion, completiongradeitemnumber, completionview, score, indent, visibleold, groupmode, groupingid) VALUES (23201, 13, 2, 13201, 131, 'TEST-Q1', 1788794034, 1789312434, 1, NULL, 0, 1, 1, 1, NULL, 1, 0, 0, 1, 0, NULL);
INSERT INTO lms.course_modules (id, course, module, instance, section, idnumber, added, completionexpected, showdescription, availability, deletioninprogress, visible, visibleoncoursepage, completion, completiongradeitemnumber, completionview, score, indent, visibleold, groupmode, groupingid) VALUES (24101, 14, 1, 14101, 141, 'MOBILE-A1', 1788275634, 1788794034, 1, NULL, 0, 1, 1, 1, NULL, 1, 0, 0, 1, 0, NULL);
INSERT INTO lms.course_modules (id, course, module, instance, section, idnumber, added, completionexpected, showdescription, availability, deletioninprogress, visible, visibleoncoursepage, completion, completiongradeitemnumber, completionview, score, indent, visibleold, groupmode, groupingid) VALUES (24102, 14, 1, 14102, 141, 'MOBILE-A2', 1788880434, 1789485234, 1, NULL, 0, 1, 1, 1, NULL, 1, 0, 0, 1, 0, NULL);
INSERT INTO lms.course_modules (id, course, module, instance, section, idnumber, added, completionexpected, showdescription, availability, deletioninprogress, visible, visibleoncoursepage, completion, completiongradeitemnumber, completionview, score, indent, visibleold, groupmode, groupingid) VALUES (24301, 14, 3, 14301, 142, 'MOBILE-RESOURCE-01', 1786777225, 0, 1, NULL, 0, 1, 1, 0, NULL, 0, 0, 0, 1, 0, NULL);
INSERT INTO lms.course_modules (id, course, module, instance, section, idnumber, added, completionexpected, showdescription, availability, deletioninprogress, visible, visibleoncoursepage, completion, completiongradeitemnumber, completionview, score, indent, visibleold, groupmode, groupingid) VALUES (24302, 14, 4, 14302, 142, 'MOBILE-FOLDER-01', 1787209225, 0, 1, NULL, 0, 1, 1, 0, NULL, 0, 0, 0, 1, 0, NULL);
INSERT INTO lms.course_modules (id, course, module, instance, section, idnumber, added, completionexpected, showdescription, availability, deletioninprogress, visible, visibleoncoursepage, completion, completiongradeitemnumber, completionview, score, indent, visibleold, groupmode, groupingid) VALUES (24303, 14, 5, 14303, 140, 'MOBILE-ANNOUNCEMENTS', 1785913225, 0, 1, NULL, 0, 1, 1, 0, NULL, 0, 0, 0, 1, 0, NULL);
INSERT INTO lms.course_modules (id, course, module, instance, section, idnumber, added, completionexpected, showdescription, availability, deletioninprogress, visible, visibleoncoursepage, completion, completiongradeitemnumber, completionview, score, indent, visibleold, groupmode, groupingid) VALUES (24201, 14, 2, 14201, 143, 'MOBILE-Q1', 1788794034, 1789053234, 1, NULL, 0, 1, 1, 1, NULL, 1, 0, 0, 1, 0, NULL);
INSERT INTO lms.course_modules (id, course, module, instance, section, idnumber, added, completionexpected, showdescription, availability, deletioninprogress, visible, visibleoncoursepage, completion, completiongradeitemnumber, completionview, score, indent, visibleold, groupmode, groupingid) VALUES (24304, 14, 6, 14401, 143, 'MOBILE-ATTENDANCE', 1786777548, 0, 1, NULL, 0, 1, 1, 0, NULL, 0, 0, 0, 1, 0, NULL);


--
-- Data for Name: course_modules_completion; Type: TABLE DATA; Schema: lms; Owner: -
--

INSERT INTO lms.course_modules_completion (id, coursemoduleid, userid, completionstate, viewed, overrideby, timemodified) VALUES (1, 21201, 201, 1, 1, NULL, 1788880822);
INSERT INTO lms.course_modules_completion (id, coursemoduleid, userid, completionstate, viewed, overrideby, timemodified) VALUES (2, 21102, 201, 1, 1, NULL, 1788880822);
INSERT INTO lms.course_modules_completion (id, coursemoduleid, userid, completionstate, viewed, overrideby, timemodified) VALUES (3, 21101, 201, 1, 1, NULL, 1788880822);
INSERT INTO lms.course_modules_completion (id, coursemoduleid, userid, completionstate, viewed, overrideby, timemodified) VALUES (4, 21201, 202, 0, 0, NULL, 1788880822);
INSERT INTO lms.course_modules_completion (id, coursemoduleid, userid, completionstate, viewed, overrideby, timemodified) VALUES (5, 21102, 202, 1, 1, NULL, 1788880822);
INSERT INTO lms.course_modules_completion (id, coursemoduleid, userid, completionstate, viewed, overrideby, timemodified) VALUES (6, 21101, 202, 1, 1, NULL, 1788880822);
INSERT INTO lms.course_modules_completion (id, coursemoduleid, userid, completionstate, viewed, overrideby, timemodified) VALUES (7, 21201, 203, 0, 0, NULL, 1788880822);
INSERT INTO lms.course_modules_completion (id, coursemoduleid, userid, completionstate, viewed, overrideby, timemodified) VALUES (8, 21102, 203, 0, 0, NULL, 1788880822);
INSERT INTO lms.course_modules_completion (id, coursemoduleid, userid, completionstate, viewed, overrideby, timemodified) VALUES (9, 21101, 203, 0, 1, NULL, 1788880822);
INSERT INTO lms.course_modules_completion (id, coursemoduleid, userid, completionstate, viewed, overrideby, timemodified) VALUES (10, 21201, 204, 0, 0, NULL, 1788880822);
INSERT INTO lms.course_modules_completion (id, coursemoduleid, userid, completionstate, viewed, overrideby, timemodified) VALUES (11, 21102, 204, 0, 0, NULL, 1788880822);
INSERT INTO lms.course_modules_completion (id, coursemoduleid, userid, completionstate, viewed, overrideby, timemodified) VALUES (12, 21101, 204, 1, 1, NULL, 1788880822);
INSERT INTO lms.course_modules_completion (id, coursemoduleid, userid, completionstate, viewed, overrideby, timemodified) VALUES (13, 22201, 201, 1, 1, NULL, 1788880822);
INSERT INTO lms.course_modules_completion (id, coursemoduleid, userid, completionstate, viewed, overrideby, timemodified) VALUES (14, 22102, 201, 1, 1, NULL, 1788880822);
INSERT INTO lms.course_modules_completion (id, coursemoduleid, userid, completionstate, viewed, overrideby, timemodified) VALUES (15, 22101, 201, 1, 1, NULL, 1788880822);
INSERT INTO lms.course_modules_completion (id, coursemoduleid, userid, completionstate, viewed, overrideby, timemodified) VALUES (16, 22201, 202, 0, 0, NULL, 1788880822);
INSERT INTO lms.course_modules_completion (id, coursemoduleid, userid, completionstate, viewed, overrideby, timemodified) VALUES (17, 22102, 202, 0, 0, NULL, 1788880822);
INSERT INTO lms.course_modules_completion (id, coursemoduleid, userid, completionstate, viewed, overrideby, timemodified) VALUES (18, 22101, 202, 1, 1, NULL, 1788880822);
INSERT INTO lms.course_modules_completion (id, coursemoduleid, userid, completionstate, viewed, overrideby, timemodified) VALUES (19, 22201, 203, 0, 0, NULL, 1788880822);
INSERT INTO lms.course_modules_completion (id, coursemoduleid, userid, completionstate, viewed, overrideby, timemodified) VALUES (20, 22102, 203, 0, 0, NULL, 1788880822);
INSERT INTO lms.course_modules_completion (id, coursemoduleid, userid, completionstate, viewed, overrideby, timemodified) VALUES (21, 22101, 203, 0, 1, NULL, 1788880822);
INSERT INTO lms.course_modules_completion (id, coursemoduleid, userid, completionstate, viewed, overrideby, timemodified) VALUES (22, 22201, 204, 0, 0, NULL, 1788880822);
INSERT INTO lms.course_modules_completion (id, coursemoduleid, userid, completionstate, viewed, overrideby, timemodified) VALUES (23, 22102, 204, 1, 1, NULL, 1788880822);
INSERT INTO lms.course_modules_completion (id, coursemoduleid, userid, completionstate, viewed, overrideby, timemodified) VALUES (24, 22101, 204, 1, 1, NULL, 1788880822);
INSERT INTO lms.course_modules_completion (id, coursemoduleid, userid, completionstate, viewed, overrideby, timemodified) VALUES (25, 23201, 205, 1, 1, NULL, 1788880822);
INSERT INTO lms.course_modules_completion (id, coursemoduleid, userid, completionstate, viewed, overrideby, timemodified) VALUES (26, 23102, 205, 1, 1, NULL, 1788880822);
INSERT INTO lms.course_modules_completion (id, coursemoduleid, userid, completionstate, viewed, overrideby, timemodified) VALUES (27, 23101, 205, 1, 1, NULL, 1788880822);
INSERT INTO lms.course_modules_completion (id, coursemoduleid, userid, completionstate, viewed, overrideby, timemodified) VALUES (28, 23201, 206, 0, 0, NULL, 1788880822);
INSERT INTO lms.course_modules_completion (id, coursemoduleid, userid, completionstate, viewed, overrideby, timemodified) VALUES (29, 23102, 206, 1, 1, NULL, 1788880822);
INSERT INTO lms.course_modules_completion (id, coursemoduleid, userid, completionstate, viewed, overrideby, timemodified) VALUES (30, 23101, 206, 1, 1, NULL, 1788880822);
INSERT INTO lms.course_modules_completion (id, coursemoduleid, userid, completionstate, viewed, overrideby, timemodified) VALUES (31, 23201, 207, 0, 0, NULL, 1788880822);
INSERT INTO lms.course_modules_completion (id, coursemoduleid, userid, completionstate, viewed, overrideby, timemodified) VALUES (32, 23102, 207, 0, 0, NULL, 1788880822);
INSERT INTO lms.course_modules_completion (id, coursemoduleid, userid, completionstate, viewed, overrideby, timemodified) VALUES (33, 23101, 207, 0, 1, NULL, 1788880822);
INSERT INTO lms.course_modules_completion (id, coursemoduleid, userid, completionstate, viewed, overrideby, timemodified) VALUES (34, 23201, 208, 0, 0, NULL, 1788880822);
INSERT INTO lms.course_modules_completion (id, coursemoduleid, userid, completionstate, viewed, overrideby, timemodified) VALUES (35, 23102, 208, 0, 0, NULL, 1788880822);
INSERT INTO lms.course_modules_completion (id, coursemoduleid, userid, completionstate, viewed, overrideby, timemodified) VALUES (36, 23101, 208, 1, 1, NULL, 1788880822);
INSERT INTO lms.course_modules_completion (id, coursemoduleid, userid, completionstate, viewed, overrideby, timemodified) VALUES (37, 24201, 205, 0, 0, NULL, 1788880822);
INSERT INTO lms.course_modules_completion (id, coursemoduleid, userid, completionstate, viewed, overrideby, timemodified) VALUES (38, 24102, 205, 1, 1, NULL, 1788880822);
INSERT INTO lms.course_modules_completion (id, coursemoduleid, userid, completionstate, viewed, overrideby, timemodified) VALUES (39, 24101, 205, 1, 1, NULL, 1788880822);
INSERT INTO lms.course_modules_completion (id, coursemoduleid, userid, completionstate, viewed, overrideby, timemodified) VALUES (40, 24201, 206, 0, 0, NULL, 1788880822);
INSERT INTO lms.course_modules_completion (id, coursemoduleid, userid, completionstate, viewed, overrideby, timemodified) VALUES (41, 24102, 206, 1, 1, NULL, 1788880822);
INSERT INTO lms.course_modules_completion (id, coursemoduleid, userid, completionstate, viewed, overrideby, timemodified) VALUES (42, 24101, 206, 1, 1, NULL, 1788880822);
INSERT INTO lms.course_modules_completion (id, coursemoduleid, userid, completionstate, viewed, overrideby, timemodified) VALUES (43, 24201, 207, 0, 0, NULL, 1788880822);
INSERT INTO lms.course_modules_completion (id, coursemoduleid, userid, completionstate, viewed, overrideby, timemodified) VALUES (44, 24102, 207, 0, 0, NULL, 1788880822);
INSERT INTO lms.course_modules_completion (id, coursemoduleid, userid, completionstate, viewed, overrideby, timemodified) VALUES (45, 24101, 207, 0, 1, NULL, 1788880822);
INSERT INTO lms.course_modules_completion (id, coursemoduleid, userid, completionstate, viewed, overrideby, timemodified) VALUES (46, 24201, 208, 1, 1, NULL, 1788880822);
INSERT INTO lms.course_modules_completion (id, coursemoduleid, userid, completionstate, viewed, overrideby, timemodified) VALUES (47, 24102, 208, 1, 1, NULL, 1788880822);
INSERT INTO lms.course_modules_completion (id, coursemoduleid, userid, completionstate, viewed, overrideby, timemodified) VALUES (48, 24101, 208, 1, 1, NULL, 1788880822);


--
-- Data for Name: course_sections; Type: TABLE DATA; Schema: lms; Owner: -
--

INSERT INTO lms.course_sections (id, course, section, name, summary, summaryformat, sequence, visible, availability, timemodified) VALUES (111, 11, 1, 'Course Activities', 'Activities for Database Systems', 1, NULL, 1, NULL, 1788880434);
INSERT INTO lms.course_sections (id, course, section, name, summary, summaryformat, sequence, visible, availability, timemodified) VALUES (121, 12, 1, 'Course Activities', 'Activities for Java Programming', 1, NULL, 1, NULL, 1788880434);
INSERT INTO lms.course_sections (id, course, section, name, summary, summaryformat, sequence, visible, availability, timemodified) VALUES (131, 13, 1, 'Course Activities', 'Activities for Software Testing', 1, NULL, 1, NULL, 1788880434);
INSERT INTO lms.course_sections (id, course, section, name, summary, summaryformat, sequence, visible, availability, timemodified) VALUES (140, 14, 0, 'Tổng quan', 'General course information and announcements.', 1, '24303', 1, NULL, 1789369225);
INSERT INTO lms.course_sections (id, course, section, name, summary, summaryformat, sequence, visible, availability, timemodified) VALUES (142, 14, 1, 'Bài giảng', 'Lecture materials and learning resources.', 1, '24301,24302', 1, NULL, 1789369225);
INSERT INTO lms.course_sections (id, course, section, name, summary, summaryformat, sequence, visible, availability, timemodified) VALUES (141, 14, 2, 'Bài tập và thực hành', 'Assignments and practical activities.', 1, '24101,24102', 1, NULL, 1789369225);
INSERT INTO lms.course_sections (id, course, section, name, summary, summaryformat, sequence, visible, availability, timemodified) VALUES (143, 14, 3, 'Kiểm tra & Đánh giá', 'Quiz and assessment activities.', 1, '24201,24304', 1, NULL, 1789369225);


--
-- Data for Name: role; Type: TABLE DATA; Schema: lms; Owner: -
--

INSERT INTO lms.role (id, name, shortname, description, sortorder, archetype) VALUES (3, 'Teacher', 'editingteacher', 'Mock teacher role', 1, 'editingteacher');
INSERT INTO lms.role (id, name, shortname, description, sortorder, archetype) VALUES (5, 'Student', 'student', 'Mock student role', 2, 'student');


--
-- Data for Name: enrol; Type: TABLE DATA; Schema: lms; Owner: -
--

INSERT INTO lms.enrol (id, enrol, status, courseid, sortorder, name, enrolperiod, enrolstartdate, enrolenddate, expirynotify, expirythreshold, notifyall, password, cost, currency, roleid, customint1, customint2, customint3, customint4, customint5, customint6, customint7, customint8, customchar1, customchar2, customchar3, customdec1, customdec2, customtext1, customtext2, customtext3, customtext4, timecreated, timemodified) VALUES (1101, 'manual', 0, 11, 0, 'Student enrolment', 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1788880160, 1788880160);
INSERT INTO lms.enrol (id, enrol, status, courseid, sortorder, name, enrolperiod, enrolstartdate, enrolenddate, expirynotify, expirythreshold, notifyall, password, cost, currency, roleid, customint1, customint2, customint3, customint4, customint5, customint6, customint7, customint8, customchar1, customchar2, customchar3, customdec1, customdec2, customtext1, customtext2, customtext3, customtext4, timecreated, timemodified) VALUES (1102, 'manual', 0, 11, 0, 'Teacher enrolment', 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1788880160, 1788880160);
INSERT INTO lms.enrol (id, enrol, status, courseid, sortorder, name, enrolperiod, enrolstartdate, enrolenddate, expirynotify, expirythreshold, notifyall, password, cost, currency, roleid, customint1, customint2, customint3, customint4, customint5, customint6, customint7, customint8, customchar1, customchar2, customchar3, customdec1, customdec2, customtext1, customtext2, customtext3, customtext4, timecreated, timemodified) VALUES (1201, 'manual', 0, 12, 0, 'Student enrolment', 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1788880160, 1788880160);
INSERT INTO lms.enrol (id, enrol, status, courseid, sortorder, name, enrolperiod, enrolstartdate, enrolenddate, expirynotify, expirythreshold, notifyall, password, cost, currency, roleid, customint1, customint2, customint3, customint4, customint5, customint6, customint7, customint8, customchar1, customchar2, customchar3, customdec1, customdec2, customtext1, customtext2, customtext3, customtext4, timecreated, timemodified) VALUES (1202, 'manual', 0, 12, 0, 'Teacher enrolment', 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1788880160, 1788880160);
INSERT INTO lms.enrol (id, enrol, status, courseid, sortorder, name, enrolperiod, enrolstartdate, enrolenddate, expirynotify, expirythreshold, notifyall, password, cost, currency, roleid, customint1, customint2, customint3, customint4, customint5, customint6, customint7, customint8, customchar1, customchar2, customchar3, customdec1, customdec2, customtext1, customtext2, customtext3, customtext4, timecreated, timemodified) VALUES (1301, 'manual', 0, 13, 0, 'Student enrolment', 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1788880160, 1788880160);
INSERT INTO lms.enrol (id, enrol, status, courseid, sortorder, name, enrolperiod, enrolstartdate, enrolenddate, expirynotify, expirythreshold, notifyall, password, cost, currency, roleid, customint1, customint2, customint3, customint4, customint5, customint6, customint7, customint8, customchar1, customchar2, customchar3, customdec1, customdec2, customtext1, customtext2, customtext3, customtext4, timecreated, timemodified) VALUES (1302, 'manual', 0, 13, 0, 'Teacher enrolment', 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1788880160, 1788880160);
INSERT INTO lms.enrol (id, enrol, status, courseid, sortorder, name, enrolperiod, enrolstartdate, enrolenddate, expirynotify, expirythreshold, notifyall, password, cost, currency, roleid, customint1, customint2, customint3, customint4, customint5, customint6, customint7, customint8, customchar1, customchar2, customchar3, customdec1, customdec2, customtext1, customtext2, customtext3, customtext4, timecreated, timemodified) VALUES (1401, 'manual', 0, 14, 0, 'Student enrolment', 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1788880160, 1788880160);
INSERT INTO lms.enrol (id, enrol, status, courseid, sortorder, name, enrolperiod, enrolstartdate, enrolenddate, expirynotify, expirythreshold, notifyall, password, cost, currency, roleid, customint1, customint2, customint3, customint4, customint5, customint6, customint7, customint8, customchar1, customchar2, customchar3, customdec1, customdec2, customtext1, customtext2, customtext3, customtext4, timecreated, timemodified) VALUES (1402, 'manual', 0, 14, 0, 'Teacher enrolment', 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1788880160, 1788880160);


--
-- Data for Name: folder; Type: TABLE DATA; Schema: lms; Owner: -
--

INSERT INTO lms.folder (id, course, name, intro, introformat, revision, timemodified, display, showexpanded, showdownloadfolder) VALUES (14302, 14, 'New Slide', 'Lecture slides and reference documents.', 1, 1, 1789369225, 0, 1, 1);


--
-- Data for Name: forum; Type: TABLE DATA; Schema: lms; Owner: -
--

INSERT INTO lms.forum (id, course, type, name, intro, introformat, duedate, cutoffdate, assessed, assesstimestart, assesstimefinish, scale, grade_forum, grade_forum_notify, maxbytes, maxattachments, forcesubscribe, trackingtype, rsstype, rssarticles, timemodified, warnafter, blockafter, blockperiod, completiondiscussions, completionreplies, completionposts, displaywordcount, lockdiscussionafter) VALUES (14303, 14, 'news', 'Announcements', 'General news and announcements.', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1789369225, 0, 0, 0, 0, 0, 0, 0, 0);


--
-- Data for Name: grade_categories; Type: TABLE DATA; Schema: lms; Owner: -
--

INSERT INTO lms.grade_categories (id, courseid, parent, depth, path, fullname, aggregation, keephigh, droplow, aggregateonlygraded, aggregateoutcomes, timecreated, timemodified, hidden) VALUES (11001, 11, NULL, 1, '/11001', 'Course Grade', 0, 0, 0, 0, 0, 1789368921, 1789368921, 0);
INSERT INTO lms.grade_categories (id, courseid, parent, depth, path, fullname, aggregation, keephigh, droplow, aggregateonlygraded, aggregateoutcomes, timecreated, timemodified, hidden) VALUES (11002, 11, 11001, 2, '/11001/11002', 'Điểm quá trình', 0, 0, 0, 0, 0, 1789368921, 1789368921, 0);
INSERT INTO lms.grade_categories (id, courseid, parent, depth, path, fullname, aggregation, keephigh, droplow, aggregateonlygraded, aggregateoutcomes, timecreated, timemodified, hidden) VALUES (11003, 11, 11001, 2, '/11001/11003', 'Điểm cuối kỳ', 0, 0, 0, 0, 0, 1789368921, 1789368921, 0);
INSERT INTO lms.grade_categories (id, courseid, parent, depth, path, fullname, aggregation, keephigh, droplow, aggregateonlygraded, aggregateoutcomes, timecreated, timemodified, hidden) VALUES (12001, 12, NULL, 1, '/12001', 'Course Grade', 0, 0, 0, 0, 0, 1789368921, 1789368921, 0);
INSERT INTO lms.grade_categories (id, courseid, parent, depth, path, fullname, aggregation, keephigh, droplow, aggregateonlygraded, aggregateoutcomes, timecreated, timemodified, hidden) VALUES (12002, 12, 12001, 2, '/12001/12002', 'Điểm quá trình', 0, 0, 0, 0, 0, 1789368921, 1789368921, 0);
INSERT INTO lms.grade_categories (id, courseid, parent, depth, path, fullname, aggregation, keephigh, droplow, aggregateonlygraded, aggregateoutcomes, timecreated, timemodified, hidden) VALUES (12003, 12, 12001, 2, '/12001/12003', 'Điểm cuối kỳ', 0, 0, 0, 0, 0, 1789368921, 1789368921, 0);
INSERT INTO lms.grade_categories (id, courseid, parent, depth, path, fullname, aggregation, keephigh, droplow, aggregateonlygraded, aggregateoutcomes, timecreated, timemodified, hidden) VALUES (13001, 13, NULL, 1, '/13001', 'Course Grade', 0, 0, 0, 0, 0, 1789368921, 1789368921, 0);
INSERT INTO lms.grade_categories (id, courseid, parent, depth, path, fullname, aggregation, keephigh, droplow, aggregateonlygraded, aggregateoutcomes, timecreated, timemodified, hidden) VALUES (13002, 13, 13001, 2, '/13001/13002', 'Điểm quá trình', 0, 0, 0, 0, 0, 1789368921, 1789368921, 0);
INSERT INTO lms.grade_categories (id, courseid, parent, depth, path, fullname, aggregation, keephigh, droplow, aggregateonlygraded, aggregateoutcomes, timecreated, timemodified, hidden) VALUES (13003, 13, 13001, 2, '/13001/13003', 'Điểm cuối kỳ', 0, 0, 0, 0, 0, 1789368921, 1789368921, 0);
INSERT INTO lms.grade_categories (id, courseid, parent, depth, path, fullname, aggregation, keephigh, droplow, aggregateonlygraded, aggregateoutcomes, timecreated, timemodified, hidden) VALUES (14001, 14, NULL, 1, '/14001', 'Course Grade', 0, 0, 0, 0, 0, 1789368921, 1789368921, 0);
INSERT INTO lms.grade_categories (id, courseid, parent, depth, path, fullname, aggregation, keephigh, droplow, aggregateonlygraded, aggregateoutcomes, timecreated, timemodified, hidden) VALUES (14002, 14, 14001, 2, '/14001/14002', 'Điểm quá trình', 0, 0, 0, 0, 0, 1789368921, 1789368921, 0);
INSERT INTO lms.grade_categories (id, courseid, parent, depth, path, fullname, aggregation, keephigh, droplow, aggregateonlygraded, aggregateoutcomes, timecreated, timemodified, hidden) VALUES (14003, 14, 14001, 2, '/14001/14003', 'Điểm cuối kỳ', 0, 0, 0, 0, 0, 1789368921, 1789368921, 0);


--
-- Data for Name: grade_items; Type: TABLE DATA; Schema: lms; Owner: -
--

INSERT INTO lms.grade_items (id, courseid, categoryid, itemname, itemtype, itemmodule, iteminstance, itemnumber, iteminfo, idnumber, calculation, gradetype, grademax, grademin, scaleid, outcomeid, gradepass, multfactor, plusfactor, aggregationcoef, aggregationcoef2, sortorder, display, decimals, hidden, locked, locktime, needsupdate, weightoverride, timecreated, timemodified) VALUES (511101, 11, 11002, 'Database Design Assignment', 'mod', 'assign', 11101, 0, NULL, NULL, NULL, 1, 100.00000, 0.00000, NULL, NULL, 50.00000, 1.00000, 0.00000, 0.00000, 0.00000, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL);
INSERT INTO lms.grade_items (id, courseid, categoryid, itemname, itemtype, itemmodule, iteminstance, itemnumber, iteminfo, idnumber, calculation, gradetype, grademax, grademin, scaleid, outcomeid, gradepass, multfactor, plusfactor, aggregationcoef, aggregationcoef2, sortorder, display, decimals, hidden, locked, locktime, needsupdate, weightoverride, timecreated, timemodified) VALUES (511102, 11, 11002, 'SQL Query Assignment', 'mod', 'assign', 11102, 0, NULL, NULL, NULL, 1, 100.00000, 0.00000, NULL, NULL, 50.00000, 1.00000, 0.00000, 0.00000, 0.00000, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL);
INSERT INTO lms.grade_items (id, courseid, categoryid, itemname, itemtype, itemmodule, iteminstance, itemnumber, iteminfo, idnumber, calculation, gradetype, grademax, grademin, scaleid, outcomeid, gradepass, multfactor, plusfactor, aggregationcoef, aggregationcoef2, sortorder, display, decimals, hidden, locked, locktime, needsupdate, weightoverride, timecreated, timemodified) VALUES (611201, 11, 11003, 'Database Quiz', 'mod', 'quiz', 11201, 0, NULL, NULL, NULL, 1, 100.00000, 0.00000, NULL, NULL, 50.00000, 1.00000, 0.00000, 0.00000, 0.00000, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL);
INSERT INTO lms.grade_items (id, courseid, categoryid, itemname, itemtype, itemmodule, iteminstance, itemnumber, iteminfo, idnumber, calculation, gradetype, grademax, grademin, scaleid, outcomeid, gradepass, multfactor, plusfactor, aggregationcoef, aggregationcoef2, sortorder, display, decimals, hidden, locked, locktime, needsupdate, weightoverride, timecreated, timemodified) VALUES (512101, 12, 12002, 'Java OOP Assignment', 'mod', 'assign', 12101, 0, NULL, NULL, NULL, 1, 100.00000, 0.00000, NULL, NULL, 50.00000, 1.00000, 0.00000, 0.00000, 0.00000, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL);
INSERT INTO lms.grade_items (id, courseid, categoryid, itemname, itemtype, itemmodule, iteminstance, itemnumber, iteminfo, idnumber, calculation, gradetype, grademax, grademin, scaleid, outcomeid, gradepass, multfactor, plusfactor, aggregationcoef, aggregationcoef2, sortorder, display, decimals, hidden, locked, locktime, needsupdate, weightoverride, timecreated, timemodified) VALUES (512102, 12, 12002, 'Java Collections Assignment', 'mod', 'assign', 12102, 0, NULL, NULL, NULL, 1, 100.00000, 0.00000, NULL, NULL, 50.00000, 1.00000, 0.00000, 0.00000, 0.00000, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL);
INSERT INTO lms.grade_items (id, courseid, categoryid, itemname, itemtype, itemmodule, iteminstance, itemnumber, iteminfo, idnumber, calculation, gradetype, grademax, grademin, scaleid, outcomeid, gradepass, multfactor, plusfactor, aggregationcoef, aggregationcoef2, sortorder, display, decimals, hidden, locked, locktime, needsupdate, weightoverride, timecreated, timemodified) VALUES (612201, 12, 12003, 'Java Quiz', 'mod', 'quiz', 12201, 0, NULL, NULL, NULL, 1, 100.00000, 0.00000, NULL, NULL, 50.00000, 1.00000, 0.00000, 0.00000, 0.00000, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL);
INSERT INTO lms.grade_items (id, courseid, categoryid, itemname, itemtype, itemmodule, iteminstance, itemnumber, iteminfo, idnumber, calculation, gradetype, grademax, grademin, scaleid, outcomeid, gradepass, multfactor, plusfactor, aggregationcoef, aggregationcoef2, sortorder, display, decimals, hidden, locked, locktime, needsupdate, weightoverride, timecreated, timemodified) VALUES (513101, 13, 13002, 'Boundary Value Assignment', 'mod', 'assign', 13101, 0, NULL, NULL, NULL, 1, 100.00000, 0.00000, NULL, NULL, 50.00000, 1.00000, 0.00000, 0.00000, 0.00000, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL);
INSERT INTO lms.grade_items (id, courseid, categoryid, itemname, itemtype, itemmodule, iteminstance, itemnumber, iteminfo, idnumber, calculation, gradetype, grademax, grademin, scaleid, outcomeid, gradepass, multfactor, plusfactor, aggregationcoef, aggregationcoef2, sortorder, display, decimals, hidden, locked, locktime, needsupdate, weightoverride, timecreated, timemodified) VALUES (513102, 13, 13002, 'Decision Table Assignment', 'mod', 'assign', 13102, 0, NULL, NULL, NULL, 1, 100.00000, 0.00000, NULL, NULL, 50.00000, 1.00000, 0.00000, 0.00000, 0.00000, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL);
INSERT INTO lms.grade_items (id, courseid, categoryid, itemname, itemtype, itemmodule, iteminstance, itemnumber, iteminfo, idnumber, calculation, gradetype, grademax, grademin, scaleid, outcomeid, gradepass, multfactor, plusfactor, aggregationcoef, aggregationcoef2, sortorder, display, decimals, hidden, locked, locktime, needsupdate, weightoverride, timecreated, timemodified) VALUES (613201, 13, 13003, 'Software Testing Quiz', 'mod', 'quiz', 13201, 0, NULL, NULL, NULL, 1, 100.00000, 0.00000, NULL, NULL, 50.00000, 1.00000, 0.00000, 0.00000, 0.00000, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL);
INSERT INTO lms.grade_items (id, courseid, categoryid, itemname, itemtype, itemmodule, iteminstance, itemnumber, iteminfo, idnumber, calculation, gradetype, grademax, grademin, scaleid, outcomeid, gradepass, multfactor, plusfactor, aggregationcoef, aggregationcoef2, sortorder, display, decimals, hidden, locked, locktime, needsupdate, weightoverride, timecreated, timemodified) VALUES (514101, 14, 14002, 'Android UI Assignment', 'mod', 'assign', 14101, 0, NULL, NULL, NULL, 1, 100.00000, 0.00000, NULL, NULL, 50.00000, 1.00000, 0.00000, 0.00000, 0.00000, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL);
INSERT INTO lms.grade_items (id, courseid, categoryid, itemname, itemtype, itemmodule, iteminstance, itemnumber, iteminfo, idnumber, calculation, gradetype, grademax, grademin, scaleid, outcomeid, gradepass, multfactor, plusfactor, aggregationcoef, aggregationcoef2, sortorder, display, decimals, hidden, locked, locktime, needsupdate, weightoverride, timecreated, timemodified) VALUES (514102, 14, 14002, 'Android API Assignment', 'mod', 'assign', 14102, 0, NULL, NULL, NULL, 1, 100.00000, 0.00000, NULL, NULL, 50.00000, 1.00000, 0.00000, 0.00000, 0.00000, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL);
INSERT INTO lms.grade_items (id, courseid, categoryid, itemname, itemtype, itemmodule, iteminstance, itemnumber, iteminfo, idnumber, calculation, gradetype, grademax, grademin, scaleid, outcomeid, gradepass, multfactor, plusfactor, aggregationcoef, aggregationcoef2, sortorder, display, decimals, hidden, locked, locktime, needsupdate, weightoverride, timecreated, timemodified) VALUES (614201, 14, 14003, 'Android Quiz', 'mod', 'quiz', 14201, 0, NULL, NULL, NULL, 1, 100.00000, 0.00000, NULL, NULL, 50.00000, 1.00000, 0.00000, 0.00000, 0.00000, 0, 0, NULL, 0, 0, 0, 0, 0, NULL, NULL);


--
-- Data for Name: grade_grades; Type: TABLE DATA; Schema: lms; Owner: -
--

INSERT INTO lms.grade_grades (id, itemid, userid, rawgrade, rawgrademax, rawgrademin, rawscaleid, usermodified, finalgrade, hidden, locked, locktime, exported, overridden, excluded, feedback, feedbackformat, information, informationformat, timecreated, timemodified, aggregationstatus, aggregationweight) VALUES (1, 511101, 201, 90.00000, 100.00000, 0.00000, NULL, 101, 90.00000, 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 1788880434, 1788880434, 'unknown', NULL);
INSERT INTO lms.grade_grades (id, itemid, userid, rawgrade, rawgrademax, rawgrademin, rawscaleid, usermodified, finalgrade, hidden, locked, locktime, exported, overridden, excluded, feedback, feedbackformat, information, informationformat, timecreated, timemodified, aggregationstatus, aggregationweight) VALUES (2, 511101, 204, 75.00000, 100.00000, 0.00000, NULL, 101, 75.00000, 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 1788880434, 1788880434, 'unknown', NULL);
INSERT INTO lms.grade_grades (id, itemid, userid, rawgrade, rawgrademax, rawgrademin, rawscaleid, usermodified, finalgrade, hidden, locked, locktime, exported, overridden, excluded, feedback, feedbackformat, information, informationformat, timecreated, timemodified, aggregationstatus, aggregationweight) VALUES (3, 511102, 201, 85.00000, 100.00000, 0.00000, NULL, 101, 85.00000, 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 1788880434, 1788880434, 'unknown', NULL);
INSERT INTO lms.grade_grades (id, itemid, userid, rawgrade, rawgrademax, rawgrademin, rawscaleid, usermodified, finalgrade, hidden, locked, locktime, exported, overridden, excluded, feedback, feedbackformat, information, informationformat, timecreated, timemodified, aggregationstatus, aggregationweight) VALUES (4, 512101, 201, 88.00000, 100.00000, 0.00000, NULL, 101, 88.00000, 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 1788880434, 1788880434, 'unknown', NULL);
INSERT INTO lms.grade_grades (id, itemid, userid, rawgrade, rawgrademax, rawgrademin, rawscaleid, usermodified, finalgrade, hidden, locked, locktime, exported, overridden, excluded, feedback, feedbackformat, information, informationformat, timecreated, timemodified, aggregationstatus, aggregationweight) VALUES (5, 513101, 205, 95.00000, 100.00000, 0.00000, NULL, 102, 95.00000, 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 1788880434, 1788880434, 'unknown', NULL);
INSERT INTO lms.grade_grades (id, itemid, userid, rawgrade, rawgrademax, rawgrademin, rawscaleid, usermodified, finalgrade, hidden, locked, locktime, exported, overridden, excluded, feedback, feedbackformat, information, informationformat, timecreated, timemodified, aggregationstatus, aggregationweight) VALUES (6, 513101, 208, 78.00000, 100.00000, 0.00000, NULL, 102, 78.00000, 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 1788880434, 1788880434, 'unknown', NULL);
INSERT INTO lms.grade_grades (id, itemid, userid, rawgrade, rawgrademax, rawgrademin, rawscaleid, usermodified, finalgrade, hidden, locked, locktime, exported, overridden, excluded, feedback, feedbackformat, information, informationformat, timecreated, timemodified, aggregationstatus, aggregationweight) VALUES (7, 513102, 205, 92.00000, 100.00000, 0.00000, NULL, 102, 92.00000, 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 1788880434, 1788880434, 'unknown', NULL);
INSERT INTO lms.grade_grades (id, itemid, userid, rawgrade, rawgrademax, rawgrademin, rawscaleid, usermodified, finalgrade, hidden, locked, locktime, exported, overridden, excluded, feedback, feedbackformat, information, informationformat, timecreated, timemodified, aggregationstatus, aggregationweight) VALUES (8, 514101, 205, 90.00000, 100.00000, 0.00000, NULL, 102, 90.00000, 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 1788880434, 1788880434, 'unknown', NULL);
INSERT INTO lms.grade_grades (id, itemid, userid, rawgrade, rawgrademax, rawgrademin, rawscaleid, usermodified, finalgrade, hidden, locked, locktime, exported, overridden, excluded, feedback, feedbackformat, information, informationformat, timecreated, timemodified, aggregationstatus, aggregationweight) VALUES (9, 514101, 206, 70.00000, 100.00000, 0.00000, NULL, 102, 70.00000, 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 1788880434, 1788880434, 'unknown', NULL);
INSERT INTO lms.grade_grades (id, itemid, userid, rawgrade, rawgrademax, rawgrademin, rawscaleid, usermodified, finalgrade, hidden, locked, locktime, exported, overridden, excluded, feedback, feedbackformat, information, informationformat, timecreated, timemodified, aggregationstatus, aggregationweight) VALUES (10, 514102, 208, 85.00000, 100.00000, 0.00000, NULL, 102, 85.00000, 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 1788880434, 1788880434, 'unknown', NULL);
INSERT INTO lms.grade_grades (id, itemid, userid, rawgrade, rawgrademax, rawgrademin, rawscaleid, usermodified, finalgrade, hidden, locked, locktime, exported, overridden, excluded, feedback, feedbackformat, information, informationformat, timecreated, timemodified, aggregationstatus, aggregationweight) VALUES (11, 611201, 201, 88.00000, 100.00000, 0.00000, NULL, NULL, 88.00000, 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 1788880434, 1788880434, 'unknown', NULL);
INSERT INTO lms.grade_grades (id, itemid, userid, rawgrade, rawgrademax, rawgrademin, rawscaleid, usermodified, finalgrade, hidden, locked, locktime, exported, overridden, excluded, feedback, feedbackformat, information, informationformat, timecreated, timemodified, aggregationstatus, aggregationweight) VALUES (12, 611201, 202, 72.00000, 100.00000, 0.00000, NULL, NULL, 72.00000, 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 1788880434, 1788880434, 'unknown', NULL);
INSERT INTO lms.grade_grades (id, itemid, userid, rawgrade, rawgrademax, rawgrademin, rawscaleid, usermodified, finalgrade, hidden, locked, locktime, exported, overridden, excluded, feedback, feedbackformat, information, informationformat, timecreated, timemodified, aggregationstatus, aggregationweight) VALUES (13, 612201, 201, 91.00000, 100.00000, 0.00000, NULL, NULL, 91.00000, 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 1788880434, 1788880434, 'unknown', NULL);
INSERT INTO lms.grade_grades (id, itemid, userid, rawgrade, rawgrademax, rawgrademin, rawscaleid, usermodified, finalgrade, hidden, locked, locktime, exported, overridden, excluded, feedback, feedbackformat, information, informationformat, timecreated, timemodified, aggregationstatus, aggregationweight) VALUES (14, 612201, 204, 68.00000, 100.00000, 0.00000, NULL, NULL, 68.00000, 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 1788880434, 1788880434, 'unknown', NULL);
INSERT INTO lms.grade_grades (id, itemid, userid, rawgrade, rawgrademax, rawgrademin, rawscaleid, usermodified, finalgrade, hidden, locked, locktime, exported, overridden, excluded, feedback, feedbackformat, information, informationformat, timecreated, timemodified, aggregationstatus, aggregationweight) VALUES (15, 613201, 205, 94.00000, 100.00000, 0.00000, NULL, NULL, 94.00000, 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 1788880434, 1788880434, 'unknown', NULL);
INSERT INTO lms.grade_grades (id, itemid, userid, rawgrade, rawgrademax, rawgrademin, rawscaleid, usermodified, finalgrade, hidden, locked, locktime, exported, overridden, excluded, feedback, feedbackformat, information, informationformat, timecreated, timemodified, aggregationstatus, aggregationweight) VALUES (16, 613201, 206, 74.00000, 100.00000, 0.00000, NULL, NULL, 74.00000, 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 1788880434, 1788880434, 'unknown', NULL);
INSERT INTO lms.grade_grades (id, itemid, userid, rawgrade, rawgrademax, rawgrademin, rawscaleid, usermodified, finalgrade, hidden, locked, locktime, exported, overridden, excluded, feedback, feedbackformat, information, informationformat, timecreated, timemodified, aggregationstatus, aggregationweight) VALUES (17, 614201, 205, 89.00000, 100.00000, 0.00000, NULL, NULL, 89.00000, 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 1788880434, 1788880434, 'unknown', NULL);
INSERT INTO lms.grade_grades (id, itemid, userid, rawgrade, rawgrademax, rawgrademin, rawscaleid, usermodified, finalgrade, hidden, locked, locktime, exported, overridden, excluded, feedback, feedbackformat, information, informationformat, timecreated, timemodified, aggregationstatus, aggregationweight) VALUES (18, 614201, 208, 93.00000, 100.00000, 0.00000, NULL, NULL, 93.00000, 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 1788880434, 1788880434, 'unknown', NULL);


--
-- Data for Name: groups; Type: TABLE DATA; Schema: lms; Owner: -
--

INSERT INTO lms.groups (id, courseid, idnumber, name, description, descriptionformat, enrolmentkey, picture, hidepicture, timecreated, timemodified) VALUES (14001, 14, 'CTK46A', 'CTK46A', 'Mock class group A.', 1, NULL, 0, 0, 1789368921, 1789368921);
INSERT INTO lms.groups (id, courseid, idnumber, name, description, descriptionformat, enrolmentkey, picture, hidepicture, timecreated, timemodified) VALUES (14002, 14, 'CTK46B', 'CTK46B', 'Mock class group B.', 1, NULL, 0, 0, 1789368921, 1789368921);
INSERT INTO lms.groups (id, courseid, idnumber, name, description, descriptionformat, enrolmentkey, picture, hidepicture, timecreated, timemodified) VALUES (14014, 14, 'GROUP-14', 'Nhóm 14', 'Mock assignment/seminar group.', 1, NULL, 0, 0, 1789368921, 1789368921);


--
-- Data for Name: groupings_groups; Type: TABLE DATA; Schema: lms; Owner: -
--

INSERT INTO lms.groupings_groups (id, groupingid, groupid, timeadded) VALUES (1, 14101, 14001, 1789368921);
INSERT INTO lms.groupings_groups (id, groupingid, groupid, timeadded) VALUES (2, 14101, 14002, 1789368921);
INSERT INTO lms.groupings_groups (id, groupingid, groupid, timeadded) VALUES (3, 14102, 14014, 1789368921);


--
-- Data for Name: groups_members; Type: TABLE DATA; Schema: lms; Owner: -
--

INSERT INTO lms.groups_members (id, groupid, userid, timeadded, component, itemid) VALUES (1, 14001, 205, 1789368921, '', 0);
INSERT INTO lms.groups_members (id, groupid, userid, timeadded, component, itemid) VALUES (2, 14001, 206, 1789368921, '', 0);
INSERT INTO lms.groups_members (id, groupid, userid, timeadded, component, itemid) VALUES (3, 14002, 207, 1789368921, '', 0);
INSERT INTO lms.groups_members (id, groupid, userid, timeadded, component, itemid) VALUES (4, 14002, 208, 1789368921, '', 0);
INSERT INTO lms.groups_members (id, groupid, userid, timeadded, component, itemid) VALUES (5, 14014, 205, 1789368921, '', 0);
INSERT INTO lms.groups_members (id, groupid, userid, timeadded, component, itemid) VALUES (6, 14014, 208, 1789368921, '', 0);


--
-- Data for Name: logstore_standard_log; Type: TABLE DATA; Schema: lms; Owner: -
--

INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (1, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 11, 'r', 2, 5011, 50, 11, 201, 11, NULL, 0, NULL, 1788879622, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (2, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 11, 'r', 2, 5011, 50, 11, 201, 11, NULL, 0, NULL, 1788792022, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (3, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 11, 'r', 2, 5011, 50, 11, 201, 11, NULL, 0, NULL, 1788704422, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (4, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 11, 'r', 2, 5011, 50, 11, 201, 11, NULL, 0, NULL, 1788616822, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (5, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 11, 'r', 2, 5011, 50, 11, 201, 11, NULL, 0, NULL, 1788529222, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (6, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 11, 'r', 2, 5011, 50, 11, 201, 11, NULL, 0, NULL, 1788441622, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (7, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 11, 'r', 2, 5011, 50, 11, 201, 11, NULL, 0, NULL, 1788872422, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (8, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 11, 'r', 2, 5011, 50, 11, 201, 11, NULL, 0, NULL, 1788784822, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (9, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 11, 'r', 2, 5011, 50, 11, 201, 11, NULL, 0, NULL, 1788697222, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (10, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 11, 'r', 2, 5011, 50, 11, 201, 11, NULL, 0, NULL, 1788609622, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (11, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 11, 'r', 2, 5011, 50, 11, 201, 11, NULL, 0, NULL, 1788522022, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (12, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 11, 'r', 2, 5011, 50, 11, 201, 11, NULL, 0, NULL, 1788434422, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (13, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 11, 'r', 2, 5011, 50, 11, 201, 11, NULL, 0, NULL, 1788865222, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (14, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 11, 'r', 2, 5011, 50, 11, 201, 11, NULL, 0, NULL, 1788777622, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (15, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 11, 'r', 2, 5011, 50, 11, 201, 11, NULL, 0, NULL, 1788690022, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (16, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 11, 'r', 2, 5011, 50, 11, 201, 11, NULL, 0, NULL, 1788602422, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (17, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 11, 'r', 2, 5011, 50, 11, 201, 11, NULL, 0, NULL, 1788514822, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (18, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 11, 'r', 2, 5011, 50, 11, 201, 11, NULL, 0, NULL, 1788427222, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (19, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 11, 'r', 2, 5011, 50, 11, 201, 11, NULL, 0, NULL, 1788858022, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (20, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 11, 'r', 2, 5011, 50, 11, 201, 11, NULL, 0, NULL, 1788770422, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (21, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 12, 'r', 2, 5012, 50, 12, 201, 12, NULL, 0, NULL, 1788879622, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (22, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 12, 'r', 2, 5012, 50, 12, 201, 12, NULL, 0, NULL, 1788792022, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (23, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 12, 'r', 2, 5012, 50, 12, 201, 12, NULL, 0, NULL, 1788704422, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (24, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 12, 'r', 2, 5012, 50, 12, 201, 12, NULL, 0, NULL, 1788616822, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (25, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 12, 'r', 2, 5012, 50, 12, 201, 12, NULL, 0, NULL, 1788529222, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (26, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 12, 'r', 2, 5012, 50, 12, 201, 12, NULL, 0, NULL, 1788441622, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (27, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 12, 'r', 2, 5012, 50, 12, 201, 12, NULL, 0, NULL, 1788872422, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (28, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 12, 'r', 2, 5012, 50, 12, 201, 12, NULL, 0, NULL, 1788784822, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (29, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 12, 'r', 2, 5012, 50, 12, 201, 12, NULL, 0, NULL, 1788697222, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (30, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 12, 'r', 2, 5012, 50, 12, 201, 12, NULL, 0, NULL, 1788609622, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (31, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 12, 'r', 2, 5012, 50, 12, 201, 12, NULL, 0, NULL, 1788522022, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (32, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 12, 'r', 2, 5012, 50, 12, 201, 12, NULL, 0, NULL, 1788434422, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (33, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 12, 'r', 2, 5012, 50, 12, 201, 12, NULL, 0, NULL, 1788865222, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (34, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 12, 'r', 2, 5012, 50, 12, 201, 12, NULL, 0, NULL, 1788777622, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (35, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 12, 'r', 2, 5012, 50, 12, 201, 12, NULL, 0, NULL, 1788690022, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (36, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 12, 'r', 2, 5012, 50, 12, 201, 12, NULL, 0, NULL, 1788602422, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (37, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 12, 'r', 2, 5012, 50, 12, 201, 12, NULL, 0, NULL, 1788514822, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (38, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 12, 'r', 2, 5012, 50, 12, 201, 12, NULL, 0, NULL, 1788427222, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (39, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 11, 'r', 2, 5011, 50, 11, 202, 11, NULL, 0, NULL, 1788879622, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (40, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 11, 'r', 2, 5011, 50, 11, 202, 11, NULL, 0, NULL, 1788792022, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (41, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 11, 'r', 2, 5011, 50, 11, 202, 11, NULL, 0, NULL, 1788704422, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (42, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 11, 'r', 2, 5011, 50, 11, 202, 11, NULL, 0, NULL, 1788616822, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (43, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 11, 'r', 2, 5011, 50, 11, 202, 11, NULL, 0, NULL, 1788529222, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (44, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 11, 'r', 2, 5011, 50, 11, 202, 11, NULL, 0, NULL, 1788441622, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (45, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 11, 'r', 2, 5011, 50, 11, 202, 11, NULL, 0, NULL, 1788872422, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (46, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 11, 'r', 2, 5011, 50, 11, 202, 11, NULL, 0, NULL, 1788784822, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (47, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 12, 'r', 2, 5012, 50, 12, 202, 12, NULL, 0, NULL, 1788879622, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (48, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 12, 'r', 2, 5012, 50, 12, 202, 12, NULL, 0, NULL, 1788792022, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (49, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 12, 'r', 2, 5012, 50, 12, 202, 12, NULL, 0, NULL, 1788704422, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (50, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 12, 'r', 2, 5012, 50, 12, 202, 12, NULL, 0, NULL, 1788616822, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (51, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 12, 'r', 2, 5012, 50, 12, 202, 12, NULL, 0, NULL, 1788529222, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (52, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 12, 'r', 2, 5012, 50, 12, 202, 12, NULL, 0, NULL, 1788441622, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (53, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 11, 'r', 2, 5011, 50, 11, 204, 11, NULL, 0, NULL, 1788879622, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (54, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 11, 'r', 2, 5011, 50, 11, 204, 11, NULL, 0, NULL, 1788792022, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (55, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 11, 'r', 2, 5011, 50, 11, 204, 11, NULL, 0, NULL, 1788704422, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (56, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 11, 'r', 2, 5011, 50, 11, 204, 11, NULL, 0, NULL, 1788616822, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (57, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 11, 'r', 2, 5011, 50, 11, 204, 11, NULL, 0, NULL, 1788529222, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (58, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 12, 'r', 2, 5012, 50, 12, 204, 12, NULL, 0, NULL, 1788879622, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (59, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 12, 'r', 2, 5012, 50, 12, 204, 12, NULL, 0, NULL, 1788792022, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (60, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 12, 'r', 2, 5012, 50, 12, 204, 12, NULL, 0, NULL, 1788704422, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (61, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 12, 'r', 2, 5012, 50, 12, 204, 12, NULL, 0, NULL, 1788616822, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (62, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 12, 'r', 2, 5012, 50, 12, 204, 12, NULL, 0, NULL, 1788529222, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (63, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 12, 'r', 2, 5012, 50, 12, 204, 12, NULL, 0, NULL, 1788441622, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (64, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 12, 'r', 2, 5012, 50, 12, 204, 12, NULL, 0, NULL, 1788872422, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (65, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 12, 'r', 2, 5012, 50, 12, 204, 12, NULL, 0, NULL, 1788784822, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (66, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 12, 'r', 2, 5012, 50, 12, 204, 12, NULL, 0, NULL, 1788697222, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (67, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 12, 'r', 2, 5012, 50, 12, 204, 12, NULL, 0, NULL, 1788609622, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (68, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 13, 'r', 2, 5013, 50, 13, 205, 13, NULL, 0, NULL, 1788879622, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (69, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 13, 'r', 2, 5013, 50, 13, 205, 13, NULL, 0, NULL, 1788792022, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (70, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 13, 'r', 2, 5013, 50, 13, 205, 13, NULL, 0, NULL, 1788704422, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (71, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 13, 'r', 2, 5013, 50, 13, 205, 13, NULL, 0, NULL, 1788616822, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (72, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 13, 'r', 2, 5013, 50, 13, 205, 13, NULL, 0, NULL, 1788529222, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (73, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 13, 'r', 2, 5013, 50, 13, 205, 13, NULL, 0, NULL, 1788441622, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (74, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 13, 'r', 2, 5013, 50, 13, 205, 13, NULL, 0, NULL, 1788872422, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (75, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 13, 'r', 2, 5013, 50, 13, 205, 13, NULL, 0, NULL, 1788784822, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (76, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 13, 'r', 2, 5013, 50, 13, 205, 13, NULL, 0, NULL, 1788697222, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (77, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 13, 'r', 2, 5013, 50, 13, 205, 13, NULL, 0, NULL, 1788609622, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (78, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 13, 'r', 2, 5013, 50, 13, 205, 13, NULL, 0, NULL, 1788522022, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (79, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 13, 'r', 2, 5013, 50, 13, 205, 13, NULL, 0, NULL, 1788434422, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (80, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 13, 'r', 2, 5013, 50, 13, 205, 13, NULL, 0, NULL, 1788865222, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (81, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 13, 'r', 2, 5013, 50, 13, 205, 13, NULL, 0, NULL, 1788777622, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (82, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 13, 'r', 2, 5013, 50, 13, 205, 13, NULL, 0, NULL, 1788690022, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (83, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 13, 'r', 2, 5013, 50, 13, 205, 13, NULL, 0, NULL, 1788602422, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (84, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 13, 'r', 2, 5013, 50, 13, 205, 13, NULL, 0, NULL, 1788514822, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (85, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 13, 'r', 2, 5013, 50, 13, 205, 13, NULL, 0, NULL, 1788427222, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (86, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 13, 'r', 2, 5013, 50, 13, 205, 13, NULL, 0, NULL, 1788858022, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (87, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 13, 'r', 2, 5013, 50, 13, 205, 13, NULL, 0, NULL, 1788770422, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (88, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 13, 'r', 2, 5013, 50, 13, 205, 13, NULL, 0, NULL, 1788682822, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (89, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 13, 'r', 2, 5013, 50, 13, 205, 13, NULL, 0, NULL, 1788595222, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (90, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 14, 'r', 2, 5014, 50, 14, 205, 14, NULL, 0, NULL, 1788879622, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (91, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 14, 'r', 2, 5014, 50, 14, 205, 14, NULL, 0, NULL, 1788792022, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (92, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 14, 'r', 2, 5014, 50, 14, 205, 14, NULL, 0, NULL, 1788704422, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (93, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 14, 'r', 2, 5014, 50, 14, 205, 14, NULL, 0, NULL, 1788616822, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (94, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 14, 'r', 2, 5014, 50, 14, 205, 14, NULL, 0, NULL, 1788529222, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (95, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 14, 'r', 2, 5014, 50, 14, 205, 14, NULL, 0, NULL, 1788441622, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (96, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 14, 'r', 2, 5014, 50, 14, 205, 14, NULL, 0, NULL, 1788872422, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (97, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 14, 'r', 2, 5014, 50, 14, 205, 14, NULL, 0, NULL, 1788784822, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (98, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 14, 'r', 2, 5014, 50, 14, 205, 14, NULL, 0, NULL, 1788697222, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (99, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 14, 'r', 2, 5014, 50, 14, 205, 14, NULL, 0, NULL, 1788609622, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (100, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 14, 'r', 2, 5014, 50, 14, 205, 14, NULL, 0, NULL, 1788522022, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (101, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 14, 'r', 2, 5014, 50, 14, 205, 14, NULL, 0, NULL, 1788434422, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (102, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 14, 'r', 2, 5014, 50, 14, 205, 14, NULL, 0, NULL, 1788865222, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (103, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 14, 'r', 2, 5014, 50, 14, 205, 14, NULL, 0, NULL, 1788777622, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (104, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 14, 'r', 2, 5014, 50, 14, 205, 14, NULL, 0, NULL, 1788690022, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (105, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 14, 'r', 2, 5014, 50, 14, 205, 14, NULL, 0, NULL, 1788602422, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (106, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 14, 'r', 2, 5014, 50, 14, 205, 14, NULL, 0, NULL, 1788514822, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (107, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 14, 'r', 2, 5014, 50, 14, 205, 14, NULL, 0, NULL, 1788427222, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (108, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 13, 'r', 2, 5013, 50, 13, 206, 13, NULL, 0, NULL, 1788879622, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (109, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 13, 'r', 2, 5013, 50, 13, 206, 13, NULL, 0, NULL, 1788792022, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (110, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 13, 'r', 2, 5013, 50, 13, 206, 13, NULL, 0, NULL, 1788704422, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (111, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 13, 'r', 2, 5013, 50, 13, 206, 13, NULL, 0, NULL, 1788616822, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (112, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 13, 'r', 2, 5013, 50, 13, 206, 13, NULL, 0, NULL, 1788529222, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (113, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 13, 'r', 2, 5013, 50, 13, 206, 13, NULL, 0, NULL, 1788441622, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (114, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 13, 'r', 2, 5013, 50, 13, 206, 13, NULL, 0, NULL, 1788872422, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (115, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 14, 'r', 2, 5014, 50, 14, 206, 14, NULL, 0, NULL, 1788879622, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (116, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 14, 'r', 2, 5014, 50, 14, 206, 14, NULL, 0, NULL, 1788792022, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (117, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 14, 'r', 2, 5014, 50, 14, 206, 14, NULL, 0, NULL, 1788704422, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (118, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 14, 'r', 2, 5014, 50, 14, 206, 14, NULL, 0, NULL, 1788616822, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (119, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 14, 'r', 2, 5014, 50, 14, 206, 14, NULL, 0, NULL, 1788529222, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (120, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 13, 'r', 2, 5013, 50, 13, 208, 13, NULL, 0, NULL, 1788879622, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (121, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 13, 'r', 2, 5013, 50, 13, 208, 13, NULL, 0, NULL, 1788792022, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (122, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 13, 'r', 2, 5013, 50, 13, 208, 13, NULL, 0, NULL, 1788704422, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (123, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 13, 'r', 2, 5013, 50, 13, 208, 13, NULL, 0, NULL, 1788616822, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (124, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 13, 'r', 2, 5013, 50, 13, 208, 13, NULL, 0, NULL, 1788529222, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (125, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 13, 'r', 2, 5013, 50, 13, 208, 13, NULL, 0, NULL, 1788441622, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (126, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 13, 'r', 2, 5013, 50, 13, 208, 13, NULL, 0, NULL, 1788872422, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (127, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 13, 'r', 2, 5013, 50, 13, 208, 13, NULL, 0, NULL, 1788784822, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (128, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 13, 'r', 2, 5013, 50, 13, 208, 13, NULL, 0, NULL, 1788697222, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (129, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 13, 'r', 2, 5013, 50, 13, 208, 13, NULL, 0, NULL, 1788609622, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (130, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 13, 'r', 2, 5013, 50, 13, 208, 13, NULL, 0, NULL, 1788522022, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (131, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 14, 'r', 2, 5014, 50, 14, 208, 14, NULL, 0, NULL, 1788879622, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (132, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 14, 'r', 2, 5014, 50, 14, 208, 14, NULL, 0, NULL, 1788792022, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (133, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 14, 'r', 2, 5014, 50, 14, 208, 14, NULL, 0, NULL, 1788704422, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (134, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 14, 'r', 2, 5014, 50, 14, 208, 14, NULL, 0, NULL, 1788616822, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (135, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 14, 'r', 2, 5014, 50, 14, 208, 14, NULL, 0, NULL, 1788529222, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (136, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 14, 'r', 2, 5014, 50, 14, 208, 14, NULL, 0, NULL, 1788441622, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (137, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 14, 'r', 2, 5014, 50, 14, 208, 14, NULL, 0, NULL, 1788872422, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (138, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 14, 'r', 2, 5014, 50, 14, 208, 14, NULL, 0, NULL, 1788784822, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (139, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 14, 'r', 2, 5014, 50, 14, 208, 14, NULL, 0, NULL, 1788697222, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (140, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 14, 'r', 2, 5014, 50, 14, 208, 14, NULL, 0, NULL, 1788609622, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (141, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 14, 'r', 2, 5014, 50, 14, 208, 14, NULL, 0, NULL, 1788522022, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (142, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 14, 'r', 2, 5014, 50, 14, 208, 14, NULL, 0, NULL, 1788434422, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (143, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 14, 'r', 2, 5014, 50, 14, 208, 14, NULL, 0, NULL, 1788865222, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (144, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 14, 'r', 2, 5014, 50, 14, 208, 14, NULL, 0, NULL, 1788777622, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (145, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 14, 'r', 2, 5014, 50, 14, 208, 14, NULL, 0, NULL, 1788690022, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (146, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 14, 'r', 2, 5014, 50, 14, 208, 14, NULL, 0, NULL, 1788602422, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (147, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 14, 'r', 2, 5014, 50, 14, 208, 14, NULL, 0, NULL, 1788514822, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (148, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 14, 'r', 2, 5014, 50, 14, 208, 14, NULL, 0, NULL, 1788427222, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (149, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 14, 'r', 2, 5014, 50, 14, 208, 14, NULL, 0, NULL, 1788858022, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (150, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 14, 'r', 2, 5014, 50, 14, 208, 14, NULL, 0, NULL, 1788770422, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (151, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 11, 'r', 2, 5011, 50, 11, 203, 11, NULL, 0, NULL, 1787584822, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (152, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 12, 'r', 2, 5012, 50, 12, 203, 12, NULL, 0, NULL, 1787152822, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (153, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 13, 'r', 2, 5013, 50, 13, 207, 13, NULL, 0, NULL, 1787325622, 'web', '127.0.0.1', NULL);
INSERT INTO lms.logstore_standard_log (id, eventname, component, action, target, objecttable, objectid, crud, edulevel, contextid, contextlevel, contextinstanceid, userid, courseid, relateduserid, anonymous, other, timecreated, origin, ip, realuserid) VALUES (154, '\core\event\course_viewed', 'core', 'viewed', 'course', 'course', 14, 'r', 2, 5014, 50, 14, 207, 14, NULL, 0, NULL, 1787066422, 'web', '127.0.0.1', NULL);


--
-- Data for Name: quiz; Type: TABLE DATA; Schema: lms; Owner: -
--

INSERT INTO lms.quiz (id, course, name, intro, introformat, timeopen, timeclose, timelimit, overduehandling, graceperiod, attempts, grademethod, sumgrades, grade, timecreated, timemodified, completionattemptsexhausted, completionpass, allowofflineattempts) VALUES (11201, 11, 'Database Quiz', 'Database fundamentals quiz.', 1, 1788707634, 1789226034, 1800, 'autoabandon', 0, 2, 1, 100.00000, 100.00000, 1788016434, 1788880434, 0, 0, 0);
INSERT INTO lms.quiz (id, course, name, intro, introformat, timeopen, timeclose, timelimit, overduehandling, graceperiod, attempts, grademethod, sumgrades, grade, timecreated, timemodified, completionattemptsexhausted, completionpass, allowofflineattempts) VALUES (12201, 12, 'Java Quiz', 'Java programming quiz.', 1, 1788275634, 1788794034, 1800, 'autoabandon', 0, 2, 1, 100.00000, 100.00000, 1788016434, 1788880434, 0, 0, 0);
INSERT INTO lms.quiz (id, course, name, intro, introformat, timeopen, timeclose, timelimit, overduehandling, graceperiod, attempts, grademethod, sumgrades, grade, timecreated, timemodified, completionattemptsexhausted, completionpass, allowofflineattempts) VALUES (13201, 13, 'Software Testing Quiz', 'Software testing concepts quiz.', 1, 1788794034, 1789312434, 1800, 'autoabandon', 0, 2, 1, 100.00000, 100.00000, 1788016434, 1788880434, 0, 0, 0);
INSERT INTO lms.quiz (id, course, name, intro, introformat, timeopen, timeclose, timelimit, overduehandling, graceperiod, attempts, grademethod, sumgrades, grade, timecreated, timemodified, completionattemptsexhausted, completionpass, allowofflineattempts) VALUES (14201, 14, 'Android Quiz', 'Android fundamentals quiz.', 1, 1788794034, 1789053234, 1800, 'autoabandon', 0, 2, 1, 100.00000, 100.00000, 1788016434, 1788880434, 0, 0, 0);


--
-- Data for Name: quiz_attempts; Type: TABLE DATA; Schema: lms; Owner: -
--

INSERT INTO lms.quiz_attempts (id, quiz, userid, attempt, uniqueid, layout, currentpage, preview, state, timestart, timefinish, timemodified, timemodifiedoffline, timecheckstate, sumgrades) VALUES (1, 11201, 201, 1, 90001, NULL, 0, 0, 'finished', 1788794034, 1788795234, 1788795234, 0, NULL, 88.00000);
INSERT INTO lms.quiz_attempts (id, quiz, userid, attempt, uniqueid, layout, currentpage, preview, state, timestart, timefinish, timemodified, timemodifiedoffline, timecheckstate, sumgrades) VALUES (2, 11201, 202, 1, 90002, NULL, 0, 0, 'finished', 1788794034, 1788795534, 1788795534, 0, NULL, 72.00000);
INSERT INTO lms.quiz_attempts (id, quiz, userid, attempt, uniqueid, layout, currentpage, preview, state, timestart, timefinish, timemodified, timemodifiedoffline, timecheckstate, sumgrades) VALUES (3, 11201, 204, 1, 90003, NULL, 0, 0, 'inprogress', 1788876834, 0, 1788878634, 0, NULL, NULL);
INSERT INTO lms.quiz_attempts (id, quiz, userid, attempt, uniqueid, layout, currentpage, preview, state, timestart, timefinish, timemodified, timemodifiedoffline, timecheckstate, sumgrades) VALUES (4, 12201, 201, 1, 90004, NULL, 0, 0, 'finished', 1788707634, 1788708834, 1788708834, 0, NULL, 91.00000);
INSERT INTO lms.quiz_attempts (id, quiz, userid, attempt, uniqueid, layout, currentpage, preview, state, timestart, timefinish, timemodified, timemodifiedoffline, timecheckstate, sumgrades) VALUES (5, 12201, 204, 1, 90005, NULL, 0, 0, 'finished', 1788707634, 1788709134, 1788709134, 0, NULL, 68.00000);
INSERT INTO lms.quiz_attempts (id, quiz, userid, attempt, uniqueid, layout, currentpage, preview, state, timestart, timefinish, timemodified, timemodifiedoffline, timecheckstate, sumgrades) VALUES (6, 13201, 205, 1, 90006, NULL, 0, 0, 'finished', 1788794034, 1788795234, 1788795234, 0, NULL, 94.00000);
INSERT INTO lms.quiz_attempts (id, quiz, userid, attempt, uniqueid, layout, currentpage, preview, state, timestart, timefinish, timemodified, timemodifiedoffline, timecheckstate, sumgrades) VALUES (7, 13201, 206, 1, 90007, NULL, 0, 0, 'finished', 1788794034, 1788795234, 1788795234, 0, NULL, 74.00000);
INSERT INTO lms.quiz_attempts (id, quiz, userid, attempt, uniqueid, layout, currentpage, preview, state, timestart, timefinish, timemodified, timemodifiedoffline, timecheckstate, sumgrades) VALUES (8, 13201, 208, 1, 90008, NULL, 0, 0, 'inprogress', 1788878034, 0, 1788879234, 0, NULL, NULL);
INSERT INTO lms.quiz_attempts (id, quiz, userid, attempt, uniqueid, layout, currentpage, preview, state, timestart, timefinish, timemodified, timemodifiedoffline, timecheckstate, sumgrades) VALUES (9, 14201, 205, 1, 90009, NULL, 0, 0, 'finished', 1788794034, 1788795234, 1788795234, 0, NULL, 89.00000);
INSERT INTO lms.quiz_attempts (id, quiz, userid, attempt, uniqueid, layout, currentpage, preview, state, timestart, timefinish, timemodified, timemodifiedoffline, timecheckstate, sumgrades) VALUES (10, 14201, 206, 1, 90010, NULL, 0, 0, 'inprogress', 1788878634, 0, 1788879834, 0, NULL, NULL);
INSERT INTO lms.quiz_attempts (id, quiz, userid, attempt, uniqueid, layout, currentpage, preview, state, timestart, timefinish, timemodified, timemodifiedoffline, timecheckstate, sumgrades) VALUES (11, 14201, 208, 1, 90011, NULL, 0, 0, 'finished', 1788794034, 1788795234, 1788795234, 0, NULL, 93.00000);


--
-- Data for Name: quiz_grades; Type: TABLE DATA; Schema: lms; Owner: -
--

INSERT INTO lms.quiz_grades (id, quiz, userid, grade, timemodified) VALUES (1, 11201, 201, 88.00000, 1788880434);
INSERT INTO lms.quiz_grades (id, quiz, userid, grade, timemodified) VALUES (2, 11201, 202, 72.00000, 1788880434);
INSERT INTO lms.quiz_grades (id, quiz, userid, grade, timemodified) VALUES (3, 12201, 201, 91.00000, 1788880434);
INSERT INTO lms.quiz_grades (id, quiz, userid, grade, timemodified) VALUES (4, 12201, 204, 68.00000, 1788880434);
INSERT INTO lms.quiz_grades (id, quiz, userid, grade, timemodified) VALUES (5, 13201, 205, 94.00000, 1788880434);
INSERT INTO lms.quiz_grades (id, quiz, userid, grade, timemodified) VALUES (6, 13201, 206, 74.00000, 1788880434);
INSERT INTO lms.quiz_grades (id, quiz, userid, grade, timemodified) VALUES (7, 14201, 205, 89.00000, 1788880434);
INSERT INTO lms.quiz_grades (id, quiz, userid, grade, timemodified) VALUES (8, 14201, 208, 93.00000, 1788880434);


--
-- Data for Name: resource; Type: TABLE DATA; Schema: lms; Owner: -
--

INSERT INTO lms.resource (id, course, name, intro, introformat, tobemigrated, legacyfiles, legacyfileslast, display, displayoptions, filterfiles, revision, timemodified) VALUES (14301, 14, '0. Giới thiệu học phần', 'Tài liệu giới thiệu học phần.', 1, 0, 0, NULL, 0, NULL, 0, 1, 1789369225);


--
-- Data for Name: role_assignments; Type: TABLE DATA; Schema: lms; Owner: -
--

INSERT INTO lms.role_assignments (id, roleid, contextid, userid, timemodified, modifierid, component, itemid, sortorder) VALUES (1, 3, 5011, 101, 1788880160, 0, '', 0, 0);
INSERT INTO lms.role_assignments (id, roleid, contextid, userid, timemodified, modifierid, component, itemid, sortorder) VALUES (2, 3, 5012, 101, 1788880160, 0, '', 0, 0);
INSERT INTO lms.role_assignments (id, roleid, contextid, userid, timemodified, modifierid, component, itemid, sortorder) VALUES (3, 3, 5013, 102, 1788880160, 0, '', 0, 0);
INSERT INTO lms.role_assignments (id, roleid, contextid, userid, timemodified, modifierid, component, itemid, sortorder) VALUES (4, 3, 5014, 102, 1788880160, 0, '', 0, 0);
INSERT INTO lms.role_assignments (id, roleid, contextid, userid, timemodified, modifierid, component, itemid, sortorder) VALUES (5, 5, 5011, 201, 1788880160, 0, '', 0, 0);
INSERT INTO lms.role_assignments (id, roleid, contextid, userid, timemodified, modifierid, component, itemid, sortorder) VALUES (6, 5, 5011, 202, 1788880160, 0, '', 0, 0);
INSERT INTO lms.role_assignments (id, roleid, contextid, userid, timemodified, modifierid, component, itemid, sortorder) VALUES (7, 5, 5011, 203, 1788880160, 0, '', 0, 0);
INSERT INTO lms.role_assignments (id, roleid, contextid, userid, timemodified, modifierid, component, itemid, sortorder) VALUES (8, 5, 5011, 204, 1788880160, 0, '', 0, 0);
INSERT INTO lms.role_assignments (id, roleid, contextid, userid, timemodified, modifierid, component, itemid, sortorder) VALUES (9, 5, 5012, 201, 1788880160, 0, '', 0, 0);
INSERT INTO lms.role_assignments (id, roleid, contextid, userid, timemodified, modifierid, component, itemid, sortorder) VALUES (10, 5, 5012, 202, 1788880160, 0, '', 0, 0);
INSERT INTO lms.role_assignments (id, roleid, contextid, userid, timemodified, modifierid, component, itemid, sortorder) VALUES (11, 5, 5012, 203, 1788880160, 0, '', 0, 0);
INSERT INTO lms.role_assignments (id, roleid, contextid, userid, timemodified, modifierid, component, itemid, sortorder) VALUES (12, 5, 5012, 204, 1788880160, 0, '', 0, 0);
INSERT INTO lms.role_assignments (id, roleid, contextid, userid, timemodified, modifierid, component, itemid, sortorder) VALUES (13, 5, 5013, 205, 1788880160, 0, '', 0, 0);
INSERT INTO lms.role_assignments (id, roleid, contextid, userid, timemodified, modifierid, component, itemid, sortorder) VALUES (14, 5, 5013, 206, 1788880160, 0, '', 0, 0);
INSERT INTO lms.role_assignments (id, roleid, contextid, userid, timemodified, modifierid, component, itemid, sortorder) VALUES (15, 5, 5013, 207, 1788880160, 0, '', 0, 0);
INSERT INTO lms.role_assignments (id, roleid, contextid, userid, timemodified, modifierid, component, itemid, sortorder) VALUES (16, 5, 5013, 208, 1788880160, 0, '', 0, 0);
INSERT INTO lms.role_assignments (id, roleid, contextid, userid, timemodified, modifierid, component, itemid, sortorder) VALUES (17, 5, 5014, 205, 1788880160, 0, '', 0, 0);
INSERT INTO lms.role_assignments (id, roleid, contextid, userid, timemodified, modifierid, component, itemid, sortorder) VALUES (18, 5, 5014, 206, 1788880160, 0, '', 0, 0);
INSERT INTO lms.role_assignments (id, roleid, contextid, userid, timemodified, modifierid, component, itemid, sortorder) VALUES (19, 5, 5014, 207, 1788880160, 0, '', 0, 0);
INSERT INTO lms.role_assignments (id, roleid, contextid, userid, timemodified, modifierid, component, itemid, sortorder) VALUES (20, 5, 5014, 208, 1788880160, 0, '', 0, 0);


--
-- Data for Name: user_enrolments; Type: TABLE DATA; Schema: lms; Owner: -
--

INSERT INTO lms.user_enrolments (id, status, enrolid, userid, timestart, timeend, modifierid, timecreated, timemodified) VALUES (1, 0, 1102, 101, 1783696160, 2147483647, 101, 1788880160, 1788880160);
INSERT INTO lms.user_enrolments (id, status, enrolid, userid, timestart, timeend, modifierid, timecreated, timemodified) VALUES (2, 0, 1202, 101, 1783696160, 2147483647, 101, 1788880160, 1788880160);
INSERT INTO lms.user_enrolments (id, status, enrolid, userid, timestart, timeend, modifierid, timecreated, timemodified) VALUES (3, 0, 1302, 102, 1783696160, 2147483647, 102, 1788880160, 1788880160);
INSERT INTO lms.user_enrolments (id, status, enrolid, userid, timestart, timeend, modifierid, timecreated, timemodified) VALUES (4, 0, 1402, 102, 1783696160, 2147483647, 102, 1788880160, 1788880160);
INSERT INTO lms.user_enrolments (id, status, enrolid, userid, timestart, timeend, modifierid, timecreated, timemodified) VALUES (5, 0, 1101, 201, 1783696160, 2147483647, 101, 1788880160, 1788880160);
INSERT INTO lms.user_enrolments (id, status, enrolid, userid, timestart, timeend, modifierid, timecreated, timemodified) VALUES (6, 0, 1101, 202, 1783696160, 2147483647, 101, 1788880160, 1788880160);
INSERT INTO lms.user_enrolments (id, status, enrolid, userid, timestart, timeend, modifierid, timecreated, timemodified) VALUES (7, 0, 1101, 203, 1783696160, 2147483647, 101, 1788880160, 1788880160);
INSERT INTO lms.user_enrolments (id, status, enrolid, userid, timestart, timeend, modifierid, timecreated, timemodified) VALUES (8, 0, 1101, 204, 1783696160, 2147483647, 101, 1788880160, 1788880160);
INSERT INTO lms.user_enrolments (id, status, enrolid, userid, timestart, timeend, modifierid, timecreated, timemodified) VALUES (9, 0, 1201, 201, 1783696160, 2147483647, 101, 1788880160, 1788880160);
INSERT INTO lms.user_enrolments (id, status, enrolid, userid, timestart, timeend, modifierid, timecreated, timemodified) VALUES (10, 0, 1201, 202, 1783696160, 2147483647, 101, 1788880160, 1788880160);
INSERT INTO lms.user_enrolments (id, status, enrolid, userid, timestart, timeend, modifierid, timecreated, timemodified) VALUES (11, 0, 1201, 203, 1783696160, 2147483647, 101, 1788880160, 1788880160);
INSERT INTO lms.user_enrolments (id, status, enrolid, userid, timestart, timeend, modifierid, timecreated, timemodified) VALUES (12, 0, 1201, 204, 1783696160, 2147483647, 101, 1788880160, 1788880160);
INSERT INTO lms.user_enrolments (id, status, enrolid, userid, timestart, timeend, modifierid, timecreated, timemodified) VALUES (13, 0, 1301, 205, 1783696160, 2147483647, 102, 1788880160, 1788880160);
INSERT INTO lms.user_enrolments (id, status, enrolid, userid, timestart, timeend, modifierid, timecreated, timemodified) VALUES (14, 0, 1301, 206, 1783696160, 2147483647, 102, 1788880160, 1788880160);
INSERT INTO lms.user_enrolments (id, status, enrolid, userid, timestart, timeend, modifierid, timecreated, timemodified) VALUES (15, 0, 1301, 207, 1783696160, 2147483647, 102, 1788880160, 1788880160);
INSERT INTO lms.user_enrolments (id, status, enrolid, userid, timestart, timeend, modifierid, timecreated, timemodified) VALUES (16, 0, 1301, 208, 1783696160, 2147483647, 102, 1788880160, 1788880160);
INSERT INTO lms.user_enrolments (id, status, enrolid, userid, timestart, timeend, modifierid, timecreated, timemodified) VALUES (17, 0, 1401, 205, 1783696160, 2147483647, 102, 1788880160, 1788880160);
INSERT INTO lms.user_enrolments (id, status, enrolid, userid, timestart, timeend, modifierid, timecreated, timemodified) VALUES (18, 0, 1401, 206, 1783696160, 2147483647, 102, 1788880160, 1788880160);
INSERT INTO lms.user_enrolments (id, status, enrolid, userid, timestart, timeend, modifierid, timecreated, timemodified) VALUES (19, 0, 1401, 207, 1783696160, 2147483647, 102, 1788880160, 1788880160);
INSERT INTO lms.user_enrolments (id, status, enrolid, userid, timestart, timeend, modifierid, timecreated, timemodified) VALUES (20, 0, 1401, 208, 1783696160, 2147483647, 102, 1788880160, 1788880160);


--
-- Data for Name: user_lastaccess; Type: TABLE DATA; Schema: lms; Owner: -
--

INSERT INTO lms.user_lastaccess (id, userid, courseid, timeaccess) VALUES (1, 201, 11, 1788863542);
INSERT INTO lms.user_lastaccess (id, userid, courseid, timeaccess) VALUES (2, 201, 12, 1788837622);
INSERT INTO lms.user_lastaccess (id, userid, courseid, timeaccess) VALUES (3, 202, 11, 1788708022);
INSERT INTO lms.user_lastaccess (id, userid, courseid, timeaccess) VALUES (4, 202, 12, 1788621622);
INSERT INTO lms.user_lastaccess (id, userid, courseid, timeaccess) VALUES (5, 203, 11, 1787584822);
INSERT INTO lms.user_lastaccess (id, userid, courseid, timeaccess) VALUES (6, 203, 12, 1787152822);
INSERT INTO lms.user_lastaccess (id, userid, courseid, timeaccess) VALUES (7, 204, 11, 1788448822);
INSERT INTO lms.user_lastaccess (id, userid, courseid, timeaccess) VALUES (8, 204, 12, 1788794422);
INSERT INTO lms.user_lastaccess (id, userid, courseid, timeaccess) VALUES (9, 205, 13, 1788854902);
INSERT INTO lms.user_lastaccess (id, userid, courseid, timeaccess) VALUES (10, 205, 14, 1788794422);
INSERT INTO lms.user_lastaccess (id, userid, courseid, timeaccess) VALUES (11, 206, 13, 1788535222);
INSERT INTO lms.user_lastaccess (id, userid, courseid, timeaccess) VALUES (12, 206, 14, 1788362422);
INSERT INTO lms.user_lastaccess (id, userid, courseid, timeaccess) VALUES (13, 207, 13, 1787325622);
INSERT INTO lms.user_lastaccess (id, userid, courseid, timeaccess) VALUES (14, 207, 14, 1787066422);
INSERT INTO lms.user_lastaccess (id, userid, courseid, timeaccess) VALUES (15, 208, 13, 1788794422);
INSERT INTO lms.user_lastaccess (id, userid, courseid, timeaccess) VALUES (16, 208, 14, 1788863542);


--
-- Name: learning_goals_id_seq; Type: SEQUENCE SET; Schema: app; Owner: -
--

SELECT pg_catalog.setval('app.learning_goals_id_seq', 6, true);


--
-- Name: learning_reminders_id_seq; Type: SEQUENCE SET; Schema: app; Owner: -
--

SELECT pg_catalog.setval('app.learning_reminders_id_seq', 6, true);


--
-- Name: notification_preferences_id_seq; Type: SEQUENCE SET; Schema: app; Owner: -
--

SELECT pg_catalog.setval('app.notification_preferences_id_seq', 10, true);


--
-- Name: notifications_id_seq; Type: SEQUENCE SET; Schema: app; Owner: -
--

SELECT pg_catalog.setval('app.notifications_id_seq', 11, true);


--
-- Name: assign_grades_id_seq; Type: SEQUENCE SET; Schema: lms; Owner: -
--

SELECT pg_catalog.setval('lms.assign_grades_id_seq', 10, true);


--
-- Name: assign_id_seq; Type: SEQUENCE SET; Schema: lms; Owner: -
--

SELECT pg_catalog.setval('lms.assign_id_seq', 14102, true);


--
-- Name: assign_submission_id_seq; Type: SEQUENCE SET; Schema: lms; Owner: -
--

SELECT pg_catalog.setval('lms.assign_submission_id_seq', 14, true);


--
-- Name: attendance_id_seq; Type: SEQUENCE SET; Schema: lms; Owner: -
--

SELECT pg_catalog.setval('lms.attendance_id_seq', 1, false);


--
-- Name: attendance_log_id_seq; Type: SEQUENCE SET; Schema: lms; Owner: -
--

SELECT pg_catalog.setval('lms.attendance_log_id_seq', 20, true);


--
-- Name: attendance_sessions_id_seq; Type: SEQUENCE SET; Schema: lms; Owner: -
--

SELECT pg_catalog.setval('lms.attendance_sessions_id_seq', 1, false);


--
-- Name: attendance_statuses_id_seq; Type: SEQUENCE SET; Schema: lms; Owner: -
--

SELECT pg_catalog.setval('lms.attendance_statuses_id_seq', 1, false);


--
-- Name: context_id_seq; Type: SEQUENCE SET; Schema: lms; Owner: -
--

SELECT pg_catalog.setval('lms.context_id_seq', 5014, true);


--
-- Name: course_categories_id_seq; Type: SEQUENCE SET; Schema: lms; Owner: -
--

SELECT pg_catalog.setval('lms.course_categories_id_seq', 1004, true);


--
-- Name: course_completions_id_seq; Type: SEQUENCE SET; Schema: lms; Owner: -
--

SELECT pg_catalog.setval('lms.course_completions_id_seq', 16, true);


--
-- Name: course_id_seq; Type: SEQUENCE SET; Schema: lms; Owner: -
--

SELECT pg_catalog.setval('lms.course_id_seq', 14, true);


--
-- Name: course_modules_completion_id_seq; Type: SEQUENCE SET; Schema: lms; Owner: -
--

SELECT pg_catalog.setval('lms.course_modules_completion_id_seq', 48, true);


--
-- Name: course_modules_id_seq; Type: SEQUENCE SET; Schema: lms; Owner: -
--

SELECT pg_catalog.setval('lms.course_modules_id_seq', 24303, true);


--
-- Name: course_sections_id_seq; Type: SEQUENCE SET; Schema: lms; Owner: -
--

SELECT pg_catalog.setval('lms.course_sections_id_seq', 143, true);


--
-- Name: enrol_id_seq; Type: SEQUENCE SET; Schema: lms; Owner: -
--

SELECT pg_catalog.setval('lms.enrol_id_seq', 1402, true);


--
-- Name: folder_id_seq; Type: SEQUENCE SET; Schema: lms; Owner: -
--

SELECT pg_catalog.setval('lms.folder_id_seq', 14302, true);


--
-- Name: forum_id_seq; Type: SEQUENCE SET; Schema: lms; Owner: -
--

SELECT pg_catalog.setval('lms.forum_id_seq', 14303, true);


--
-- Name: grade_categories_id_seq; Type: SEQUENCE SET; Schema: lms; Owner: -
--

SELECT pg_catalog.setval('lms.grade_categories_id_seq', 14003, true);


--
-- Name: grade_grades_id_seq; Type: SEQUENCE SET; Schema: lms; Owner: -
--

SELECT pg_catalog.setval('lms.grade_grades_id_seq', 18, true);


--
-- Name: grade_items_id_seq; Type: SEQUENCE SET; Schema: lms; Owner: -
--

SELECT pg_catalog.setval('lms.grade_items_id_seq', 614201, true);


--
-- Name: groupings_groups_id_seq; Type: SEQUENCE SET; Schema: lms; Owner: -
--

SELECT pg_catalog.setval('lms.groupings_groups_id_seq', 3, true);


--
-- Name: groupings_id_seq; Type: SEQUENCE SET; Schema: lms; Owner: -
--

SELECT pg_catalog.setval('lms.groupings_id_seq', 14102, true);


--
-- Name: groups_id_seq; Type: SEQUENCE SET; Schema: lms; Owner: -
--

SELECT pg_catalog.setval('lms.groups_id_seq', 14014, true);


--
-- Name: groups_members_id_seq; Type: SEQUENCE SET; Schema: lms; Owner: -
--

SELECT pg_catalog.setval('lms.groups_members_id_seq', 6, true);


--
-- Name: logstore_standard_log_id_seq; Type: SEQUENCE SET; Schema: lms; Owner: -
--

SELECT pg_catalog.setval('lms.logstore_standard_log_id_seq', 154, true);


--
-- Name: modules_id_seq; Type: SEQUENCE SET; Schema: lms; Owner: -
--

SELECT pg_catalog.setval('lms.modules_id_seq', 5, true);


--
-- Name: quiz_attempts_id_seq; Type: SEQUENCE SET; Schema: lms; Owner: -
--

SELECT pg_catalog.setval('lms.quiz_attempts_id_seq', 11, true);


--
-- Name: quiz_grades_id_seq; Type: SEQUENCE SET; Schema: lms; Owner: -
--

SELECT pg_catalog.setval('lms.quiz_grades_id_seq', 8, true);


--
-- Name: quiz_id_seq; Type: SEQUENCE SET; Schema: lms; Owner: -
--

SELECT pg_catalog.setval('lms.quiz_id_seq', 14201, true);


--
-- Name: resource_id_seq; Type: SEQUENCE SET; Schema: lms; Owner: -
--

SELECT pg_catalog.setval('lms.resource_id_seq', 14301, true);


--
-- Name: role_assignments_id_seq; Type: SEQUENCE SET; Schema: lms; Owner: -
--

SELECT pg_catalog.setval('lms.role_assignments_id_seq', 20, true);


--
-- Name: role_id_seq; Type: SEQUENCE SET; Schema: lms; Owner: -
--

SELECT pg_catalog.setval('lms.role_id_seq', 5, true);


--
-- Name: user_enrolments_id_seq; Type: SEQUENCE SET; Schema: lms; Owner: -
--

SELECT pg_catalog.setval('lms.user_enrolments_id_seq', 20, true);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: lms; Owner: -
--

SELECT pg_catalog.setval('lms.user_id_seq', 208, true);


--
-- Name: user_lastaccess_id_seq; Type: SEQUENCE SET; Schema: lms; Owner: -
--

SELECT pg_catalog.setval('lms.user_lastaccess_id_seq', 16, true);


--
-- PostgreSQL database dump complete
--

\unrestrict swZ4xpAnzS6df6K2lyeZezkPpSdQir0UTS7R6xCzgacAHwCAElB93MfKXIW8Go8

