# DÀN Ý SLIDE BÁO CÁO TIẾN ĐỘ LẦN 2

**Ghi chú:** Đây là dàn ý thô (Outline). Sử dụng các Text/Bulleted list để đưa vào PowerPoint. Nhớ chèn ảnh chụp từ màn hình thật của ứng dụng tại vị trí gợi ý.

---

### Slide 1: Trang bìa
- **Tiêu đề:** Xây dựng ứng dụng di động hỗ trợ học tập và giảng dạy trên nền tảng LMS (Báo cáo tiến độ lần 2).
- **Sinh viên thực hiện:** [Tên sinh viên]
- **Giảng viên hướng dẫn:** [Tên giảng viên]

### Slide 2: Bài toán và mục tiêu
- **Bài toán:** Các hệ thống LMS Moodle truyền thống thiếu giao diện Mobile tối ưu và các tính năng hỗ trợ cá nhân hóa.
- **Mục tiêu:** Phát triển một ứng dụng kết nối trực tiếp với DB/API Moodle, đồng thời mở rộng thêm các tính năng như Nhật ký học tập (Reflection) và Phân tích tiến độ (Analytics) mà không làm ảnh hưởng lõi hệ thống.

### Slide 3: Phạm vi và đối tượng sử dụng
- Hai luồng người dùng tách biệt:
  - **Sinh viên:** Quản lý bài tập, mục tiêu, theo dõi tiến độ bản thân.
  - **Giáo viên:** Quản lý lớp, phát hiện sinh viên rủi ro, theo dõi tiến độ chung.
- *(Gợi ý ảnh chụp: Màn hình chọn Role ban đầu của ứng dụng)*.

### Slide 4: Kiến trúc tổng thể
- **Frontend:** Flutter (Mobile App - iOS/Android).
- **Backend:** Spring Boot (REST API).
- **Database:** PostgreSQL (Chia schema: `lms` giả lập Moodle core, `app` mở rộng app, `derived` cho các View).
- *(Gợi ý hình ảnh: Mô hình kiến trúc hệ thống CSDL).*

### Slide 5: Các chức năng Sinh viên
- Tổng quan Dashboard (Đếm số khóa học, Task quá hạn).
- Task Center (Sắp xếp bài tập Overdue / Due Soon).
- Nhật ký học tập (Learning Reflections).
- *(Gợi ý ảnh chụp: Màn hình Student Dashboard và Task Center)*.

### Slide 6: Các chức năng Giáo viên
- Danh sách lớp học (Môn học, số lượng sinh viên).
- Phân tích rủi ro lớp học (Class Insights - Ai chưa nộp bài).
- *(Gợi ý ảnh chụp: Màn hình Class Insights của Giáo viên)*.

### Slide 7: Thiết kế Dữ liệu & Data Mapping
- Tại sao phải Map dữ liệu? Tránh can thiệp mã nguồn lõi của LMS.
- Bảng cốt lõi: `lms.user_enrolments`, `lms.assign`, `lms.assign_grades`.
- Bảng mở rộng: `app.learning_reflections`.
- Đã xác thực Mapping nội bộ (VERIFIED_INTERNAL).

### Slide 8: Giao tiếp API và Luồng Dữ liệu
- Ví dụ Luồng Reflection: Sinh viên nhập text $\rightarrow$ App gọi `POST /api/v1/dev/...` $\rightarrow$ Spring Boot Validate $\rightarrow$ Lưu vào `app.learning_reflections`.
- Đảm bảo dữ liệu tức thời và độc lập với LMS.
- *(Gợi ý ảnh chụp: Log API hoặc JSON Response Postman).*

### Slide 9: Kết quả kiểm thử
- **UI Test (Flutter):** 167/167 Test PASS (Hoạt động tốt trên màn hình hẹp 320px).
- **Unit/Mock Test (Backend):** 24/24 Test PASS (Kiểm tra quyền và validate).
- **Integration Test:** Đã thiết lập cấu hình an toàn, chặn can thiệp DB Demo. Đang chờ cấp DB Test chuyên dụng.

### Slide 10: Hạn chế hiện tại
- **Xác thực (Auth):** Đang dùng Dev Bypass (Truyền ID qua URL) để dựng UI, JWT chưa được bật toàn cục.
- **Dữ liệu thật:** Chờ tích hợp API từ LMS DLU chính thức (Đang dùng bản Demo Mock).

### Slide 11: Kế hoạch tiếp theo
- Triển khai Security Phase: Bảo mật API bằng JWT.
- Cấu hình CI/CD chạy Integration Test tự động.
- Liên hệ nhà trường để lấy Schema LMS thật phục vụ ánh xạ trực tiếp.

### Slide 12: Kết luận
- Dự án đã hoàn thiện 100% giao diện, logic luồng nghiệp vụ trên frontend và API cốt lõi trên backend. 
- Sẵn sàng bước vào giai đoạn đấu nối an mật và kiểm thử diện rộng.
- Lời cảm ơn.
