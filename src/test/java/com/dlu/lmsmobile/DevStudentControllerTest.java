package com.dlu.lmsmobile;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
@AutoConfigureMockMvc
class DevStudentControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Test
    void getLearningItems_Returns200() throws Exception {
        mockMvc.perform(get("/api/v1/dev/students/2/courses/10/learning-items")
                        .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk());
    }

    @Test
    void getGrades_Returns200() throws Exception {
        mockMvc.perform(get("/api/v1/dev/students/2/courses/10/grades")
                        .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk());
    }

    @Test
    void getGradeCategories_Returns200() throws Exception {
        mockMvc.perform(get("/api/v1/dev/students/2/courses/10/grade-categories")
                        .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk());
    }

    @Test
    void getAttendance_Returns200() throws Exception {
        mockMvc.perform(get("/api/v1/dev/students/2/courses/10/attendance")
                        .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk());
    }

    @Test
    void getTasks_Returns200() throws Exception {
        mockMvc.perform(get("/api/v1/dev/students/2/courses/10/tasks")
                        .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk());
    }
}
