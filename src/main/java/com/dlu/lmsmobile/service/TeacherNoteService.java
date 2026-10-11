package com.dlu.lmsmobile.service;

import com.dlu.lmsmobile.repository.TeacherNoteRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class TeacherNoteService {
    private final TeacherNoteRepository repository;

    public TeacherNoteService(TeacherNoteRepository repository) {
        this.repository = repository;
    }

    public List<Map<String, Object>> getNotes(Long teacherId, Long courseId, Long studentId) {
        return repository.findByTeacherId(teacherId, courseId, studentId);
    }

    public void addNote(Long teacherId, Map<String, Object> payload) {
        Long studentId = ((Number) payload.get("studentId")).longValue();
        Long courseId = payload.get("courseId") != null ? ((Number) payload.get("courseId")).longValue() : null;
        String note = (String) payload.get("note");
        String status = (String) payload.get("status");
        repository.save(teacherId, studentId, courseId, note, status);
    }

    public void updateStatus(Long id, Long teacherId, String status) {
        int rows = repository.updateStatus(id, teacherId, status);
        if (rows == 0) throw new IllegalArgumentException("Note not found or access denied");
    }
}
