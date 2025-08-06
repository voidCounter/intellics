package org.intellics.backend.security;

import org.intellics.backend.domain.entities.User;
import org.intellics.backend.repository.UserRepository;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.UUID;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    private final UserRepository userRepository;

    public CustomUserDetailsService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    public UserDetails loadUserByUsername(String userId) throws UsernameNotFoundException {
        return loadUserById(userId);
    }

    public UserDetails loadUserById(String userId) throws UsernameNotFoundException {
        User user = userRepository.findById(UUID.fromString(userId))
                .orElseThrow(() -> new UsernameNotFoundException("User not found with id : " + userId));
        
        // For simplicity, we are not assigning any roles/authorities here.
        // In a real application, you would load user roles from the database.
        return new org.springframework.security.core.userdetails.User(user.getUser_id().toString(), "", new ArrayList<>());
    }
}
