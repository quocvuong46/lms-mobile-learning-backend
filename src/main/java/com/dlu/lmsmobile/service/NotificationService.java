package com.dlu.lmsmobile.service;
import com.dlu.lmsmobile.repository.NotificationRepository;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Map;
@Service
public class NotificationService {
    private final NotificationRepository repository;
    public NotificationService(NotificationRepository repository) { this.repository = repository; }
    public List<Map<String, Object>> findByUser(Long userId, String role) { return repository.findByUser(userId, role); }
}
