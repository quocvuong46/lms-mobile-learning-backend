package com.dlu.lmsmobile;

import com.dlu.lmsmobile.controller.*;
import com.dlu.lmsmobile.exception.GlobalExceptionHandler;
import com.dlu.lmsmobile.repository.*;
import com.dlu.lmsmobile.service.*;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import java.util.*;
import static org.junit.jupiter.api.Assertions.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

/** Standalone MVC tests: repositories are in-memory fixtures; no context or database starts. */
class LearningSupportApiTest {
    private MockMvc mvc;
    private final List<String> reads = new ArrayList<>();
    private final Map<String, Object> student = new LinkedHashMap<>();
    @BeforeEach void setup() {
        student.put("userid", 205L); student.put("fullname", "Student Demo");
        student.put("attendance", null); student.put("average_grade", 0);
        var students = new StudentRepository(null) {
            @Override public List<Map<String, Object>> findAllTasks(Long userId) {
                reads.add("tasks:" + userId);
                return List.of(Map.of("courseid", 14, "course_name", "Mobile", "task_status", "overdue",
                    "source_status", "draft", "source_id", 14102, "coursemoduleid", 24102,
                    "moodle_path", "/mod/assign/view.php?id=24102"));
            }
            @Override public List<Map<String, Object>> findContinueLearning(Long userId, Long courseId) {
                reads.add("continue:" + userId + ":" + courseId);
                return List.of(Map.of("courseid", courseId == null ? 14 : courseId, "coursemoduleid", 24102));
            }
            @Override public List<Map<String, Object>> findTasksByUserIdAndCourseId(Long userId, Long courseId) {
                reads.add("studentTasks:" + userId + ":" + courseId);
                return List.of(Map.of("task_status", "completed", "source_status", "submitted"));
            }
        };
        var teachers = new TeacherRepository(null) {
            @Override public boolean hasCourse(Long teacherId, Long courseId) { return teacherId == 102 && courseId == 14; }
            @Override public List<Map<String, Object>> findStudents(Long teacherId, Long courseId) { return List.of(student); }
            @Override public List<Map<String, Object>> findActivities(Long teacherId, Long courseId, String type) {
                return List.of(Map.of("source_id", type.equals("assignment") ? 14102 : 14201, "task_type", type));
            }
            @Override public List<Map<String, Object>> findActivityStudents(Long teacherId, Long courseId, String type, Long sourceId) {
                reads.add("activity:" + type + ":" + sourceId);
                return List.of(Map.of("userid", 205, "done", true, "grade_percentage", 0));
            }
        };
        var notifications = new NotificationRepository(null) {
            @Override public List<Map<String, Object>> findByUser(Long userId) {
                reads.add("notifications:" + userId);
                return List.of(Map.of("source_kind", "reminder", "is_read", false));
            }
        };
        mvc = MockMvcBuilders.standaloneSetup(new DevStudentController(new StudentService(students)),
            new TeacherMonitoringController(new TeacherMonitoringService(teachers, students)),
            new NotificationController(new NotificationService(notifications)))
            .setControllerAdvice(new GlobalExceptionHandler()).build();
    }
    @Test void globalTasksPreserveOverdueAndCourseModuleLink() throws Exception {
        mvc.perform(get("/api/v1/dev/students/205/tasks")).andExpect(status().isOk())
            .andExpect(jsonPath("$[0].task_status").value("overdue"))
            .andExpect(jsonPath("$[0].moodle_path").value("/mod/assign/view.php?id=24102"));
        assertEquals(List.of("tasks:205"), reads);
    }
    @Test void courseScopedContinueLearningDoesNotLoseFourthCourse() throws Exception {
        mvc.perform(get("/api/v1/dev/students/205/continue-learning").param("courseId", "3000015"))
            .andExpect(status().isOk()).andExpect(jsonPath("$[0].courseid").value(3000015));
        assertEquals(List.of("continue:205:3000015"), reads);
    }
    @Test void rosterAndDetailPreserveNullAttendanceAndZeroGrade() throws Exception {
        mvc.perform(get("/api/v1/dev/teachers/102/courses/14/students"))
            .andExpect(status().isOk()).andExpect(jsonPath("$[0].average_grade").value(0));
        mvc.perform(get("/api/v1/dev/teachers/102/courses/14/students/205"))
            .andExpect(status().isOk()).andExpect(jsonPath("$.attendance").isEmpty())
            .andExpect(jsonPath("$.tasks[0].source_status").value("submitted"));
        assertEquals(List.of("studentTasks:205:14"), reads);
    }
    @Test void unknownStudentCannotReadOtherStudentTasks() throws Exception {
        mvc.perform(get("/api/v1/dev/teachers/102/courses/14/students/999"))
            .andExpect(status().isNotFound());
        assertTrue(reads.isEmpty());
    }
    @Test void teacherCannotReadUnassignedCourse() throws Exception {
        for (String endpoint : List.of("students", "assignments", "quizzes", "students/205", "assignments/14102/students")) {
            mvc.perform(get("/api/v1/dev/teachers/101/courses/14/" + endpoint)).andExpect(status().isNotFound());
        }
        assertTrue(reads.isEmpty());
    }
    @Test void assignmentAndQuizIdsRemainScopedToActivityType() throws Exception {
        mvc.perform(get("/api/v1/dev/teachers/102/courses/14/assignments/14201/students")).andExpect(status().isNotFound());
        mvc.perform(get("/api/v1/dev/teachers/102/courses/14/assignments/14102/students"))
            .andExpect(status().isOk()).andExpect(jsonPath("$[0].grade_percentage").value(0));
        mvc.perform(get("/api/v1/dev/teachers/102/courses/14/quizzes/14201/students")).andExpect(status().isOk());
        assertEquals(List.of("activity:assignment:14102", "activity:quiz:14201"), reads);
    }
    @Test void notificationsOnlyReadSelectedUserAndRejectMutation() throws Exception {
        mvc.perform(get("/api/v1/dev/students/205/notifications")).andExpect(status().isOk());
        mvc.perform(get("/api/v1/dev/teachers/102/notifications")).andExpect(status().isOk());
        mvc.perform(post("/api/v1/dev/students/205/notifications")).andExpect(status().isMethodNotAllowed());
        assertEquals(List.of("notifications:205", "notifications:102"), reads);
    }
}
