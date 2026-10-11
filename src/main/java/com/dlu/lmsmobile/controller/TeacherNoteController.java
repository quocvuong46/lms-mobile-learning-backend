package com.dlu.lmsmobile.controller;

import com.dlu.lmsmobile.service.TeacherNoteService;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/v1/teachers/{teacherId}/notes")
@CrossOrigin(origins = "*")
public class TeacherNoteController {
    private final TeacherNoteService service;

    public TeacherNoteController(TeacherNoteService service) {
        this.service = service;
    }

    @GetMapping
    public List<Map<String, Object>> getNotes(
            @PathVariable Long teacherId,
            @RequestParam(required = false) Long courseId,
            @RequestParam(required = false) Long studentId) {
        return service.getNotes(teacherId, courseId, studentId);
    }

    @PostMapping
    public Map<String, String> addNote(
            @PathVariable Long teacherId,
            @RequestBody Map<String, Object> payload) {
        service.addNote(teacherId, payload);
        return Map.of("status", "success");
    }

    @PutMapping("/{id}/status")
    public Map<String, String> updateNoteStatus(
            @PathVariable Long teacherId,
            @PathVariable Long id,
            @RequestBody Map<String, String> payload) {
        service.updateStatus(id, teacherId, payload.get("status"));
        return Map.of("status", "success");
    }
}
