# Authentication MVP — P0-01

> **Trạng thái ngày 09/10/2026: P0-01 đã được tạm hoàn tác.** App hiện mở màn hình chọn vai trò demo,
> dùng Student 205 / Teacher 102 và các API `/dev` cũ; không cần JWT hoặc tài khoản đăng nhập.
> Nội dung phía dưới chỉ là tài liệu lịch sử của P0-01, không mô tả code đang chạy.
> Không chạy hai script `db/auth/` để sử dụng demo. Các script được giữ nguyên và chưa được thực thi trong lần hoàn tác này.
> Phần code P0-01 trước khi hoàn tác đã được sao lưu tại `C:\BackendProjects\.mvp_work\p001_rollback_20261009`.

## Scope and architecture

Flutter LoginScreen → SessionService → POST /api/v1/auth/login → AuthService → AuthRepository (JdbcTemplate).
Authentication uses a separate `app.auth_account`; it never checks or changes `lms."user".password`.
All SQL in the Java repositories is read-only. The setup SQL below is for manual review/execution only.

Backend uses Spring Security with the Boot-managed `spring-security-oauth2-jose`/Nimbus implementation.
Passwords are checked with BCrypt cost 10. Unknown, disabled, deleted, suspended and role-less accounts receive the same login 401.
No password, password hash, JWT secret or full access token is logged or included in user responses.

## Endpoints and contracts

* `POST /api/v1/auth/login`: JSON `{ "username": "...", "password": "..." }`.
* Response: `{ "access_token": "...", "token_type": "Bearer", "expires_in": 900, "user": { ... } }`.
* `GET /api/v1/auth/me`: Bearer token required; returns `id`, demo-account `username`, `fullname`, `email`,
  nullable `student_code`, `cohort_code`, `class_code`, `major_name`, and `roles`.
* `GET /api/v1/students/me/dashboard`: STUDENT required. Takes the LMS user ID from `CurrentUser`;
  ignores any `userId` query parameter and reuses `StudentService.getStudentDashboard` without duplicate SQL.
* Auth errors use `{ "status": 401, "code": "UNAUTHORIZED", "message": "..." }`.
  Invalid request: 400/INVALID_REQUEST; role mismatch: 403/FORBIDDEN; auth persistence unavailable: 503/AUTH_UNAVAILABLE.
  Database/internal exception text is not returned by auth endpoints.

## JWT and current user

HS256, issuer `lms-mobile`, `sub` is the decimal LMS user ID. Claims include `user_id`, `roles`, `iat`, `exp`, `jti`.
`jti` makes each login token distinct. Tokens do not contain password, email or academic metadata.
Signature, issuer, expiry, required identity/role claims and subject consistency are verified.
Expiry has no additional clock-skew allowance; keep client/server clocks correct.
Token lifetime defaults to 900 seconds; configuration accepts 60–3600 seconds.

After signature validation, the filter reloads the active auth account and roles from the repository.
Disabled/deleted/suspended accounts cannot continue using a previous token; role changes apply on the next request.
Authorities come from the current database mapping, not client JSON. `CurrentUser` implements `Principal`.
A separate password-based `UserDetailsService` is unnecessary for this explicit login flow; no generated/basic login is used.

## Role mapping

* STUDENT: active `lms.user_enrolments` + active `lms.enrol` + `lms.role` with `shortname` or `archetype = student`.
  Enrolment start/end timestamps are checked (zero is unbounded).
* TEACHER: `lms.role_assignments` → `lms.role` → `lms.context`, `contextlevel = 50`, actual course exists;
  `teacher` or `editingteacher` shortname/archetype.
* Return both roles when both conditions hold. No user ID determines role.
* Source audited against `db/schema/lms_mobile_learning_schema.sql` student progress and teacher overview definitions.
  No direct/live PostgreSQL audit was performed in this task.
* This is role discovery, not complete Teacher course-level authorization. That is a subsequent task.

## Manual database setup

Prerequisites: existing `app` schema, `lms."user"`, role/enrolment tables, and confirmed
`derived.student_academic_profile(userid, student_code, fullname, email, cohort_code, class_code, major_name)`.
The saved schema export does not include the latter view; use the already-created view and verify its contract manually.
No academic schema or Moodle rows are created by these auth scripts.

Review and run in this order, using pgAdmin Query Tool on `lms_mobile_learning` with your existing authorized connection:

1. `db/auth/001_create_auth_account.sql`
2. `db/auth/002_seed_demo_auth.sql`

Both have BEGIN/COMMIT. No script was executed by the coding agent.
The auth table uses an identity PK, unique `userid` FK to `lms."user"(id)`, unique case-sensitive username,
BCrypt-only password hash, enabled flag and timestamps. One auth account per LMS user.
`updated_at` must be set by any future account-management implementation; no trigger is installed.
The seed adds at most two accounts. Existing usernames are left untouched (ON CONFLICT DO NOTHING).
Missing LMS users or an existing different account for the same userid cause a constraint failure; do not bypass it.
If a username already exists, its password is not reset, and the demo password below need not match it.
CREATE TABLE IF NOT EXISTS does not reconcile a pre-existing incompatible table.

| Username | Demo password | Moodle user ID |
|---|---|---|
| `student205` | `YCoJ17Kvk15_ebZt693p` | 205 |
| `teacher102` | `QOavOpXuvLB3rdGP4SQm` | 102 |


These are deliberately documented DEMO credentials, not production secrets. Do not seed them into a production deployment.
Only their BCrypt hashes are in SQL; their plaintext values are not in Java code or Flutter defaults.
No PostgreSQL credentials or Moodle passwords are changed.

## Environment and startup

`application.properties` retains the existing datasource configuration; the only added settings are:

```properties
app.jwt.secret=${JWT_SECRET}
app.jwt.expiration=900
```

Supply `JWT_SECRET` as Base64 of at least 32 cryptographically random bytes. No built-in/default secret exists.
Example for the current PowerShell terminal (does not print the secret or save it to source):

```powershell
$jwtBytes = New-Object byte[] 32
$jwtRng = [System.Security.Cryptography.RandomNumberGenerator]::Create()
$jwtRng.GetBytes($jwtBytes)
$env:JWT_SECRET = [Convert]::ToBase64String($jwtBytes)
$jwtRng.Dispose()
```

Keep a stable secret in your IDE/environment secret configuration if sessions must survive backend restarts.
Generating a new secret invalidates previously issued tokens. Do not commit it.
Retain the same database environment variables/IDE run configuration that already works on your machine.
If PostgreSQL authentication fails, stop and report; do not repair/change passwords or pg_hba.conf.
After manually setting up auth data and environment, start with your working IDE configuration or `./mvnw.cmd spring-boot:run`.

## Flutter session and transitional routes

Entry checks secure storage, then calls `/auth/me` before showing a Home screen.
Only the access token is persisted with `flutter_secure_storage`; no password or user metadata is persisted.
The user and server roles live in `SessionService`. Login has validation, loading and friendly errors.
One role routes directly; multiple roles show only server-granted choices.
Student Home calls `/students/me/dashboard`. Remaining Student/Teacher calls still use existing `/dev` APIs,
but authenticated ApiService instances use the session's LMS user ID for all those calls, never constants 205/102.
Session-less ApiService instances retain explicit development/test defaults for regression only.

ApiService adds Authorization centrally. On 401 it clears the session/token and replaces the root navigator,
removing pushed screens from the previous user. On 403 it preserves the login; the existing section displays a safe error.
Logout deletes the token. Secure-storage removal failure blocks session restore until removal is retried.
Storage operations are serialized so a pending login write cannot restore a token after logout deletes it.
Network/503 errors during restore preserve the stored token and offer retry; they do not enter Home offline.
Android backup is disabled to avoid restoring encrypted token preferences without their device key.
Base URL remains `http://127.0.0.1:8080/api/v1`; device development uses `adb reverse tcp:8080 tcp:8080`.

## Known limitations

* No refresh token, password reset, registration, blacklist, SSO or complete Teacher authorization.
* Logout removes the local token, not a server-side session. A copied token remains usable until expiry unless
  the account/role is disabled or the signing key changes. Signing out does not change the database.
* `/dev` endpoints remain publicly accessible for regression and are NOT protected by the new `/me` policy.
  Therefore this transitional build must not be presented as fully secured or exposed with production data.
* Loopback HTTP is retained for local Android development. A deployment with credentials requires a separate HTTPS setup.
* No login rate limiter/account lockout is introduced in this slice; add it before public exposure.
* Session expiry is detected on restore/API response, not by a background push or refresh timer.
* Auth/profile queries require the manually prepared table and existing academic view. Missing objects produce a safe auth 503.
* Academic selection follows the existing deterministic single-row LEFT JOIN behavior, not a new current-cohort policy.
* Runtime smoke with real database/demo accounts is pending the manual setup; mocked repository tests do not prove live SQL/data.
* Android is the build target verified in this task; iOS/macOS secure-storage entitlements and device behavior need platform validation.

## Tests

Backend compile, then database-independent tests only:

```powershell
.\mvnw.cmd -DskipTests compile
.\mvnw.cmd clean test '-Dtest=AuthenticationApiTest,LearningSupportApiTest,AcademicProfileApiTest,LmsMobileBackendApplicationTests'
```

AuthenticationApiTest uses the real Spring Security filter chain, BCrypt and signed JWTs, with fake persistence;
it does not start Spring Boot datasource auto-configuration or access PostgreSQL.
SchemaVerificationTest and DevStudentControllerTest require a live database and are excluded here.

Flutter checks: `flutter pub get`, `flutter analyze`, `flutter test`, `flutter build apk --debug`.
Tests inject an in-memory TokenStore and MockClient; no real credentials or device secure storage are required.

## Changed files

Verification on 2026-10-08:

* Backend compile: PASS. Selected DB-free suites: 26 tests, 0 failures/errors (14 new auth tests).
* Flutter pub get: PASS; analyze: No issues found; all 169 tests: PASS (20 new auth/session tests).
* Debug APK: PASS, `build/app/outputs/flutter-apk/app-debug.apk`.
* Build emitted SDK XML/Java 8 compatibility warnings; Gradle automatically installed CMake 3.22.1.
  No project SDK/Java version settings were changed.
* Existing datasource configuration lines were verified unchanged. No database connection, setup SQL,
  seed execution or live login smoke was performed.

Backend (paths relative to `lms_mobile_backend`):

* `pom.xml`, `src/main/resources/application.properties` (only JWT settings appended).
* `src/main/java/com/dlu/lmsmobile/auth/`: `AuthController.java`, `AuthService.java`, `AuthRepository.java`,
  `AuthExceptionHandler.java`, `LoginRequest.java`, `LoginResponse.java`, `CurrentUserResponse.java`.
* `src/main/java/com/dlu/lmsmobile/security/`: `SecurityConfig.java`, `JwtService.java`,
  `JwtAuthenticationFilter.java`, `CurrentUser.java`, `ApiSecurityError.java`.
* `src/main/java/com/dlu/lmsmobile/controller/StudentMeController.java`.
* `src/test/java/com/dlu/lmsmobile/AuthenticationApiTest.java`.
* The two `db/auth/` scripts and this document.

Flutter (paths relative to `lms_mobile_app`):

* New: `lib/models/auth_user.dart`, `lib/screens/login_screen.dart`,
  `lib/services/session_service.dart`, `lib/services/token_store.dart`.
* Updated: `lib/main.dart`, `lib/services/api_service.dart`, `lib/core/constants/api_constants.dart`,
  `lib/screens/role_selection_screen.dart`, `lib/screens/student/student_main_screen.dart`,
  `lib/screens/student/student_dashboard_screen.dart`, `lib/screens/teacher/teacher_home_screen.dart`.
* Tests: new `test/authentication_test.dart`, `test/auth_test_support.dart`;
  updated `test/widget_test.dart`, `test/vietnamese_ui_test.dart` to inject test storage/session.
* `pubspec.yaml`, `pubspec.lock`, `android/app/src/main/AndroidManifest.xml` (disable token backup).
* Generated secure-storage registration: `linux/flutter/generated_plugin_registrant.cc`,
  `linux/flutter/generated_plugins.cmake`, `macos/Flutter/GeneratedPluginRegistrant.swift`,
  `windows/flutter/generated_plugin_registrant.cc`, `windows/flutter/generated_plugins.cmake`.

## Future integration

Replace the demo credential verification boundary with a confirmed institution/Moodle/SSO auth contract.
Keep the internal current-user/role response stable; never infer compatibility from Moodle's password column.
Next slice should protect and migrate Student tasks/courses/notifications to current-user routes,
then implement Teacher course-level authorization. Removing public `/dev` access requires a separately reviewed transition.

References: [Spring Security JWT](https://docs.spring.io/spring-security/reference/6.5/servlet/oauth2/resource-server/jwt.html),
[flutter_secure_storage 9.2.4](https://pub.dev/packages/flutter_secure_storage/versions/9.2.4).
