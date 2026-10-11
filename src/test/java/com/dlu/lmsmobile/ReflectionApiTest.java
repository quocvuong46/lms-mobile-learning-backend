package com.dlu.lmsmobile;

import com.dlu.lmsmobile.controller.DevReflectionController;
import com.dlu.lmsmobile.exception.GlobalExceptionHandler;
import com.dlu.lmsmobile.repository.ReflectionRepository;
import com.dlu.lmsmobile.service.ReflectionService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import java.util.*;

import static org.hamcrest.Matchers.hasSize;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

/** Standalone MVC tests for /api/v1/dev/students/{userId}/reflections; no database is used. */
class ReflectionApiTest {
    private final List<Map<String, Object>> rows = new ArrayList<>();
    private MockMvc mvc;

    @BeforeEach
    void setup() {
        var repo = new ReflectionRepository(null) {
            @Override
            public List<Map<String, Object>> findByUserId(Long userId, Long courseId) {
                return rows.stream()
                    .filter(r -> userId.equals(r.get("user_id")))
                    .filter(r -> courseId == null || courseId.equals(r.get("course_id")))
                    .toList();
            }

            @Override
            public void save(Long userId, Long courseId, String content, Integer level) {
                Map<String, Object> row = new HashMap<>();
                row.put("user_id", userId);
                row.put("course_id", courseId);
                row.put("content", content);
                row.put("understanding_level", level);
                rows.add(row);
            }
        };
        mvc = MockMvcBuilders.standaloneSetup(new DevReflectionController(new ReflectionService(repo)))
            .setControllerAdvice(new GlobalExceptionHandler()).build();
    }

    private Map<String, Object> row(long user, Long course, int level) {
        Map<String, Object> r = new HashMap<>();
        r.put("user_id", user);
        r.put("course_id", course);
        r.put("content", "nội dung");
        r.put("understanding_level", level);
        return r;
    }

    @Test
    void returnsOnlyTheStudentsReflectionsAndFiltersByCourse() throws Exception {
        rows.add(row(205, 14L, 2));
        rows.add(row(205, null, 4));
        rows.add(row(206, 14L, 1));
        mvc.perform(get("/api/v1/dev/students/205/reflections")).andExpect(status().isOk())
            .andExpect(jsonPath("$", hasSize(2)));
        mvc.perform(get("/api/v1/dev/students/205/reflections").param("courseId", "14")).andExpect(status().isOk())
            .andExpect(jsonPath("$", hasSize(1)))
            .andExpect(jsonPath("$[0].understanding_level").value(2));
    }

    @Test
    void emptyListIsReturnedAsEmptyArray() throws Exception {
        mvc.perform(get("/api/v1/dev/students/205/reflections")).andExpect(status().isOk())
            .andExpect(jsonPath("$", hasSize(0)));
    }

    @Test
    void nullableColumnsAreSerialisedAsNull() throws Exception {
        Map<String, Object> r = row(205, null, 3);
        r.put("understanding_level", null);
        rows.add(r);
        mvc.perform(get("/api/v1/dev/students/205/reflections")).andExpect(status().isOk())
            .andExpect(jsonPath("$[0].course_id").value((Object) null))
            .andExpect(jsonPath("$[0].understanding_level").value((Object) null));
    }

    @Test
    void addStoresReflectionForPathStudent() throws Exception {
        mvc.perform(post("/api/v1/dev/students/205/reflections").contentType(MediaType.APPLICATION_JSON)
                .content("{\"content\":\"  Đã hiểu  \",\"understandingLevel\":4,\"courseId\":14}"))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$.status").value("success"));
        assertEquals(1, rows.size());
        assertEquals(205L, rows.get(0).get("user_id"));
        assertEquals(14L, rows.get(0).get("course_id"));
        assertEquals("Đã hiểu", rows.get(0).get("content"));
        assertEquals(4, rows.get(0).get("understanding_level"));
    }

    @Test
    void invalidPayloadsAreRejectedWithoutWriting() throws Exception {
        String[] bodies = {
            "{\"understandingLevel\":3}",
            "{\"content\":\"   \",\"understandingLevel\":3}",
            "{\"content\":123,\"understandingLevel\":3}",
            "{\"content\":\"x\",\"understandingLevel\":9}",
            "{\"content\":\"x\",\"understandingLevel\":0}"
        };
        for (String body : bodies) {
            mvc.perform(post("/api/v1/dev/students/205/reflections").contentType(MediaType.APPLICATION_JSON)
                    .content(body))
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.message").isNotEmpty());
        }
        assertTrue(rows.isEmpty());
    }
}
