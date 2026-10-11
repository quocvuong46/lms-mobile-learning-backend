package com.dlu.lmsmobile.service;

import com.dlu.lmsmobile.exception.InvalidRequestException;
import com.dlu.lmsmobile.exception.ResourceNotFoundException;
import com.dlu.lmsmobile.repository.FlashcardRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class FlashcardService {
    private final FlashcardRepository repository;

    public FlashcardService(FlashcardRepository repository) {
        this.repository = repository;
    }

    public List<Map<String, Object>> getFlashcards(Long courseId, Long userId) {
        return repository.findByCourseIdAndUserId(courseId, userId);
    }

    public void addFlashcard(Long courseId, Long userId, Map<String, Object> payload) {
        repository.save(courseId, userId, text(payload, "frontText"), text(payload, "backText"));
    }

    public void updateFlashcard(Long id, Long userId, Map<String, Object> payload) {
        int rows = repository.update(id, userId, text(payload, "frontText"), text(payload, "backText"));
        if (rows == 0) throw new ResourceNotFoundException("Flashcard not found or access denied");
    }

    public void deleteFlashcard(Long id, Long userId) {
        int rows = repository.delete(id, userId);
        if (rows == 0) throw new ResourceNotFoundException("Flashcard not found or access denied");
    }

    private static String text(Map<String, Object> payload, String key) {
        if (!(payload.get(key) instanceof String value) || value.isBlank()) {
            throw new InvalidRequestException("Thiếu nội dung thẻ: " + key);
        }
        return value.trim();
    }
}
