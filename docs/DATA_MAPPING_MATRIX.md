# Lms Mobile App - Data Mapping Matrix

Tài liệu này ánh xạ các thực thể dữ liệu từ cơ sở dữ liệu PostgreSQL tới các Endpoint của API và các màn hình hiển thị tương ứng trên ứng dụng Flutter.

## 1. Derived Views -> API -> Flutter Mapping

| Derived View (PostgreSQL) | API Endpoint (Spring Boot) | Flutter Screen / Widget | Chức năng |
| :--- | :--- | :--- | :--- |
| `derived.student_dashboard` | `GET /api/v1/dev/students/{id}/dashboard` | `StudentDashboardScreen` | Tổng quan số lượng khóa học, nhiệm vụ quá hạn, rủi ro, điểm danh. |
| `derived.student_course_overview` | `GET /api/v1/dev/students/{id}/courses` | `StudentCoursesScreen` | Khóa học sinh viên đang tham gia & tiến độ. |
| `derived.unified_tasks` | `GET /api/v1/dev/students/{id}/tasks` | `StudentTaskCenterScreen` | Nhiệm vụ (bài tập, quiz) sắp xếp theo deadline. |
| `derived.student_learning_analytics` | `GET /api/v1/dev/students/{id}/insights` | `StudentAnalyticsScreen` | Phân tích học tập, điểm danh, tiến độ. |
| `derived.teacher_dashboard` | `GET /api/v1/dev/teachers/{id}/dashboard` | `TeacherHomeScreen` | Lớp học giáo viên phụ trách, học viên rủi ro, bài cần chấm. |
| `derived.teacher_course_overview` | `GET /api/v1/dev/teachers/{id}/courses` | `TeacherCoursesScreen` | Danh sách lớp học và tiến độ trung bình. |

## 2. App Schema (Custom Data) -> API -> Flutter

| App Table | API Endpoint | Flutter Screen | Mô tả |
| :--- | :--- | :--- | :--- |
| `app.learning_goals` | `GET /api/v1/dev/students/{id}/goals` | `StudentGoalsScreen` | Mục tiêu học tập. |
| `app.flashcards` | `GET /api/v1/dev/students/{id}/flashcards` | `StudentFlashcardScreen` | Bộ thẻ học. |
| `app.learning_reflections` | `GET /api/v1/dev/students/{id}/reflections` | `StudentReflectionScreen` | Nhật ký học tập cá nhân. |
| `app.notifications` | `GET /api/v1/notifications` | `NotificationsScreen` | Thông báo gửi từ backend đến app. |
| `app.teacher_notes` | `GET /api/v1/dev/teachers/{id}/notes` | `TeacherNotesScreen` | Ghi chú của giáo viên về sinh viên/lớp học. |

## 3. Chi tiết Mapping & Bằng chứng kiểm tra

### 3.1. Student Home
- **PostgreSQL Source:** `lms.user_enrolments`, `lms.course`, `lms.assign`, `lms.assign_grades` -> JOIN/transformation -> `derived.student_dashboard`.
- **Spring Boot Endpoint:** `GET /api/v1/dev/students/{id}/dashboard` (Method: GET).
- **Flutter Consumer:** `ApiService.getStudentDashboard()` -> `StudentDashboardScreen`.
- **Bằng chứng kiểm tra:** Gọi API trả về HTTP 200, hiển thị đúng tiến độ và số khóa học.
- **Trạng thái:** `VERIFIED_INTERNAL`.

### 3.2. Task Center
- **PostgreSQL Source:** `lms.assign`, `lms.quiz` -> `derived.unified_tasks`.
- **Spring Boot Endpoint:** `GET /api/v1/dev/students/{id}/tasks` (Method: GET).
- **Flutter Consumer:** `StudentTaskCenterScreen`.
- **Bằng chứng kiểm tra:** Có dữ liệu task quá hạn, đến hạn. Kiểm tra task trạng thái pending/completed khớp với data seed `assign_grades`.
- **Trạng thái:** `VERIFIED_INTERNAL`.

### 3.3. Analytics, Goals và Reflections
- **PostgreSQL Source (Analytics):** `lms.attendance_log`, `lms.assign_grades`.
- **PostgreSQL Source (Goals):** `app.learning_goals`.
- **PostgreSQL Source (Reflections):** `app.learning_reflections` (Đã cập nhật tên bảng).
- **Spring Boot Endpoint:** `/insights`, `/goals`, `/reflections`.
- **Bằng chứng kiểm tra:** API Reflection trả về mảng rỗng ban đầu, cho phép POST tạo mới, và GET lại dữ liệu chính xác. Dữ liệu Goals phản hồi JSON đúng format, xử lý an toàn giá trị `NULL`.
- **Trạng thái:** `VERIFIED_INTERNAL`.

### 3.4. Teacher Course Detail & Student Monitoring
- **PostgreSQL Source:** `lms.user_enrolments` (lấy danh sách user) LEFT JOIN `lms.assign_grades` (lấy trạng thái nộp bài).
- **Spring Boot Endpoint:** `GET /api/v1/dev/teachers/{id}/courses/{courseId}/class-insights`.
- **Bằng chứng kiểm tra:** Bao gồm cả sinh viên chưa nộp bài (do JOIN từ enrolments). Dữ liệu 5 sinh viên ảo 400000x đã test tốt trên biểu đồ.
- **Trạng thái:** `VERIFIED_INTERNAL`.

## 4. Lộ trình tích hợp LMS DLU chính thức (Moodle LMS)
Các bảng `lms.*` được thiết kế tương đương với `mdl_*` trên Moodle. Tuy nhiên, hiện tại **chưa có schema Moodle thực tế hoặc API cấp phép**.
- **Trạng thái mapping với DLU:** `PROPOSED_DLU` (Đề xuất, đang chờ xác nhận).
- Không mặc định các mapping này là đã hoàn tất cho đến khi được kiểm chứng với CSDL thật.