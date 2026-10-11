# KỊCH BẢN LIVE DEMO (BÁO CÁO TIẾN ĐỘ LẦN 2)

**Thời lượng dự kiến:** 7 - 10 phút.

## 1. Chuẩn bị & Kiểm tra môi trường (Trước khi Demo)
- **Mở Spring Boot:** Chạy lệnh `.\mvnw.cmd spring-boot:run` và đợi báo "Started Application".
- **Kiểm tra API Health:** Tuyệt đối **không** dùng `http://localhost:8080/api/v1/health` vì hiện đang bị Spring Security khóa (HTTP 403 Forbidden). Hãy dùng postman hoặc trình duyệt gọi thử `http://localhost:8080/api/v1/dev/students/501/dashboard`. Nếu ra JSON là OK.
- **Mở App Flutter:** Chạy `flutter run` qua máy ảo hoặc máy thật cắm cáp.

## 2. Giới thiệu tổng quan (1 phút)
- **Hành động:** Trình bày màn hình chọn Role (Sinh viên / Giáo viên) ban đầu.
- **Thuyết minh:** "Ứng dụng LMS Mobile được thiết kế chia làm hai luồng riêng biệt, một bên tối ưu cho sinh viên tự quản lý tiến độ, một bên giúp giáo viên theo sát lớp học."

## 3. Demo Luồng Sinh viên (3 phút)
- **Hành động:** Bấm chọn vai trò **Sinh viên**.
- **Course Overview:** Cho xem Student Dashboard. Thuyết minh số lượng khóa đang học và thanh tiến độ hoàn thành.
- **Task Center:** Bấm sang mục Bài tập.
  - *Kết quả mong đợi:* Thấy được các bài tập Overdue (màu đỏ) và Due Soon.
- **Analytics & Reflection:** 
  - Bấm vào mục Phân tích tiến độ học tập (Student Analytics). 
  - Bấm nút "Thêm Reflection" (Nhật ký học tập) và gõ thử một đoạn nội dung, chọn mức độ hiểu bài. Lưu lại.
  - *Kết quả mong đợi:* Dữ liệu hiện ra ngay lập tức trên màn hình.
  - *Thuyết minh API:* "Chức năng Reflection này gọi thẳng xuống REST API của Spring Boot. Nó độc lập hoàn toàn với LMS gốc, không làm nặng thêm server của nhà trường."

## 4. Demo Luồng Giáo viên (3 phút)
- **Hành động:** Back ra ngoài hoặc Restart App, chọn vai trò **Giáo viên**.
- **Danh sách lớp:** Màn hình Teacher Home hiện ra các môn học (VD: Lập trình Web).
- **Class Insights & Needs Attention:** 
  - Bấm vào chi tiết một lớp học. 
  - Cuộn đến phần "Needs Attention".
  - *Kết quả mong đợi:* Liệt kê được những học sinh chưa nộp bài (do bảng `assign_grades` không có điểm nhưng `enrolments` thì có tên sinh viên).
  - *Thuyết minh:* "Ứng dụng kết nối bảng ghi danh và điểm số của Moodle thông qua VIEW, sau đó lọc ra sinh viên cần nhắc nhở. Việc này giúp giáo viên dễ can thiệp hơn là phải lặn lội trên Web Moodle."

## 5. Trình bày Bằng chứng Kiểm thử (1 phút)
- **Hành động:** Mở nhanh file `docs/DATA_VALIDATION_REPORT.md` hoặc chỉ bật qua slide.
- **Thuyết minh:** "Ứng dụng đã vượt qua 167/167 UI Test của Flutter và 24 API Logic Test, khẳng định sự ổn định giao diện trên màn hình nhỏ."

## 6. Giới hạn hiện tại & Hướng giải quyết (1 phút)
- **Thuyết minh:** "Như các Thầy/Cô có thể thấy, hiện tại app đang có thể vào thẳng Dashboard thông qua Dev Access mà không cần login. Đây là một giới hạn để nhóm tập trung phát triển UI/UX trước. Ở Phase tiếp theo, Auth bằng JWT sẽ được kích hoạt toàn diện."

## 7. Phương án dự phòng (Fallback)
- **Nếu API/Mạng chết:** Flutter App đã được code sẵn giao diện trạng thái lỗi. Hãy chỉ vào thông báo Lỗi Mạng thân thiện của app và giải thích: "Ứng dụng có cơ chế xử lý lỗi rất mượt, báo lỗi cho người dùng thay vì crash văng app."
- **Nội dung cần xác minh trước:** Đảm bảo Backend thực sự đang chạy (như đề cập ở Mục 1).
