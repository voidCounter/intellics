package org.intellics.backend.config;

import org.intellics.backend.domain.entities.Role;
import org.intellics.backend.domain.enums.RoleName;
import org.intellics.backend.repository.RoleRepository;
import org.intellics.backend.repository.UserRepository;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.util.Arrays;
import java.util.List;

@Component
public class DataInitializer implements CommandLineRunner {

    private final RoleRepository roleRepository;
    private final UserRepository userRepository;

    @Value("${app.admin.emails}")
    private String[] adminEmails;

    public DataInitializer(RoleRepository roleRepository, UserRepository userRepository) {
        this.roleRepository = roleRepository;
        this.userRepository = userRepository;
    }

    @Override
    public void run(String... args) throws Exception {
        assignAdminRole();
    }

    private void assignAdminRole() {
        if (roleRepository.findByName(RoleName.ROLE_ADMIN).isEmpty()) {
            roleRepository.save(Role.builder().name(RoleName.ROLE_ADMIN).build());
        }

        Role adminRole = roleRepository.findByName(RoleName.ROLE_ADMIN).get();
        List<String> admins = Arrays.asList(adminEmails);

        userRepository.findAll().forEach(user -> {
            if (admins.contains(user.getEmail())) {
                user.getRoles().add(adminRole);
                userRepository.save(user);
            }
        });
    }
}
