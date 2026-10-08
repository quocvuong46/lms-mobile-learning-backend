package com.dlu.lmsmobile.controller;

import com.dlu.lmsmobile.dto.HealthResponse;
import com.dlu.lmsmobile.service.HealthService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1")
public class HealthController {

    private final HealthService healthService;

    public HealthController(HealthService healthService) {
        this.healthService = healthService;
    }

    @GetMapping("/health")
    public HealthResponse getHealth() {
        return healthService.checkHealth();
    }
}
