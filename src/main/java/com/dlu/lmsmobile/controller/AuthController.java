package com.dlu.lmsmobile.controller;

import com.dlu.lmsmobile.security.JwtTokenProvider;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/v1/auth")
@CrossOrigin(origins = "*")
public class AuthController {

    private final JwtTokenProvider tokenProvider;

    public AuthController(JwtTokenProvider tokenProvider) {
        this.tokenProvider = tokenProvider;
    }

    @PostMapping("/demo-login")
    public Map<String, String> demoLogin(@RequestBody Map<String, String> payload) {
        String role = payload.getOrDefault("role", "STUDENT").toUpperCase();
        
        Long userId;
        if ("TEACHER".equals(role)) {
            userId = 102L;
        } else {
            userId = 205L;
        }

        String token = tokenProvider.generateToken(userId, role);
        return Map.of(
                "token", token,
                "role", role,
                "userId", userId.toString()
        );
    }
}
