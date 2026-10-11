package com.dlu.lmsmobile.security;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTVerificationException;
import com.auth0.jwt.interfaces.DecodedJWT;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.util.Date;

@Component
public class JwtTokenProvider {

    // Trong môi trường production không được hardcode secret key ở đây. Tạm thời dùng giá trị default để demo.
    @Value("${app.jwt.secret:defaultSecretKeyForLmsMobileApp123456}")
    private String jwtSecret;

    @Value("${app.jwt.expirationMs:86400000}")
    private long jwtExpirationMs;

    public String generateToken(Long userId, String role) {
        return JWT.create()
                .withSubject(userId.toString())
                .withClaim("role", role)
                .withIssuedAt(new Date())
                .withExpiresAt(new Date(System.currentTimeMillis() + jwtExpirationMs))
                .sign(Algorithm.HMAC256(jwtSecret));
    }

    public DecodedJWT validateToken(String token) {
        try {
            return JWT.require(Algorithm.HMAC256(jwtSecret))
                    .build()
                    .verify(token);
        } catch (JWTVerificationException ex) {
            return null;
        }
    }
}
