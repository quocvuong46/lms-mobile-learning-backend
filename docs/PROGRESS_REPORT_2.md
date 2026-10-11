# BÁO CÁO TIẾN ĐỘ LẦN 2

## 1. Giới thiệu đề tài và mục tiêu
**Tên đề tài:** Xây dựng ứng dụng di động hỗ trợ học tập và giảng dạy trên nền tảng LMS.
**Mục tiêu:** Xây dựng một ứng dụng đa nền tảng (Flutter) tích hợp sâu với hệ thống Moodle LMS hiện tại của trường (PostgreSQL), cung cấp giao diện trực quan cho sinh viên và giáo viên, đồng thời bổ sung các tính năng hỗ trợ học tập cá nhân hóa (Nhật ký học tập, Phân tích tiến độ).

## 2. Phạm vi chức năng
Ứng dụng hướng tới hai đối tượng chính:
- **Sinh viên:** Quản lý khóa học, theo dõi bài tập (Task Center), xem thống kê điểm danh, và ghi chú nhật ký học tập (Learning Reflections).
- **Giáo viên:** Theo dõi tổng quan các lớp phụ trách, xem danh sách sinh viên rủi ro (chưa nộp bài/kết quả thấp), và xem nhanh tiến độ (Class Insights).

## 3. Kiến trúc hệ thống
- **Frontend:** Flutter (Mobile App).
- **Backend:** Spring Boot (Cung cấp REST API).
- **Database:** PostgreSQL (Kết hợp schema `lms.*` mô phỏng Moodle core và schema `app.*` cho các tính năng mở rộng của app).

## 4. Các chức năng sinh viên
- **Student Dashboard:** Hiển thị số lượng khóa học, các công việc quá hạn/sắp đến hạn.
- **Task Center:** Lấy danh sách nhiệm vụ từ các module Assignment/Quiz, phân nhóm rõ ràng (Overdue, Due Soon).
- **Learning Analytics:** Thống kê tỷ lệ hoàn thành khóa học, số buổi điểm danh, và phân tích rủi ro học tập.
- **Learning Reflections:** Tính năng mở rộng cho phép sinh viên ghi lại cảm nhận và mức độ hiểu bài sau mỗi khóa học.

## 5. Các chức năng giáo viên
- **Teacher Dashboard:** Tổng quan các lớp học đang phụ trách.
- **Class Insights:** Liệt kê các sinh viên trong lớp cùng tiến độ nộp bài, chú trọng làm nổi bật nhóm sinh viên chưa nộp bài (Needs Attention).

## 6. Thiết kế dữ liệu và Data Mapping Matrix
Hệ thống sử dụng cơ chế Data Mapping nhằm tách biệt dữ liệu Moodle gốc và ứng dụng:
- Bảng Moodle (`lms.user_enrolments`, `lms.assign`, `lms.assign_grades`).
- Chế độ View tổng hợp (`derived.student_dashboard`, `derived.unified_tasks`) để tối ưu hóa API.
- Bảng mở rộng (`app.learning_reflections`, `app.learning_goals`) để phục vụ tính năng riêng biệt của app.

## 7. Luồng dữ liệu PostgreSQL → REST API → Flutter
- **Ví dụ luồng Reflections:** Dữ liệu lưu tại bảng `app.learning_reflections` $\rightarrow$ `ReflectionRepository` $\rightarrow$ `ReflectionController` (Spring Boot API `/api/v1/dev/students/{id}/reflections`) $\rightarrow$ `ApiService` (Flutter) $\rightarrow$ Cập nhật UI.

## 8. Kết quả kiểm thử và bằng chứng
- **Kiểm thử giao diện & logic (Flutter):** Chạy thành công 167/167 UI Test. Đã xử lý triệt để lỗi tràn màn hình (overflow).
- **Kiểm thử API Mock (Spring Boot):** 24/24 Test PASS (Xác minh Logic, Phân quyền mức Controller, và Validation Dữ liệu).
- **Kiểm thử tích hợp (Integration Test):** [BLOCKED] - Đã cấu hình độc lập `lms_mobile_learning_test` nhưng test chưa được thực thi tự động do thiếu biến môi trường cấu hình mật khẩu trên hệ thống CI.

## 9. Kết quả Responsive UI
Giao diện ứng dụng Flutter đã được đảm bảo hoạt động mượt mà trên nhiều kích thước màn hình.
- Đã khắc phục triệt để lỗi "Right overflowed by pixels" ở màn hình hẹp (width 320px).
- Hỗ trợ tốt `TextScaleFactor` x1.8 cho người dùng có nhu cầu phóng to chữ.

## 10. Giới hạn hiện tại
- **Authentication:** Hệ thống hiện tại đang sử dụng định tuyến giả lập (`/api/v1/dev/**`) truyền ID trực tiếp để thuận tiện cho quá trình thiết kế UI. Việc cấp JWT và kiểm soát quyền bảo mật toàn cục chưa được kích hoạt.
- **Tích hợp LMS thật:** Việc trích xuất dữ liệu đang dùng bản mock dựa trên cấu trúc Moodle (Seed V4). Tính năng này được đánh dấu `PROPOSED_DLU` do chưa có kết nối đến API/DB thực tế của nhà trường.

## 11. Kế hoạch tiếp theo
- **Phase Security:** Thay thế endpoint `dev/` bằng xác thực JWT thực sự, đảm bảo tính đóng gói an toàn.
- **Phase Integration:** Chờ cấp quyền truy cập để ánh xạ dữ liệu trực tiếp từ CSDL LMS DLU.

## 12. Kết luận
Dự án đã hình thành rõ nét về mặt giao diện, trải nghiệm người dùng và thiết kế CSDL mở rộng. Các cơ sở hạ tầng đã sẵn sàng cho giai đoạn đấu nối và hoàn thiện.
