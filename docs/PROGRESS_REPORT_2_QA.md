# CÂU HỎI PHẢN BIỆN (Q&A) DỰ KIẾN - BÁO CÁO TIẾN ĐỘ LẦN 2

**1. Vì sao nhóm chọn dùng Flutter, Spring Boot và PostgreSQL?**
- **Trả lời:** 
  - **Flutter:** Giúp phát triển app cho cả iOS và Android chỉ với 1 source code, tiết kiệm thời gian, UI mượt mà, dễ responsive.
  - **Spring Boot:** Cung cấp REST API mạnh mẽ, dễ dàng kết nối JDBC tới PostgreSQL, chịu tải tốt.
  - **PostgreSQL:** Là CSDL mặc định và mạnh nhất của Moodle. Việc dùng chung loại DB giúp dễ tái sử dụng cấu trúc bảng (schema) và dữ liệu.

**2. Vì sao phải tách `lms`, `app` và `derived` schema?**
- **Trả lời:** Nhằm không đụng chạm hay phá hỏng cấu trúc nguyên bản của LMS nhà trường (`lms`). Các chức năng app tạo ra thêm như Nhật ký sẽ nằm ở `app`. Các dữ liệu cần join phức tạp để trả API nhanh sẽ đặt ở `derived`. Điều này đảm bảo an toàn tuyệt đối cho hệ thống cũ.

**3. Data Mapping Matrix giải quyết vấn đề gì?**
- **Trả lời:** Giúp minh bạch nguồn gốc dữ liệu. Mọi dữ liệu hiển thị trên App (Ví dụ màn hình Task Center) đều có nguồn gốc rõ ràng (từ bảng `assign` của Postgres qua VIEW `unified_tasks`), chứng minh dự án không hề bịa dữ liệu giả lập (hard-code).

**4. Dữ liệu mock (Demo) hiện tại khác gì dữ liệu LMS thật?**
- **Trả lời:** Dữ liệu Mock mô phỏng lại cấu trúc (Tên bảng, Tên cột, Constraint) của Moodle thực tế, nhưng ID và nội dung là giả lập (Seed V4). Dữ liệu thật sẽ yêu cầu kết nối vào CSDL của trường (Chưa được cấp phép ở thời điểm hiện tại).

**5. Vì sao chưa thể xác nhận tích hợp LMS DLU thật?**
- **Trả lời:** Cần phải có quyền truy cập VPN hoặc API key của nhà trường để đấu nối. Hiện tại quy trình xin cấp phép đang được thực hiện. Tuy nhiên, do cấu trúc DB của nhóm đã mô phỏng chuẩn Moodle, việc chuyển đổi sang DB thật dự kiến sẽ rất mượt mà.

**6. Backend test nào đã PASS, test nào đang BLOCKED?**
- **Trả lời:** 
  - Đã **PASS 24/24** các bài Test Mock API (Kiểm tra validate, phân quyền logic, HTTP Response). 
  - Các bài Test Integration (đòi hỏi kết nối DB để kiểm tra toàn vẹn) đang bị **BLOCKED** do nhóm thiết lập chặn chạy trên Demo Database nhằm đảm bảo an toàn không rác dữ liệu, và đang chờ cấp Database Test chuyên dụng.

**7. Vì sao chưa tuyên bố bảo mật hoàn chỉnh khi vẫn còn Dev bypass?**
- **Trả lời:** Hiện tại app vẫn đang cho phép truy cập qua endpoint `/api/v1/dev/` mà không cần Token (JWT) để thuận tiện cho quá trình dựng giao diện. Hệ thống phân quyền chưa áp dụng toàn cục nên chưa thể coi là an toàn tuyệt đối, đây là trọng tâm của Phase tiếp theo.

**8. Seed V4 đã được xác minh đến mức nào?**
- **Trả lời:** Đã được xác minh mức **Tĩnh (VERIFIED_STATIC)**. Nhóm đã phân tích mã SQL, nhận thấy câu lệnh `ON CONFLICT DO NOTHING` và các ràng buộc UNIQUE của Moodle Schema đảm bảo tính an toàn (Idempotent), không gây trùng lặp dữ liệu. Tuy nhiên, nhóm chưa thực nghiệm nó trên Database Test riêng.

**9. Kế hoạch tích hợp nguồn dữ liệu chính thức là gì?**
- **Trả lời:** Nhóm sẽ hoàn thiện hệ thống JWT Authentication trước. Sau đó, cấu hình một Datasource trỏ tới LMS thật (nếu được cấp quyền Read-Only) để load bảng Course và User.

**10. Các rủi ro và giới hạn lớn nhất hiện tại?**
- **Trả lời:** Thiếu môi trường Database Test CI/CD tự động; Chưa có JWT bảo mật API; Phụ thuộc vào dữ liệu Demo giả lập để thuyết trình.
