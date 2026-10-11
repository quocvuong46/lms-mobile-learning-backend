package com.dlu.lmsmobile.controller;

import com.dlu.lmsmobile.service.FlashcardService;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/v1/courses/{courseId}/flashcards")
@CrossOrigin(origins = "*")
public class FlashcardController {
    private final FlashcardService service;

    public FlashcardController(FlashcardService service) {
        this.service = service;
    }

    @GetMapping
    @PreAuthorize("hasRole('STUDENT')")
    public List<Map<String, Object>> getFlashcards(
            @PathVariable Long courseId,
            @AuthenticationPrincipal Long userId) {
        return service.getFlashcards(courseId, userId);
    }

    @PostMapping
    @PreAuthorize("hasRole('STUDENT')")
    public Map<String, String> addFlashcard(
            @PathVariable Long courseId,
            @AuthenticationPrincipal Long userId,
            @RequestBody Map<String, Object> payload) {
        service.addFlashcard(courseId, userId, payload);
        return Map.of("status", "success");
    }

    @PutMapping("/{id}")
    @PreAuthorize("hasRole('STUDENT')")
    public Map<String, String> updateFlashcard(
            @PathVariable Long courseId,
            @PathVariable Long id,
            @AuthenticationPrincipal Long userId,
            @RequestBody Map<String, Object> payload) {
        service.updateFlashcard(id, userId, payload);
        return Map.of("status", "success");
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('STUDENT')")
    public Map<String, String> deleteFlashcard(
            @PathVariable Long courseId,
            @PathVariable Long id,
            @AuthenticationPrincipal Long userId) {
        service.deleteFlashcard(id, userId);
        return Map.of("status", "success");
    }
}
