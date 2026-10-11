# KỊCH BẢN THUYẾT TRÌNH BÁO CÁO TIẾN ĐỘ LẦN 2 (15 PHÚT - LIVE DEMO)

**Mục tiêu:** Trả lời trực diện 3 câu hỏi cốt lõi của Giảng viên bằng thao tác Live Demo: (1) Khác biệt so với lần 1, (2) Cụ thể hóa Database đến đâu, và (3) Hoàn thiện App đến đâu.
**Chuẩn bị:** Mở sẵn máy ảo/điện thoại chạy App Flutter, mở sẵn phần mềm CSDL pgAdmin, và (tùy chọn) một công cụ gọi API như Postman.

---

## Phần 1 — Mở đầu và đối chiếu sự khác biệt (2 phút)

`[ĐỨNG TRƯỚC HỘI ĐỒNG, CHƯA THAO TÁC MÁY]`

"Kính chào Thầy/Cô. Em xin phép bắt đầu phần Báo cáo Tiến độ Lần 2 của đồ án 'Xây dựng ứng dụng di động hỗ trợ học tập và giảng dạy trên nền tảng LMS'.

Thay vì dùng slide khô khan, hôm nay nhóm em xin phép trình bày trực tiếp trên hệ thống thật gồm Ứng dụng di động và Cơ sở dữ liệu để Thầy/Cô thấy rõ nhất tiến độ dự án.

Nhìn lại Báo cáo lần 1, dự án lúc đó chủ yếu dừng ở mức thiết kế tĩnh (Figma) và định hình ý tưởng. Tuy nhiên, ở Báo cáo Lần 2 này, dự án đã **lột xác hoàn toàn thành một hệ thống 'Live' (hoạt động thực tế)**:
1. **Frontend (App):** Đã hoàn thiện luồng đi của Sinh viên và Giáo viên. Các nút bấm không còn là mô hình tĩnh mà đã gọi dữ liệu thật. (Đã Pass 167 bài kiểm thử giao diện).
2. **Backend:** Toàn bộ REST API cốt lõi đã chạy mượt mà qua Spring Boot. (Đã Pass 24 bài kiểm thử logic).
3. **Database:** Đã cụ thể hóa hoàn chỉnh cấu trúc.

Bây giờ, em xin phép đi thẳng vào chứng minh chi tiết thiết kế Cơ sở dữ liệu và Ứng dụng."

---

## Phần 2 — Database đã cụ thể hóa đến đâu? (5 phút)

`[THAO TÁC: MỞ MÀN HÌNH PGADMIN LÊN]`

"Để giải quyết bài toán cốt lõi là 'Làm sao mở rộng tính năng mới cho Ứng dụng mà không phá hỏng cấu trúc Moodle cũ của trường?', nhóm em đã thiết kế Database chia làm 3 Schema độc lập. Thầy/Cô có thể nhìn trên màn hình pgAdmin lúc này:

**1. Schema thứ nhất: `lms` (Lõi Moodle)**
`[THAO TÁC: Bấm mở schema lms, mở bảng course và user_enrolments]`
Đây là schema mô phỏng lại các bảng có sẵn của nhà trường. Ví dụ bảng `course` (Khóa học) hay `user_enrolments` (Ghi danh). Nhóm cam kết **chỉ Đọc (Read-only)** từ các bảng này. Hơn nữa, nhóm thiết lập các ràng buộc UNIQUE và `ON CONFLICT DO NOTHING` nên kể cả bơm nhầm dữ liệu giả (Seed) cũng không bao giờ làm rác dữ liệu.

**2. Schema thứ hai: `app` (Dữ liệu mở rộng)**
`[THAO TÁC: Bấm mở schema app, chọn bảng learning_reflections]`
Đây là nơi lưu trữ những tính năng mới hoàn toàn do nhóm sáng tạo ra mà Moodle không hề có. Tiêu biểu nhất là bảng `app.learning_reflections` (Nhật ký học tập). Khóa ngoại của bảng này sẽ chỏ thẳng về `user_id` và `course_id` bên schema `lms` để biết sinh viên nào đang viết cảm nghĩ cho môn học nào.

**3. Schema thứ ba: `derived` (Tối ưu hóa API)**
`[THAO TÁC: Bấm mở schema derived, chọn VIEW unified_tasks, chạy lệnh SELECT *]`
Thay vì để App Flutter tự gọi nhiều API và tự ghép nối dữ liệu cực kỳ chậm chạp, nhóm đã thiết kế các **VIEW tổng hợp**. Ví dụ như VIEW `unified_tasks` Thầy/Cô đang xem, nó tự động dùng lệnh JOIN để gom bài tập (`assign`) và bài kiểm tra (`quiz`) lại thành một danh sách duy nhất, có phân loại sẵn tính trạng "Quá hạn" (Overdue).

Như vậy, kiến trúc Database hiện tại (`VERIFIED_INTERNAL`) đã sẵn sàng 100% để đón luồng dữ liệu thật từ nhà trường."

---

## Phần 3 — Ứng dụng đã triển khai đến đâu? (6 phút)

`[THAO TÁC: MỞ MÀN HÌNH MÁY ẢO FLUTTER SONG SONG VỚI PGADMIN]`

"Tiếp theo, ứng dụng Flutter hiện tại đã kết nối sâu với Database như thế nào? Em xin demo trực tiếp.

**1. Luồng của Sinh viên:**
`[THAO TÁC: Trên App, bấm chọn vai trò Sinh viên, vào Task Center]`
Khi em vừa mở Task Center, App đã gọi API xuống thẳng VIEW `unified_tasks` bên pgAdmin. Hệ thống phân loại sẵn bài tập "Quá hạn" và "Sắp đến hạn".

`[THAO TÁC: Bấm sang mục Phân tích (Analytics)]`
Kế đến là màn hình **Phân tích học tập của Sinh viên (Student Analytics)**. Khác với Moodle gốc chỉ hiện điểm số khô khan, App tổng hợp biểu đồ trực quan về tỷ lệ hoàn thành bài tập, điểm danh và dự báo rủi ro rớt môn để sinh viên tự điều chỉnh tiến độ học.
Trong phần Analytics này có nút Thêm Nhật ký (Reflection). 
`[THAO TÁC: Nhập nội dung: "Hôm nay làm live demo rất vui", chọn 5 sao, bấm Lưu]`
Để chứng minh dữ liệu này là thật, em xin quay lại pgAdmin.
`[THAO TÁC: Chuột phải vào bảng app.learning_reflections ở pgAdmin -> View/Edit Data -> Xem dòng mới nhất]`
Dòng chữ "Hôm nay làm live demo rất vui" đã lập tức chui xuống Database. Chuỗi Data Mapping từ App $\rightarrow$ API $\rightarrow$ Database đã thông suốt!

**2. Luồng của Giáo viên (Trợ lý Giảng dạy):**
`[THAO TÁC: Trên App, back ra, đổi vai trò sang Giáo viên]`
Mục tiêu của luồng Giáo viên là biến Ứng dụng thành một **Trợ lý giảng dạy (Teacher Assistant)** đắc lực. Thay vì giáo viên phải lặn lội trên web tìm xem ai chưa làm bài, App tự động làm thay việc đó.

`[THAO TÁC: Bấm vào 1 lớp học, mở mục Class Insights và cuộn xuống Needs Attention]`
Đây là phần **Phân tích môn học của Giáo viên (Teacher Class Insights)**. App sẽ gọi API phân tích rủi ro dựa trên một quy tắc Database rất thông minh: Tìm những sinh viên có tên trong bảng ghi danh (`user_enrolments`) nhưng điểm trong bảng (`assign_grades`) lại có giá trị là `NULL` (tức là chưa nộp bài). Nếu sinh viên đó bị `NULL`, trợ lý ảo sẽ tự động đưa họ vào danh sách **Needs Attention** để Thầy/Cô cảnh báo ngay lập tức. Dữ liệu xử lý cực kỳ chính xác.

Tất cả các tính năng Thầy/Cô vừa xem đều là **chức năng hoàn thiện có kết nối Backend**. Điểm giới hạn duy nhất hiện nay là nhóm đang mở luồng 'Dev Bypass' (truyền thẳng ID sinh viên) để đăng nhập nhanh. Chức năng chặn API bằng JWT Token sẽ được thực hiện ở Phase tới."

---

## Phần 4 — Kết luận & Kế hoạch (2 phút)

`[THAO TÁC: ĐỨNG NHÌN HỘI ĐỒNG, KẾT THÚC THAO TÁC MÁY]`

"Để đảm bảo hệ thống này không bị sập hay lỗi vặt, nhóm đã code 167 kịch bản Test tự động cho Flutter và 24 Test cho Backend API. 

Tóm lại, dự án hiện đã vượt xa giai đoạn thiết kế lý thuyết:
- Database đã được phân mảnh an toàn (3 Schema).
- App Flutter đã xử lý logic mượt mà (Task Center, Reflection, Class Insights).
- Mọi dữ liệu Thầy/Cô thấy đều là luồng Live.

**Kế hoạch sắp tới của nhóm:**
1. Khóa chặt bảo mật API bằng JWT Token (Authentication).
2. Xây dựng môi trường Database Test tự động (hiện tại Integration Test đang bị Blocked để bảo vệ DB Demo).
3. Đề xuất xin cấp quyền để cắm API trực tiếp vào CSDL thật của nhà trường (`PROPOSED_DLU`).

Phần Live Demo của em đến đây là kết thúc. Em xin cảm ơn Thầy/Cô đã theo dõi và rất mong được Thầy/Cô đặt câu hỏi ạ."

---
---

## PHỤ LỤC: CÂU HỎI CÓ THỂ ĐƯỢC GIẢNG VIÊN HỎI (Q&A)

**1. Database đã cụ thể hóa tới mức nào?**
- Hệ thống đã có 3 Schema phân biệt trách nhiệm (`lms`, `app`, `derived`), có bảng dữ liệu thực, cấu trúc constraint, dữ liệu mẫu (Seed V4) mô phỏng chính xác DB Moodle. Không còn nằm trên giấy.

**2. Các bảng quan trọng liên kết với nhau như thế nào?**
- Bảng `assign_grades` (Điểm) liên kết qua `assign_id` và `user_id`. Khóa ngoại này giúp hệ thống truy xuất bài làm của sinh viên tương ứng với môn học nào, làm cơ sở lọc ra danh sách "Chưa nộp bài".

**3. Vì sao cần VIEW thay vì để Flutter truy vấn trực tiếp?**
- Flutter không được phép gọi trực tiếp Database vì rủi ro bảo mật. Hơn nữa, nếu để Backend tự JOIN nhiều bảng `course`, `assign`, `assign_grades` mỗi khi App gọi sẽ rất chậm. VIEW ở Database sẽ xử lý tính toán và tối ưu tốc độ, Backend chỉ việc `SELECT` và trả JSON.

**4. Data Mapping Matrix đã hoàn thành phần nào?**
- Hoàn thành phần **Mapping Nội bộ (VERIFIED_INTERNAL)**: Từ bảng Mock DB lên API và lên App. Còn phần Mapping từ DB DLU thật thì đang ở mức **Đề xuất (PROPOSED_DLU)**.

**5. Làm sao chứng minh dữ liệu trên màn hình đến từ database?**
- (Đã demo trực tiếp trong bài). 

**6. Lần 2 khác lần 1 bằng những bằng chứng nào?**
- Khác biệt lớn nhất là tính "Động" (Live System). Lần 1 chưa có Backend API. Lần 2 đã thao tác được trên Database thật và App thật.

**7. Những chức năng nào đã chạy thực tế?**
- Dashboard tổng quan, Danh sách bài tập (Task Center), Phân tích (Analytics), Viết nhật ký (Reflection), Cảnh báo học sinh chưa nộp bài (Needs Attention).

**8. Test mock khác integration test như thế nào?**
- Mock test là kiểm tra logic code API (bỏ qua Database). Integration test là kiểm tra toàn diện API chạy thẳng vào ghi dữ liệu trên Database thật (Hiện đang BLOCKED do quy định an toàn khóa DB Demo).

**9. Vì sao chưa thể nói đã tích hợp LMS DLU chính thức?**
- Vì DB hiện tại là dữ liệu giả lập (Seed V4) do nhóm tự bơm vào dựa trên cấu trúc Moodle. Chưa hề có đường truyền kết nối vào CSDL thật của ĐH Đà Lạt.

**10. Vì sao chưa có Authentication hoàn chỉnh và kế hoạch xử lý ra sao?**
- Để chấm điểm được luồng giao diện nhanh nhất, nhóm dùng API `dev/` truyền thẳng ID. Ở giai đoạn (Phase) tiếp theo, nhóm sẽ đưa JWT Filter vào chặn mọi API, ai đăng nhập mới được cấp Token.

**11. Dữ liệu mock có thể thay bằng dữ liệu chính thức như thế nào?**
- Chỉ cần đổi thông tin Datasource (`url`, `username`, `password`) trong file `application.yml` trỏ về máy chủ trường. Do cấu trúc 3 Schema đã thiết kế chuẩn, mọi chức năng sẽ tự động tương thích.

**12. Rủi ro lớn nhất trước giai đoạn tiếp theo là gì?**
- Bảo mật API (Thiếu Auth) và việc chưa thiết lập xong môi trường Database riêng biệt để chạy Integration Test một cách tự động (CI/CD).
