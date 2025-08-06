package org.intellics.backend.security;

import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.MalformedJwtException;
import io.jsonwebtoken.UnsupportedJwtException;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;

import java.nio.charset.StandardCharsets;
import java.time.Instant;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class JwtTokenProvider {

    private static final Logger logger = LoggerFactory.getLogger(JwtTokenProvider.class);

    @Value("${app.jwtSecret}")
    private String jwtSecret;

    @Value("${app.jwtExpirationInMs}")
    private int jwtExpirationInMs;

    public String generateToken(String userId) {
        Map<String, Object> claims = new HashMap<>();
        claims.put("user_id", userId);

        logger.info("Generating JWT token for user: {}", userId);
        logger.info("Using JWT secret: {}", jwtSecret.substring(0, Math.min(20, jwtSecret.length())) + "...");

        return Jwts.builder()
            .claims(claims)
                .subject(userId)
                .issuedAt(Date.from(Instant.now()))
                .expiration(Date.from(Instant.now().plusMillis(jwtExpirationInMs)))
                .signWith(key())
                .compact();
    }

    private javax.crypto.SecretKey key() {
        return Keys.hmacShaKeyFor(Decoders.BASE64.decode(jwtSecret));
    }

   public String getUserIdFromJWT(String token) {
       return Jwts.parser().verifyWith(key()).build().parseSignedClaims(token).getPayload().getSubject();
   }

    public boolean validateToken(String authToken) {
        try {
            logger.info("Validating JWT token: {}", authToken.substring(0, Math.min(50, authToken.length())) + "...");
            logger.info("Using JWT secret for validation: {}", jwtSecret.substring(0, Math.min(20, jwtSecret.length())) + "...");
            Jwts.parser().verifyWith(key()).build().parseSignedClaims(authToken);
            logger.info("JWT token validation successful");
            return true;
        } catch (MalformedJwtException ex) {
            logger.error("Invalid JWT token: {}", ex.getMessage());
        } catch (ExpiredJwtException ex) {
            logger.error("Expired JWT token: {}", ex.getMessage());
        } catch (UnsupportedJwtException ex) {
            logger.error("Unsupported JWT token: {}", ex.getMessage());
        } catch (IllegalArgumentException ex) {
            logger.error("JWT claims string is empty: {}", ex.getMessage());
        } catch (Exception ex) {
            logger.error("Unexpected error validating JWT: {}", ex.getMessage());
        }
        return false;
    }
}