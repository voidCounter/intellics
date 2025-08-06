package org.intellics.backend.security;

import org.intellics.backend.domain.entities.Role;
import org.intellics.backend.domain.entities.User;
import org.intellics.backend.domain.enums.RoleName;
import org.intellics.backend.repository.RoleRepository;
import org.intellics.backend.repository.UserRepository;
import org.springframework.security.oauth2.client.oidc.userinfo.OidcUserRequest;
import org.springframework.security.oauth2.client.oidc.userinfo.OidcUserService;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.oidc.user.OidcUser;
import org.springframework.stereotype.Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.HashSet;
import java.util.Optional;
import java.util.Set;

@Service
public class CustomOAuth2UserService extends OidcUserService {

    private static final Logger logger = LoggerFactory.getLogger(CustomOAuth2UserService.class);
    
    // ThreadLocal to store the user_id temporarily during OAuth flow
    private static final ThreadLocal<String> currentUserId = new ThreadLocal<>();

    private final UserRepository userRepository;
    private final RoleRepository roleRepository;

    public CustomOAuth2UserService(UserRepository userRepository, RoleRepository roleRepository) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
    }

    @Override
    public OidcUser loadUser(OidcUserRequest userRequest) throws OAuth2AuthenticationException {
        logger.info("Loading OIDC user for client registration: {}", userRequest.getClientRegistration().getRegistrationId());
        OidcUser oidcUser = super.loadUser(userRequest);

        logger.info("OidcUser attributes: {}", oidcUser.getAttributes());

        String googleId = oidcUser.getAttribute("sub");
        String email = oidcUser.getAttribute("email");
        String name = oidcUser.getAttribute("name");
        String imageUrl = oidcUser.getAttribute("picture");

        logger.info("Extracted attributes - googleId: {}, email: {}, name: {}, imageUrl: {}", googleId, email, name, imageUrl);

        Optional<User> userOptional = userRepository.findByGoogleId(googleId);

        User user;
        if (userOptional.isPresent()) {
            user = userOptional.get();
            logger.info("Existing user found: {}", user.getUser_id());
            updateUser(user, oidcUser);
        } else {
            logger.info("No existing user found. Creating new user.");
            user = createUser(oidcUser);
        }

        logger.info("User processed: {}", user.getUser_id());
        
        // Store the user_id in ThreadLocal for the success handler to access
        currentUserId.set(user.getUser_id().toString());
        
        return oidcUser;
    }

    private User createUser(OidcUser oidcUser) {
        User user = new User();
        user.setUser_id(java.util.UUID.randomUUID());
        user.setGoogleId(oidcUser.getAttribute("sub"));
        user.setUsername(oidcUser.getAttribute("name"));
        user.setEmail(oidcUser.getAttribute("email"));
        user.setImageUrl(oidcUser.getAttribute("picture"));

        Set<Role> roles = new HashSet<>();
        roleRepository.findByName(RoleName.ROLE_USER).ifPresent(roles::add);
        user.setRoles(roles);

        logger.info("Attempting to save new user with googleId: {}", user.getGoogleId());
        User savedUser = userRepository.save(user);
        logger.info("New user saved with id: {}", savedUser.getUser_id());
        return savedUser;
    }

    private void updateUser(User user, OidcUser oidcUser) {
        user.setUsername(oidcUser.getAttribute("name"));
        user.setEmail(oidcUser.getAttribute("email"));
        user.setImageUrl(oidcUser.getAttribute("picture"));
        logger.info("Attempting to update user with id: {}", user.getUser_id());
        userRepository.save(user);
        logger.info("User updated with id: {}", user.getUser_id());
    }
    
    // Static method to get the current user_id from ThreadLocal
    public static String getCurrentUserId() {
        String userId = currentUserId.get();
        currentUserId.remove(); // Clean up after use
        return userId;
    }
}