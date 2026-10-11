-- MỞ RỘNG DỮ LIỆU DEMO (SEED v4)
-- Tuân thủ nghiêm ngặt nguyên tắc KHÔNG xóa, sửa (UPDATE/DELETE) dữ liệu cũ, chỉ dùng INSERT.
-- Tài khoản demo đang dùng: Sinh viên 205, Giáo viên 102 và 3000015.

-- 1. THÊM SINH VIÊN ẢO (Mô phỏng lớp học đông)
INSERT INTO lms.user (id, username, password, email, firstname, lastname) VALUES
(4000001, 'sv4000001', 'demo', 'sv4000001@dlu.edu.vn', 'Nguyễn Văn', 'A1'),
(4000002, 'sv4000002', 'demo', 'sv4000002@dlu.edu.vn', 'Trần Thị', 'B1'),
(4000003, 'sv4000003', 'demo', 'sv4000003@dlu.edu.vn', 'Lê Văn', 'C1'),
(4000004, 'sv4000004', 'demo', 'sv4000004@dlu.edu.vn', 'Phạm Thị', 'D1'),
(4000005, 'sv4000005', 'demo', 'sv4000005@dlu.edu.vn', 'Hoàng Văn', 'E1')
ON CONFLICT (id) DO NOTHING;

-- 2. THÊM KHÓA HỌC MỚI
INSERT INTO lms.course (id, fullname, shortname, category, startdate, enddate) VALUES
(5000001, 'CTK45 - Lập trình Di động Nâng cao (Demo)', 'CTK45-MOBILE-ADV', 2, extract(epoch from now()) - 864000, extract(epoch from now()) + 864000),
(5000002, 'CTK45 - Phân tích Dữ liệu Lớn (Demo)', 'CTK45-BIGDATA', 2, extract(epoch from now()) - 2000000, extract(epoch from now()) - 100000),
(5000003, 'CTK45 - Trí tuệ Nhân tạo (Demo)', 'CTK45-AI', 2, extract(epoch from now()), extract(epoch from now()) + 3000000)
ON CONFLICT (id) DO NOTHING;

-- 3. ĐĂNG KÝ VÀO KHÓA HỌC (Enrolments)
-- Đăng ký sinh viên demo (205) và giáo viên (102)
INSERT INTO lms.user_enrolments (user_id, course_id, role, enrol_time) VALUES
(205, 5000001, 'student', extract(epoch from now())),
(205, 5000002, 'student', extract(epoch from now())),
(205, 5000003, 'student', extract(epoch from now())),
(102, 5000001, 'editingteacher', extract(epoch from now())),
(102, 5000002, 'editingteacher', extract(epoch from now())),
(102, 5000003, 'editingteacher', extract(epoch from now()))
ON CONFLICT DO NOTHING;

-- Đăng ký sinh viên ảo vào khóa học 1 để làm phong phú biểu đồ teacher
INSERT INTO lms.user_enrolments (user_id, course_id, role, enrol_time) VALUES
(4000001, 5000001, 'student', extract(epoch from now())),
(4000002, 5000001, 'student', extract(epoch from now())),
(4000003, 5000001, 'student', extract(epoch from now())),
(4000004, 5000001, 'student', extract(epoch from now())),
(4000005, 5000001, 'student', extract(epoch from now()))
ON CONFLICT DO NOTHING;

-- 4. NHIỆM VỤ (Assignments)
INSERT INTO lms.assign (id, course_id, name, intro, due_date, allow_submissions_from_date) VALUES
(6000001, 5000001, 'Bài tập 1: Xây dựng UI', 'Thiết kế giao diện Flutter', extract(epoch from now()) + 86400, extract(epoch from now())),
(6000002, 5000001, 'Bài tập 2: Tích hợp API', 'Kết nối Backend', extract(epoch from now()) - 86400, extract(epoch from now()) - 200000),
(6000003, 5000002, 'Báo cáo giữa kỳ', 'Viết báo cáo Big Data', extract(epoch from now()) - 50000, extract(epoch from now()) - 300000)
ON CONFLICT (id) DO NOTHING;

-- 5. CHẤM ĐIỂM (Grades) & CHUYÊN CẦN (Attendance)
-- Sinh viên 205 (Đã nộp và có điểm)
INSERT INTO lms.assign_grades (assign_id, user_id, grade, time_created, time_modified) VALUES
(6000002, 205, 8.5, extract(epoch from now()) - 100000, extract(epoch from now()) - 50000),
(6000003, 205, 9.0, extract(epoch from now()) - 40000, extract(epoch from now()) - 20000)
ON CONFLICT DO NOTHING;

-- Điểm cho sinh viên ảo
INSERT INTO lms.assign_grades (assign_id, user_id, grade, time_created, time_modified) VALUES
(6000002, 4000001, 4.5, extract(epoch from now()), extract(epoch from now())),
(6000002, 4000002, 9.5, extract(epoch from now()), extract(epoch from now())),
(6000002, 4000003, 6.0, extract(epoch from now()), extract(epoch from now()))
ON CONFLICT DO NOTHING;

-- Mục tiêu (Goals) cho sinh viên 205
INSERT INTO app.learning_goals (user_id, title, target_date, status) VALUES
(205, 'Hoàn thành báo cáo môn Di Động', CURRENT_DATE + INTERVAL '5 days', 'IN_PROGRESS'),
(205, 'Đạt điểm A môn Big Data', CURRENT_DATE - INTERVAL '1 days', 'COMPLETED')
ON CONFLICT DO NOTHING;

-- Chuyên cần (Attendance) cho sinh viên 205
INSERT INTO lms.attendance (id, course_id, name) VALUES 
(7000001, 5000001, 'Điểm danh LT Di động')
ON CONFLICT (id) DO NOTHING;

INSERT INTO lms.attendance_sessions (id, attendance_id, session_date) VALUES 
(8000001, 7000001, extract(epoch from now()) - 86400)
ON CONFLICT (id) DO NOTHING;

INSERT INTO lms.attendance_log (session_id, student_id, status_id) VALUES 
(8000001, 205, 1) -- 1 = Present (Giả sử status 1 là có mặt)
ON CONFLICT DO NOTHING;
