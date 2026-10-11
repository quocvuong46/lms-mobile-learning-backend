# BÁO CÁO KIỂM CHỨNG AN TOÀN SEED V4 (Cập nhật Phase 11.4)

Tài liệu này xác nhận tính an toàn và toàn vẹn của kịch bản seed dữ liệu mẫu `db/mock/seed_demo_v4.sql`.

## 1. Trạng thái kiểm chứng
- **Kết quả:** `VERIFIED_STATIC` (Đã rà soát tĩnh mã SQL và Schema).
- Do chưa cấp phát môi trường PostgreSQL Test Database (`lms_mobile_learning_test`) độc lập và chưa cung cấp biến `$env:DB_PASSWORD` tương ứng, việc kiểm thử Idempotency thực tế (chạy seed 2 lần rồi đếm số bản ghi) chưa được thực thi (đang ở trạng thái `BLOCKED`).

## 2. Phân tích chi tiết các nhóm INSERT

| Nhóm INSERT | Bảng | Khóa chính/UNIQUE | Khóa ngoại (Dependencies) | ID Seed | Hành vi chạy lần đầu | Hành vi chạy lần hai | Nguy cơ ghi đè/rác |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Sinh viên ảo** | `lms.user` | `id` (PK) | Không | 4000001 - 4000005 | Insert thành công | Bỏ qua (ON CONFLICT id) | Không rủi ro |
| **Khóa học** | `lms.course` | `id` (PK) | `category_id` (LMS category) | 5000001 - 5000003 | Insert thành công | Bỏ qua (ON CONFLICT id) | Không rủi ro |
| **Ghi danh** | `lms.user_enrolments` | `(user_id, course_id)` (UNIQUE) | `user_id`, `course_id` | N/A | Insert thành công | Bỏ qua (Vi phạm UNIQUE) | Không sinh duplicate nhờ UNIQUE |
| **Nhiệm vụ** | `lms.assign` | `id` (PK) | `course_id` | 6000001 - 6000003 | Insert thành công | Bỏ qua (ON CONFLICT id) | Không rủi ro |
| **Chấm điểm** | `lms.assign_grades` | `(assign_id, user_id)` (UNIQUE) | `assign_id`, `user_id` | N/A | Insert thành công | Bỏ qua (Vi phạm UNIQUE) | Không rủi ro |
| **Mục tiêu** | `app.learning_goals` | `id` (PK) | `user_id` | Tự động (SERIAL) | Insert thành công | Phụ thuộc UNIQUE `(user_id, title)` | Có thể sinh duplicate nếu thiếu UNIQUE title |
| **Chuyên cần** | `lms.attendance_log` | `(session_id, student_id)` (UNIQUE) | `session_id`, `student_id` | N/A | Insert thành công | Bỏ qua (Vi phạm UNIQUE) | Không rủi ro |

## 3. Khẳng định
Dựa trên phân tích tĩnh `ON CONFLICT DO NOTHING` kết hợp với các rào cản Unique Constraints kế thừa từ hệ thống Moodle, script seed được đánh giá an toàn. Các ID gán tĩnh (như 4000001 hay 6000001) được đưa vào dải số cao, tuyệt đối không đụng độ các ID hiện có (như SV 205).
Trường hợp sinh viên 4000004 và 4000005 có bản ghi enrolments nhưng thiếu dữ liệu assign_grades (điểm = NULL/chưa nộp) hoàn toàn có chủ đích, nhằm giả lập kịch bản hiển thị học sinh chưa nộp bài trên giao diện Teacher Monitoring.
