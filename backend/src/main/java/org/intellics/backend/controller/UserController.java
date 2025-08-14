package org.intellics.backend.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.intellics.backend.api.ApiResponseDto;
import org.intellics.backend.api.ApiResponseStatus;
import org.intellics.backend.domain.dto.UserDto;
import org.intellics.backend.domain.entities.User;
import org.intellics.backend.mappers.UserMapper;
import org.intellics.backend.repositories.UserRepository;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/users")
@Tag(name = "User Management", description = "API endpoints for user-related operations")
public class UserController {

    private final UserRepository userRepository;
    private final UserMapper userMapper;

    public UserController(UserRepository userRepository, UserMapper userMapper) {
        this.userRepository = userRepository;
        this.userMapper = userMapper;
    }

    @Operation(
        summary = "Get current user profile", 
        description = "Retrieves the profile information of the currently authenticated user",
        security = @SecurityRequirement(name = "bearerAuth")
    )
    @ApiResponses(value = {
        @ApiResponse(
            responseCode = "200", 
            description = "User profile retrieved successfully",
            content = @Content(
                mediaType = "application/json",
                schema = @Schema(implementation = ApiResponseDto.class)
            )
        ),
        @ApiResponse(
            responseCode = "401", 
            description = "Unauthorized - Invalid or missing authentication token",
            content = @Content
        ),
        @ApiResponse(
            responseCode = "404", 
            description = "User not found",
            content = @Content
        )
    })
    @GetMapping("/me")
    public ResponseEntity<ApiResponseDto<UserDto>> getCurrentUser(Authentication authentication) {
        try {
            // Extract the user ID from the authentication principal
            String userId = authentication.getName();
            User user = userRepository.findById(java.util.UUID.fromString(userId)).orElse(null);
            if (user == null) {
                return ResponseEntity.status(404).build();
            }
            UserDto userDto = userMapper.mapTo(user);
            return new ResponseEntity<>(new ApiResponseDto<UserDto>(ApiResponseStatus.SUCCESS, userDto, "User profile retrieved successfully."), HttpStatus.OK);
        } catch (Exception e) {
            return ResponseEntity.status(401).build();
        }
    }
} 