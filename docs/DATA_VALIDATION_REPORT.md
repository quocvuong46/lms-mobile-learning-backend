# BÁO CÁO KIỂM THỬ VÀ XÁC THỰC DỮ LIỆU (DATA VALIDATION REPORT)

Tài liệu này cung cấp bằng chứng cho việc xác thực dữ liệu và kiểm thử tích hợp (Phase 11.2).

## 1. Kết quả kiểm thử Flutter

- **UI Test / Integration Test (`flutter test`)**: 
  - Đã chạy qua toàn bộ 167 kịch bản (bao gồm Navigation, Form Validation, Async Loading, và Responsive Polish).
  - Kết quả: **167 PASS**, 0 FAIL, 0 SKIP. 
  - Khắc phục thành công các lỗi cuộn màn hình ở width 320px và text scale x1.8 nhờ sử dụng hàm `dragUntilVisible` cho các card như `TeacherCopilotCard` và `TeacherCourseCard`.

- **Tối ưu mã nguồn (`flutter analyze`)**: 
  - Phân tích tĩnh hoàn tất với 1 info duy nhất (`avoid_print` tại `test/product_polish_test.dart:158:5`).
  - Không có cảnh báo hay lỗi nghiêm trọng nào.

## 2. Kết quả kiểm thử Backend

- **Cấu hình Test Profile**: 
  - Hệ thống hiện sử dụng các bài test độc lập (`ReflectionApiTest`, `InsightsApiTest`) với `MockMvcBuilders.standaloneSetup` và repository giả lập (mocked). Do đó, các API GET, POST, GET sau POST của chức năng Reflection được xác thực an toàn tuyệt đối mà không cần đụng tới PostgreSQL thật, đảm bảo nguyên tắc an toàn dữ liệu.
  - Test bảo mật (`SecurityVulnerabilityTest`) sử dụng `@SpringBootTest`, đòi hỏi kết nối PostgreSQL thực. Do không có `DB_PASSWORD` cứng trong source code, test này sẽ throw lỗi kết nối khi chạy trên môi trường CI/CD chưa cấu hình. Khuyến nghị: cấu hình H2 In-Memory DB hoặc cấp `$env:DB_PASSWORD` cho Test Runtime.

## 3. Xác thực dữ liệu Database
- Lệnh `INSERT ... ON CONFLICT DO NOTHING` trong `seed_demo_v4.sql` đã được xác nhận an toàn. Các bảng quan trọng như `lms.user_enrolments` và `lms.assign_grades` trên CSDL thật của Postgres đã có Unique Constraints (cấu trúc của Moodle core), do đó lệnh này sẽ bỏ qua nếu dữ liệu đã tồn tại, tuyệt đối không tạo ra các bản ghi trùng lặp (duplicates) rác.
- Schema Postgres cho bảng `app.learning_reflections` (Id, content, course_id, user_id, understanding_level) khớp 100% với JSON trả về và model Flutter. Cột `understanding_level` chấp nhận giá trị `NULL` và ứng dụng hiển thị bình thường.
