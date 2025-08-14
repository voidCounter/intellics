package org.intellics.backend.config;

import org.intellics.backend.security.CustomOAuth2UserService;
import org.intellics.backend.security.JwtAuthenticationFilter;
import org.intellics.backend.security.JwtTokenProvider;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity
public class SecurityConfig {

    @Value("${app.frontend.url:http://localhost:3000}")
    private String frontendUrl;

    @Autowired
    private CustomOAuth2UserService customOAuth2UserService;

    @Autowired
    private JwtTokenProvider tokenProvider;

    @Autowired
    private AuthenticationConfiguration authenticationConfiguration;

    @Bean
    public JwtAuthenticationFilter jwtAuthenticationFilter() {
        return new JwtAuthenticationFilter();
    }

    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration authenticationConfiguration) throws Exception {
        return authenticationConfiguration.getAuthenticationManager();
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            .cors(cors -> cors.configure(http))
            .csrf(AbstractHttpConfigurer::disable)
            .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
            .authorizeHttpRequests(authorizeRequests ->
                authorizeRequests
                    .requestMatchers("/oauth2/**").permitAll() // Allow access to OAuth2 endpoints
                    .requestMatchers("/actuator/**").permitAll() // Allow access to actuator endpoints
                    .requestMatchers("/api-docs/**").permitAll() // Allow access to Swagger endpoints
                    .requestMatchers("/swagger-ui/**").permitAll() // Allow access to Swagger UI
                    .requestMatchers("/swagger-ui.html").permitAll() // Allow access to Swagger UI
                    .requestMatchers("/v3/api-docs/**").permitAll() // Allow access to OpenAPI docs
                    .anyRequest().authenticated()
            )
            .oauth2Login(oauth2Login ->
                oauth2Login
                    .userInfoEndpoint(userInfoEndpoint ->
                        userInfoEndpoint
                            .oidcUserService(customOAuth2UserService)
                    )
                    .successHandler(authenticationSuccessHandler())
            );

        // Add our custom JWT security filter
        http.addFilterBefore(jwtAuthenticationFilter(), UsernamePasswordAuthenticationFilter.class);

        return http.build();
    }

    @Bean
    public AuthenticationSuccessHandler authenticationSuccessHandler() {
        return (request, response, authentication) -> {
            if (authentication instanceof OAuth2AuthenticationToken) {
                OAuth2AuthenticationToken oauthToken = (OAuth2AuthenticationToken) authentication;
                // Get the user ID from ThreadLocal
                String userId = CustomOAuth2UserService.getCurrentUserId();
                String jwt = tokenProvider.generateToken(userId);
                response.sendRedirect(frontendUrl + "/auth?token=" + jwt);
            } else {
                response.sendRedirect(frontendUrl + "/auth");
            }
        };
    }
}
