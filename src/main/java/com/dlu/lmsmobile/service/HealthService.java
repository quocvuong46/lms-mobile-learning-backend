package com.dlu.lmsmobile.service;

import com.dlu.lmsmobile.dto.HealthResponse;
import com.dlu.lmsmobile.repository.HealthRepository;
import org.springframework.stereotype.Service;

@Service
public class HealthService {

    private final HealthRepository healthRepository;

    public HealthService(HealthRepository healthRepository) {
        this.healthRepository = healthRepository;
    }

    public HealthResponse checkHealth() {
        boolean isConnected = healthRepository.isDatabaseConnected();
        String dbStatus = isConnected ? "CONNECTED" : "DISCONNECTED";
        String status = isConnected ? "UP" : "DOWN";
        return new HealthResponse(status, dbStatus);
    }
}
