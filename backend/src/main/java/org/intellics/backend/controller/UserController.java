package org.intellics.backend.controller;

import org.intellics.backend.domain.entities.User;
import org.intellics.backend.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/users")
public class UserController {

    @Autowired
    private UserRepository userRepository;

    @GetMapping("/me")
    public ResponseEntity<User> getCurrentUser(Authentication authentication) {
        try {
            // Extract the user ID from the authentication principal
            String userId = authentication.getName();
            User user = userRepository.findById(java.util.UUID.fromString(userId)).orElse(null);
            if (user == null) {
                return ResponseEntity.status(404).build();
            }
            return ResponseEntity.ok(user);
        } catch (Exception e) {
            return ResponseEntity.status(401).build();
        }
    }
} 