package com.dlu.lmsmobile.service;

import com.dlu.lmsmobile.exception.InvalidRequestException;
import com.dlu.lmsmobile.repository.ReflectionRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class ReflectionService {
    private final ReflectionRepository repository;

    public ReflectionService(ReflectionRepository repository) {
        this.repository = repository;
    }

    public List<Map<String, Object>> getReflections(Long userId, Long courseId) {
        return repository.findByUserId(userId, courseId);
    }

    public void addReflection(Long userId, Map<String, Object> payload) {
        if (!(payload.get("content") instanceof String content) || content.isBlank()) {
            throw new InvalidRequestException("Nội dung nhật ký không được để trống");
        }
        Long courseId = payload.get("courseId") instanceof Number n ? n.longValue() : null;
        Integer understandingLevel = payload.get("understandingLevel") instanceof Number n ? n.intValue() : null;
        if (understandingLevel != null && (understandingLevel < 1 || understandingLevel > 5)) {
            throw new InvalidRequestException("Mức độ hiểu bài phải từ 1 đến 5");
        }
        repository.save(userId, courseId, content.trim(), understandingLevel);
    }
}
