package com.dlu.lmsmobile.controller;

import com.dlu.lmsmobile.service.ReflectionService;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/v1/students/me/reflections")
@CrossOrigin(origins = "*")
public class ReflectionController {
    private final ReflectionService service;

    public ReflectionController(ReflectionService service) {
        this.service = service;
    }

    @GetMapping
    @PreAuthorize("hasRole('STUDENT')")
    public List<Map<String, Object>> getReflections(
            @AuthenticationPrincipal Long userId,
            @RequestParam(required = false) Long courseId) {
        return service.getReflections(userId, courseId);
    }

    @PostMapping
    @PreAuthorize("hasRole('STUDENT')")
    public Map<String, String> addReflection(
            @AuthenticationPrincipal Long userId,
            @RequestBody Map<String, Object> payload) {
        service.addReflection(userId, payload);
        return Map.of("status", "success");
    }
}
