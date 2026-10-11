package com.dlu.lmsmobile.controller;

import com.dlu.lmsmobile.service.ReflectionService;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * Learning reflections for the demo flow. Like the other /dev student routes, the path user id
 * stands in for the signed-in student; every query is scoped to it. The JWT-based
 * /students/me/reflections route in {@link ReflectionController} is left unchanged.
 */
@RestController
@RequestMapping("/api/v1/dev/students/{userId}/reflections")
public class DevReflectionController {
    private final ReflectionService service;

    public DevReflectionController(ReflectionService service) {
        this.service = service;
    }

    @GetMapping
    public List<Map<String, Object>> getReflections(
            @PathVariable Long userId,
            @RequestParam(required = false) Long courseId) {
        return service.getReflections(userId, courseId);
    }

    @PostMapping
    public Map<String, String> addReflection(
            @PathVariable Long userId,
            @RequestBody Map<String, Object> payload) {
        service.addReflection(userId, payload);
        return Map.of("status", "success");
    }
}
