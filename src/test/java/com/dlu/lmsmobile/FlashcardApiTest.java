package com.dlu.lmsmobile;

import com.dlu.lmsmobile.controller.DevFlashcardController;
import com.dlu.lmsmobile.exception.GlobalExceptionHandler;
import com.dlu.lmsmobile.repository.FlashcardRepository;
import com.dlu.lmsmobile.service.FlashcardService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import java.util.*;

import static org.hamcrest.Matchers.hasSize;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

/** Standalone MVC tests for /api/v1/dev/students/{userId}/courses/{courseId}/flashcards. */
class FlashcardApiTest {
    private final List<Map<String, Object>> rows = new ArrayList<>();
    private MockMvc mvc;

    @BeforeEach
    void setup() {
        var repo = new FlashcardRepository(null) {
            @Override
            public List<Map<String, Object>> findByCourseIdAndUserId(Long courseId, Long userId) {
                return rows.stream().filter(r -> courseId.equals(r.get("course_id")) && userId.equals(r.get("userid"))).toList();
            }

            @Override
            public void save(Long courseId, Long userId, String front, String back) {
                rows.add(new HashMap<>(Map.of("id", (long) rows.size() + 1, "course_id", courseId,
                    "userid", userId, "front_text", front, "back_text", back)));
            }

            @Override
            public int update(Long id, Long userId, String front, String back) {
                for (Map<String, Object> r : rows) {
                    if (id.equals(r.get("id")) && userId.equals(r.get("userid"))) {
                        r.put("front_text", front);
                        r.put("back_text", back);
                        return 1;
                    }
                }
                return 0;
            }

            @Override
            public int delete(Long id, Long userId) {
                return rows.removeIf(r -> id.equals(r.get("id")) && userId.equals(r.get("userid"))) ? 1 : 0;
            }
        };
        mvc = MockMvcBuilders.standaloneSetup(new DevFlashcardController(new FlashcardService(repo)))
            .setControllerAdvice(new GlobalExceptionHandler()).build();
    }

    private static final String BASE = "/api/v1/dev/students/205/courses/14/flashcards";

    @Test
    void emptyThenAddedCardIsListedForOwnerOnly() throws Exception {
        mvc.perform(get(BASE)).andExpect(status().isOk()).andExpect(jsonPath("$", hasSize(0)));
        mvc.perform(post(BASE).contentType(MediaType.APPLICATION_JSON)
                .content("{\"frontText\":\" Q \",\"backText\":\"A\"}"))
            .andExpect(status().isOk()).andExpect(jsonPath("$.status").value("success"));
        mvc.perform(get(BASE)).andExpect(jsonPath("$", hasSize(1)))
            .andExpect(jsonPath("$[0].front_text").value("Q"));
        mvc.perform(get("/api/v1/dev/students/206/courses/14/flashcards")).andExpect(jsonPath("$", hasSize(0)));
    }

    @Test
    void blankOrMissingTextIsRejected() throws Exception {
        for (String body : new String[] {"{\"frontText\":\"Q\"}", "{\"frontText\":\" \",\"backText\":\"A\"}", "{}"}) {
            mvc.perform(post(BASE).contentType(MediaType.APPLICATION_JSON).content(body))
                .andExpect(status().isBadRequest());
        }
        assertEquals(0, rows.size());
    }

    @Test
    void updateAndDeleteAreScopedToOwner() throws Exception {
        mvc.perform(post(BASE).contentType(MediaType.APPLICATION_JSON).content("{\"frontText\":\"Q\",\"backText\":\"A\"}"));
        mvc.perform(put("/api/v1/dev/students/206/courses/14/flashcards/1").contentType(MediaType.APPLICATION_JSON)
                .content("{\"frontText\":\"X\",\"backText\":\"Y\"}")).andExpect(status().isNotFound());
        mvc.perform(put(BASE + "/1").contentType(MediaType.APPLICATION_JSON)
                .content("{\"frontText\":\"X\",\"backText\":\"Y\"}")).andExpect(status().isOk());
        assertEquals("X", rows.get(0).get("front_text"));
        mvc.perform(delete("/api/v1/dev/students/206/courses/14/flashcards/1")).andExpect(status().isNotFound());
        mvc.perform(delete(BASE + "/1")).andExpect(status().isOk());
        assertEquals(0, rows.size());
    }
}
