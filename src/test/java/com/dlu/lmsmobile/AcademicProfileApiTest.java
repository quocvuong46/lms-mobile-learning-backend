package com.dlu.lmsmobile;

import com.dlu.lmsmobile.controller.DevStudentController;
import com.dlu.lmsmobile.controller.TeacherMonitoringController;
import com.dlu.lmsmobile.repository.StudentRepository;
import com.dlu.lmsmobile.repository.TeacherRepository;
import com.dlu.lmsmobile.service.StudentService;
import com.dlu.lmsmobile.service.TeacherMonitoringService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import java.util.*;
import static org.junit.jupiter.api.Assertions.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

/** Real controller/service/repository wiring with mocked JDBC: never starts a database. */
class AcademicProfileApiTest {
    private JdbcTemplate jdbc;
    private MockMvc mvc;
    private final List<String> queries = new ArrayList<>();
    private final List<List<Object>> parameters = new ArrayList<>();
    private Map<String, Object> row;

    @BeforeEach void setup() {
        row = new LinkedHashMap<>();
        row.put("userid", 207L); row.put("courseid", 13L); row.put("fullname", "Bui Khanh");
        row.put("email", "student07@example.edu.vn"); row.put("student_code", "2412007");
        row.put("cohort_code", "K48"); row.put("class_code", "CTK48A"); row.put("major_name", "Công nghệ thông tin");
        row.put("progress", 28.57); row.put("pending_tasks", 4); row.put("overdue_tasks", 3);
        row.put("attendance", null); row.put("average_grade", 0); row.put("days_since_last_activity", 32);
        row.put("risk_level", "HIGH"); row.put("needs_attention", true);
        jdbc = new JdbcTemplate() {
            @Override public <T> T queryForObject(String sql, Class<T> type, Object... args) {
                assertEquals(List.of(102L, 13L), Arrays.asList(args));
                return type.cast(Boolean.TRUE);
            }
            @Override public List<Map<String, Object>> queryForList(String sql, Object... args) {
                queries.add(sql);
                parameters.add(Arrays.asList(args));
                if (sql.contains("FROM derived.unified_tasks")) {
                    return List.of(Map.of("source_id", 100L, "task_status", "pending", "moodle_path", "/mod/assign/view.php?id=200"));
                }
                return List.of(row);
            }
        };
        var students = new StudentRepository(jdbc);
        var teachers = new TeacherRepository(jdbc);
        mvc = MockMvcBuilders.standaloneSetup(
            new TeacherMonitoringController(new TeacherMonitoringService(teachers, students)),
            new DevStudentController(new StudentService(students))).build();
    }

    @Test void rosterAddsAcademicFieldsAndKeepsExistingContract() throws Exception {
        mvc.perform(get("/api/v1/dev/teachers/102/courses/13/students"))
            .andExpect(status().isOk()).andExpect(jsonPath("$.length()").value(1))
            .andExpect(jsonPath("$[0].student_code").value("2412007"))
            .andExpect(jsonPath("$[0].cohort_code").value("K48"))
            .andExpect(jsonPath("$[0].class_code").value("CTK48A"))
            .andExpect(jsonPath("$[0].major_name").value("Công nghệ thông tin"))
            .andExpect(jsonPath("$[0].progress").value(28.57))
            .andExpect(jsonPath("$[0].pending_tasks").value(4))
            .andExpect(jsonPath("$[0].overdue_tasks").value(3))
            .andExpect(jsonPath("$[0].risk_level").value("HIGH"))
            .andExpect(jsonPath("$[0].needs_attention").value(true));
        assertEquals(List.of(102L, 13L), parameters.getFirst());
        assertOptionalSingleProfileJoin(queries.getFirst());
    }

    @Test void detailJoinsProfileOnceAndKeepsTasksZeroGradeAndNullAttendance() throws Exception {
        mvc.perform(get("/api/v1/dev/teachers/102/courses/13/students/207"))
            .andExpect(status().isOk()).andExpect(jsonPath("$.cohort_code").value("K48"))
            .andExpect(jsonPath("$.class_code").value("CTK48A"))
            .andExpect(jsonPath("$.major_name").value("Công nghệ thông tin"))
            .andExpect(jsonPath("$.average_grade").value(0))
            .andExpect(jsonPath("$.attendance").isEmpty())
            .andExpect(jsonPath("$.days_since_last_activity").value(32))
            .andExpect(jsonPath("$.tasks[0].task_status").value("pending"));
        assertEquals(1, queries.stream().filter(q -> q.contains("student_academic_profile")).count());
    }

    @Test void missingProfileStillReturnsRosterAndDetailWithNullableKeys() throws Exception {
        for (String key : List.of("student_code", "cohort_code", "class_code", "major_name")) row.put(key, null);
        mvc.perform(get("/api/v1/dev/teachers/102/courses/13/students"))
            .andExpect(status().isOk()).andExpect(jsonPath("$[0].userid").value(207))
            .andExpect(jsonPath("$[0]", org.hamcrest.Matchers.hasKey("cohort_code")))
            .andExpect(jsonPath("$[0].cohort_code").isEmpty());
        mvc.perform(get("/api/v1/dev/teachers/102/courses/13/students/207"))
            .andExpect(status().isOk()).andExpect(jsonPath("$.student_code").isEmpty())
            .andExpect(jsonPath("$.class_code").isEmpty()).andExpect(jsonPath("$.major_name").isEmpty())
            .andExpect(jsonPath("$.tasks[0].task_status").value("pending"));
    }

    @Test void dashboardUsesExistingEndpointAndOptionalProfile() throws Exception {
        mvc.perform(get("/api/v1/dev/students/207/dashboard"))
            .andExpect(status().isOk()).andExpect(jsonPath("$.student_code").value("2412007"))
            .andExpect(jsonPath("$.cohort_code").value("K48"))
            .andExpect(jsonPath("$.class_code").value("CTK48A"))
            .andExpect(jsonPath("$.major_name").value("Công nghệ thông tin"));
        assertOptionalSingleProfileJoin(queries.getFirst());
        for (String key : List.of("student_code", "cohort_code", "class_code", "major_name")) row.put(key, null);
        mvc.perform(get("/api/v1/dev/students/207/dashboard"))
            .andExpect(status().isOk()).andExpect(jsonPath("$.cohort_code").isEmpty());
    }

    private void assertOptionalSingleProfileJoin(String sql) {
        assertTrue(sql.contains("LEFT JOIN LATERAL"));
        assertTrue(sql.contains("FROM derived.student_academic_profile"));
        assertTrue(sql.contains("LIMIT 1")); // Academic memberships cannot multiply roster rows.
        assertFalse(sql.contains("K48"));
    }
}
