package com.dlu.lmsmobile.controller;

import com.dlu.lmsmobile.service.FlashcardService;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * Flashcards for the demo flow. Like the other /dev student routes, the path user id stands in
 * for the signed-in student; every query is scoped to it. The JWT-based
 * /courses/{courseId}/flashcards routes in {@link FlashcardController} are left unchanged.
 */
@RestController
@RequestMapping("/api/v1/dev/students/{userId}/courses/{courseId}/flashcards")
public class DevFlashcardController {
    private final FlashcardService service;

    public DevFlashcardController(FlashcardService service) {
        this.service = service;
    }

    @GetMapping
    public List<Map<String, Object>> getFlashcards(@PathVariable Long userId, @PathVariable Long courseId) {
        return service.getFlashcards(courseId, userId);
    }

    @PostMapping
    public Map<String, String> addFlashcard(
            @PathVariable Long userId, @PathVariable Long courseId, @RequestBody Map<String, Object> payload) {
        service.addFlashcard(courseId, userId, payload);
        return Map.of("status", "success");
    }

    @PutMapping("/{id}")
    public Map<String, String> updateFlashcard(
            @PathVariable Long userId, @PathVariable Long courseId, @PathVariable Long id,
            @RequestBody Map<String, Object> payload) {
        service.updateFlashcard(id, userId, payload);
        return Map.of("status", "success");
    }

    @DeleteMapping("/{id}")
    public Map<String, String> deleteFlashcard(
            @PathVariable Long userId, @PathVariable Long courseId, @PathVariable Long id) {
        service.deleteFlashcard(id, userId);
        return Map.of("status", "success");
    }
}
