# DEMO DATA CATALOG (Dữ liệu trình diễn)

Tài liệu này tổng hợp toàn bộ dữ liệu mẫu (mock data) hiện có trong hệ thống và file `seed_demo_v4.sql`, sẵn sàng cho đợt báo cáo tiến độ lần 2.

## 1. Thông tin tài khoản Demo chính
- **Sinh viên**: ID `205`, `501` (Tùy cấu hình app, API dev lấy theo URL params).
- **Giáo viên**: ID `102`.

## 2. Dữ liệu Khóa học (Courses)
- Hệ thống duy trì các khóa học cốt lõi (ID: `14`, `15`, `42`) và 3 khóa học mới (ID `5000001`, `5000002`, `5000003`).
- Tình trạng phân bổ đa dạng: có khóa đã kết thúc, có khóa đang diễn ra, có khóa chuẩn bị bắt đầu.

## 3. Các kịch bản trình diễn sẵn sàng

### 3.1. Phía Sinh viên (Student)
- **Danh sách khóa học**: Hiển thị đầy đủ nhiều khóa học với tiến độ (Progress) từ 0% đến 100%.
- **Nhiệm vụ (Tasks)**:
  - **Quá hạn (Overdue)**: Dữ liệu quá hạn có trong `seed_demo_v4.sql` (due_date trong quá khứ, chưa có trong `assign_grades`).
  - **Sắp đến hạn (Due soon)**: Có nhiệm vụ có deadline trong 7 ngày tới.
  - **Hoàn thành**: Có các bài tập đã nộp (có bản ghi trong `assign_grades` với grade cụ thể).
- **Điểm số**: Sinh viên 205 có điểm từ 8.5 đến 9.0; sinh viên ảo có các điểm rải rác 4.5, 6.0, 9.5 để test biểu đồ phổ điểm. Ngoài ra, có kịch bản xử lý dữ liệu điểm `NULL` hoặc 0 một cách an toàn.
- **Chuyên cần**: Đã có `lms.attendance_sessions` và `lms.attendance_log`, đáp ứng kịch bản điểm danh 0% và có mặt 100%.
- **Chức năng mở rộng**: 
  - **Learning Goals (`app.learning_goals`)**: Có các mục tiêu IN_PROGRESS và COMPLETED.
  - **Reflections (`app.learning_reflections`)**: Sẵn sàng hiển thị dữ liệu thật khi POST và GET (đã test 200 OK).

### 3.2. Phía Giáo viên (Teacher)
- **Tổng quan khóa học**: Giáo viên `102` quản lý 3 khóa học demo với sinh viên trải đều.
- **Student Monitoring**: 
  - Đã có dữ liệu 5 sinh viên ảo (`id: 4000001` đến `4000005`) với mức độ chuyên cần, tiến độ và nộp bài (assign_grades) ngẫu nhiên.
  - Các sinh viên chưa nộp bài vẫn được hiển thị (dựa trên danh sách `user_enrolments` đối chiếu `assign_grades`).
- **Teacher Analytics**: Biểu đồ phổ điểm, tỷ lệ hoàn thành được vẽ từ dữ liệu thực tế (5 sinh viên ảo) đảm bảo phong phú, trực quan.

## 4. Tình trạng và nguồn gốc dữ liệu
- Tất cả dữ liệu `lms.*` là mock (giả lập theo schema Moodle), không chứa thông tin cá nhân.
- Các API endpoints sử dụng `/api/v1/dev/*` để bypass xác thực JWT, phục vụ riêng cho mục đích demo nội bộ.
- Dữ liệu `app.*` hoạt động ổn định và lưu trữ trực tiếp trên database.

*Ghi chú: File `seed_demo_v4.sql` sử dụng `ON CONFLICT DO NOTHING` an toàn. Ràng buộc UNIQUE(user_id, course_id) trên hệ thống gốc đảm bảo không sinh rác dữ liệu.*
