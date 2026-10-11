# KỊCH BẢN THUYẾT TRÌNH BÁO CÁO TIẾN ĐỘ LẦN 2 (15 PHÚT)

**Mục tiêu:** Trả lời trực diện 3 câu hỏi cốt lõi của Giảng viên: (1) Khác biệt so với lần 1, (2) Cụ thể hóa Database đến đâu, và (3) Hoàn thiện App đến đâu.
**Công cụ cần chuẩn bị:** Slide thuyết trình, App Flutter đang chạy, pgAdmin/DBeaver để mở Database, Postman (tùy chọn).

---

## PHẦN 1: TỔNG QUAN & ĐIỂM KHÁC BIỆT SO VỚI LẦN 1 (3 Phút)

**Slide gợi ý:** Bảng so sánh (Lần 1 vs Lần 2).

**[Lời thoại]**
"Kính chào Thầy/Cô. Để mở đầu phần Báo cáo Tiến độ Lần 2 của đồ án 'LMS Mobile', em xin phép tóm tắt nhanh sự lột xác của dự án so với Báo cáo lần 1. 

Ở Lần 1, nhóm chủ yếu mới định hình ý tưởng, thiết kế UI tĩnh trên Figma, và dựng khung sườn cơ bản cho backend. Dữ liệu lúc đó chỉ là dữ liệu giả (hardcode) tĩnh trên Frontend.

Nhưng trong Báo cáo Lần 2 này, dự án đã là một sản phẩm **chạy thực tế (Live)**:
1. **Frontend không còn là giao diện tĩnh:** Flutter đã thực sự kết nối với Backend API.
2. **Backend Spring Boot đã hoạt động:** Có Controller, Service, Repository rõ ràng.
3. **Database PostgreSQL đã được triển khai:** Có Schema, có dữ liệu mẫu (Seed) và có Data Mapping Matrix cụ thể. Mọi thao tác trên App đều làm thay đổi dữ liệu dưới Database."

---

## PHẦN 2: ĐÃ CỤ THỂ HÓA DATABASE ĐẾN ĐÂU? (5 Phút)

**Màn hình trình chiếu:** Chuyển sang phần mềm quản trị CSDL (pgAdmin) hoặc Slide mô hình Data Mapping Matrix.

**[Lời thoại]**
"Trọng tâm lớn nhất của lần báo cáo này là cách nhóm cụ thể hóa Database. Nhóm đã giải quyết bài toán: Làm sao làm App mới nhưng không được phá vỡ cấu trúc Moodle cũ của trường?

Nhóm đã chia Database thành **3 Schema độc lập**:
1. **Schema `lms` (Lõi Moodle):** Nhóm giữ nguyên các bảng cốt lõi của Moodle như `user_enrolments` (Ghi danh), `course` (Khóa học), `assign`, `assign_grades` (Bài tập, điểm số). Nhóm cam kết **chỉ Đọc (Read-Only)** từ các bảng này, tuyệt đối không Ghi/Xóa để đảm bảo an toàn cho hệ thống gốc.
2. **Schema `derived` (Tối ưu hóa View):** Nhóm đã viết các View SQL phức tạp tại đây. Ví dụ, thay vì App phải gọi nhiều API để tìm học sinh trễ bài, nhóm đã viết View `derived.unified_tasks` JOIN giữa bảng Khóa học, Bài tập và Điểm. Backend chỉ việc Query View này, giúp API phản hồi cực nhanh.
3. **Schema `app` (Dữ liệu mở rộng):** Đây là nơi nhóm tự do sáng tạo. Những tính năng Moodle không có như `learning_reflections` (Nhật ký học tập) hay `learning_goals` (Mục tiêu) sẽ được lưu và ghi (Write) trực tiếp vào schema `app` này.

*(Thao tác Live: Mở bảng `app.learning_reflections` lên cho GV xem dữ liệu đang có).*

Bằng cách phân tách 3 lớp Schema này, hệ thống Database của nhóm đã sẵn sàng 100% về mặt cấu trúc để có thể đấu nối an toàn với CSDL thật của nhà trường."

---

## PHẦN 3: ĐÃ LÀM APP (FLUTTER) ĐẾN ĐÂU? (5 Phút)

**Màn hình trình chiếu:** Trình chiếu màn hình điện thoại (Máy ảo hoặc cáp kết nối). Thao tác trực tiếp trên App.

**[Lời thoại]**
"Về phía Ứng dụng di động (Flutter), nhóm đã hoàn thiện trọn vẹn luồng nghiệp vụ (Business Logic) cốt lõi cho cả 2 vai trò Sinh viên và Giáo viên. Nhóm đã xử lý xong toàn bộ các lỗi giao diện tràn màn hình (Overflow), đảm bảo UI hiển thị mượt mà kể cả khi người dùng phóng to chữ (TextScale x1.8). Cụ thể:"

**1. Thao tác Luồng Sinh viên:**
- "Từ Dashboard, sinh viên thấy ngay tiến độ tổng quan. Khi vào **Task Center**, App gọi API và tự động phân loại những bài tập nào đang 'Quá hạn' (màu đỏ) và 'Sắp đến hạn'. Việc này được xử lý real-time."
- "Ở tính năng **Nhật ký học tập (Reflection)**, sinh viên có thể tự đánh giá quá trình học." 
*(Thao tác: Nhập 1 dòng Reflection mới, bấm lưu)*. 
"Sau khi em bấm lưu, dữ liệu này lập tức đi qua Spring Boot và chui xuống bảng `app.learning_reflections` ở Database mà em vừa trình bày."

**2. Thao tác Luồng Giáo viên:**
- *(Thao tác: Đổi sang role Giáo viên, vào Class Insights của 1 môn học).*
- "Phía Giáo viên, thay vì các con số khô khan, App tự động lọc ra danh sách **'Needs Attention'** (Những sinh viên chưa nộp bài hoặc bị rớt). Tính năng này chạy được là nhờ Backend đã cross-check giữa danh sách ghi danh và bảng điểm trống, từ đó đẩy lên App."

---

## PHẦN 4: HẠN CHẾ HIỆN TẠI VÀ HƯỚNG ĐI SẮP TỚI (2 Phút)

**Slide gợi ý:** Giới hạn & Kế hoạch (Phase Integration & Security).

**[Lời thoại]**
"Tóm lại, App và Database đã được đấu nối thông suốt. Tuy nhiên, để đồ án hoàn thiện 100%, vẫn còn một số giới hạn mà nhóm sẽ khắc phục ở đợt tới:

1. **Xác thực và Bảo mật (Authentication):** Hiện tại để thuận tiện cho việc trình bày và chấm điểm UI, hệ thống API đang cho phép đi đường tắt (Dev Bypass) bằng cách truyền thẳng ID sinh viên. Ở đợt tới, nhóm sẽ kích hoạt bảo mật **JWT Token** để khóa chặn API.
2. **Dữ liệu thật:** Các dữ liệu Thầy/Cô vừa xem được nhóm dùng kịch bản Seed Demo mô phỏng y hệt cấu trúc của Moodle. Nhóm rất mong sẽ sớm được cấp quyền truy cập Read-only vào Database thật của trường để App có thể hiển thị dữ liệu của sinh viên thật.

Đó là toàn bộ phần Báo cáo tiến độ lần 2 của nhóm. Nhóm xin cảm ơn Thầy/Cô đã lắng nghe và rất mong nhận được góp ý."
