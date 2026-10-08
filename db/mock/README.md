# Demo MVP v3

`seed_demo_v3.sql` chỉ được tạo và kiểm tra offline. Agent chưa chạy seed và chưa thêm bản ghi nào vào database.

Nguồn đối chiếu: `../schema/lms_mobile_learning_schema.sql` và `../schema/current_mock_data.sql` do người dùng cung cấp. Không tạo bảng/view, không sửa dữ liệu cũ, credentials, PostgreSQL role hay identity sequence.

## Dữ liệu dự kiến

Lần chạy đầu trên đúng bản mock đã export: **1.131 bản ghi mới, 30 bảng**. Sau seed: **3 giảng viên, 15 sinh viên, 5 khóa học, 52 course modules, 18 assignment, 10 quiz**. Xem số lượng từng bảng trong `seed_demo_v3_counts.json`.

| Bảng | Thêm |
|---|---:|
| lms."user" | 8 |
| lms.course | 1 |
| lms.context | 1 |
| lms.enrol | 2 |
| lms.user_enrolments | 17 |
| lms.role_assignments | 17 |
| lms.course_sections | 15 |
| lms.assign | 10 |
| lms.course_modules | 36 |
| lms.grade_items | 16 |
| lms.quiz | 6 |
| lms.resource | 17 |
| lms.grade_categories | 3 |
| lms.folder | 1 |
| lms.forum | 1 |
| lms.attendance | 1 |
| lms.course_modules_completion | 364 |
| lms.assign_submission | 59 |
| lms.assign_grades | 49 |
| lms.grade_grades | 108 |
| lms.quiz_attempts | 36 |
| lms.quiz_grades | 14 |
| lms.course_completions | 15 |
| lms.user_lastaccess | 15 |
| lms.logstore_standard_log | 21 |
| lms.attendance_statuses | 4 |
| lms.attendance_sessions | 20 |
| lms.attendance_log | 240 |
| app.notifications | 17 |
| app.learning_reminders | 17 |

Khóa học mới `3000015` có 20 hoạt động; các nhóm tiến độ 100/80/65/35/10%, chuyên cần 100/90/75/50% và không có dữ liệu. Có submitted/draft/new/không có submission, điểm 0/null/điểm thường, quiz finished/inprogress/chưa bắt đầu/nhiều attempt, hoạt động hôm nay hoặc 3/7/12/20 ngày trước. Risk do view hiện tại tính từ dữ liệu, không seed giá trị risk.

Deadline tương đối so với thời điểm bắt đầu transaction: quá hạn 1/7 ngày, còn 8/24/48 giờ, 3/7 ngày và không deadline. Submission hoàn thành có thời gian sau một số deadline quá khứ, thể hiện nộp trễ mà vẫn giữ status Moodle `submitted`.

## PK/FK và ID

- PK của các bảng được seed là `id`; khoảng mới nằm trong `3000000..3000999` theo từng bảng. Không có ID trùng với bản export. Cùng giá trị ID ở hai bảng khác nhau là hợp lệ.
- Giảng viên mới `3000103`; sinh viên mới `3000209..3000215`; giữ nguyên `205`, `102` và các enrolment cũ. Teacher 102 cũng được phân công khóa học mới.
- Tái sử dụng `lms.role.id=3/5`, modules 1..6, course category 1004 và grade categories có sẵn cho course 11..14.
- Role/enrolment: `role_assignments.userid → user.id`, `roleid → role.id`, `contextid → context.id`; context level 50 trỏ course; `enrol.courseid → course.id`, `enrol.roleid → role.id`; `user_enrolments.enrolid → enrol.id`, `userid/modifierid → user.id`.
- Hoạt động: `course_modules.course → course.id`, `module → modules.id`; `instance` trỏ ID bảng activity tương ứng loại module, `section` trỏ section cùng course. URL dùng **course_modules.id**.
- Điểm: grade categories parent cùng course; `grade_items.categoryid → grade_categories.id`; `grade_grades.itemid → grade_items.id`, `userid/usermodified → user.id`; iteminstance trỏ assignment/quiz tương ứng.
- Completion/submission/attempt liên kết đúng user, course hoặc activity. Attendance log liên kết session, status cùng attendance và sinh viên đã enrol. Log activity dùng course context hiện có.
- Danh sách FK đúng theo DDL, khoảng PK mỗi bảng, thứ tự INSERT và SHA-256 của nguồn/seed nằm trong `seed_demo_v3_validation.json`. Một số quan hệ Moodle đa hình không có FK trong DDL đã được kiểm tra logic riêng.

Mỗi INSERT ghi rõ tên cột và dùng `ON CONFLICT (id) DO NOTHING`. Trước INSERT có kiểm tra nội dung định danh ổn định: ID đã tồn tại nhưng khác dữ liệu seed sẽ báo lỗi và transaction không commit. Các UNIQUE khác vẫn do PostgreSQL kiểm tra. Chạy lại cùng seed bỏ qua bản ghi đã có; không làm mới deadline. Database thực tế có thay đổi sau export thì có thể phát sinh conflict mới; chưa xác minh trên database đang chạy.

## Chạy thủ công sau review

1. Review file SQL và báo cáo; dùng database mock `lms_mobile_learning` với kết nối đã cấu hình của bạn.
2. Mở Query Tool của kết nối đó, mở nguyên file UTF-8 `seed_demo_v3.sql`, chạy toàn bộ file. File đã có `BEGIN; ... COMMIT;`.
3. Hoặc dùng PowerShell khi bạn đã cấu hình `PGHOST`, `PGPORT`, `PGUSER` và cơ chế xác thực hiện tại:

```powershell
psql -X --dbname=lms_mobile_learning --set=ON_ERROR_STOP=1 --file="C:\BackendProjects\lms_mobile_backend\db\mock\seed_demo_v3.sql"
```

Không đưa password vào command/file seed. Nếu có lỗi, không chạy riêng COMMIT; trong Query Tool dùng `ROLLBACK;` để kết thúc transaction lỗi rồi kiểm tra nguyên nhân. Nếu authentication lỗi, dừng để kiểm tra cấu hình kết nối của bạn.

Sau khi COMMIT thành công, tải lại dữ liệu trong app. IDs này thuộc dữ liệu mock cục bộ; việc mở nội dung thật trên `lms.dlu.edu.vn` còn phụ thuộc module tương ứng có tồn tại và quyền truy cập Moodle. Seed không đồng bộ dữ liệu lên Moodle.
