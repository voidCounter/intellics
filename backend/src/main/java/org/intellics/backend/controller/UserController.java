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
import org.intellics.backend.domain.dto.KCMasteryDto;
import org.intellics.backend.domain.entities.User;
import org.intellics.backend.domain.entities.StudentKCMastery;
import org.intellics.backend.mappers.UserMapper;
import org.intellics.backend.repositories.UserRepository;
import org.intellics.backend.repositories.StudentKCMasteryRepository;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;
import java.util.Map;
import java.util.Set;
import java.util.ArrayList;

@RestController
@RequestMapping("/api/v1/users")
@Tag(name = "User Management", description = "API endpoints for user-related operations")
public class UserController {

    private final UserRepository userRepository;
    private final UserMapper userMapper;
    private final StudentKCMasteryRepository studentKCMasteryRepository;

    public UserController(UserRepository userRepository, UserMapper userMapper, StudentKCMasteryRepository studentKCMasteryRepository) {
        this.userRepository = userRepository;
        this.userMapper = userMapper;
        this.studentKCMasteryRepository = studentKCMasteryRepository;
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

    @Operation(
        summary = "Get current user's KC mastery data",
        description = "Retrieves the KC mastery data for the currently authenticated user.",
        security = @SecurityRequirement(name = "bearerAuth")
    )
    @ApiResponses(value = {
        @ApiResponse(
            responseCode = "200",
            description = "KC mastery data retrieved successfully",
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
    @GetMapping("/me/kc-mastery")
    public ResponseEntity<List<KCMasteryDto>> getCurrentUserKCMastery(Authentication authentication) {
        try {
            String userId = authentication.getName();
            User user = userRepository.findById(UUID.fromString(userId)).orElse(null);
            if (user == null) {
                return ResponseEntity.status(404).build();
            }

            // Get user's KC mastery data
            List<StudentKCMastery> studentKCMasteryList = studentKCMasteryRepository.findByUserId(user.getUser_id());
            
            // Create a map of existing mastery data
            Map<UUID, StudentKCMastery> masteryMap = studentKCMasteryList.stream()
                .collect(Collectors.toMap(
                    mastery -> mastery.getStudentKCMasteryId().getKc_id(),
                    mastery -> mastery
                ));

            // Get all available KCs (you might want to filter by module or make this configurable)
            // For now, we'll get all KCs that the user has encountered
            Set<UUID> userKcIds = masteryMap.keySet();
            
            List<KCMasteryDto> kcMasteryDtos = new ArrayList<>();
            
            // Add KCs with existing mastery data
            for (StudentKCMastery mastery : studentKCMasteryList) {
                kcMasteryDtos.add(KCMasteryDto.builder()
                    .kcId(mastery.getStudentKCMasteryId().getKc_id())
                    .kcName(mastery.getKnowledgeComponent().getKc_name())
                    .kcDescription(mastery.getKnowledgeComponent().getDescription())
                    .pMastery(mastery.getP_mastery())
                    .pGuess(mastery.getP_guess())
                    .pSlip(mastery.getP_slip())
                    .pTransit(mastery.getP_transit())
                    .updatedAt(mastery.getUpdated_at())
                    .build());
            }

            // Debug logging
            System.out.println("Generated " + kcMasteryDtos.size() + " KC mastery DTOs");
            for (KCMasteryDto dto : kcMasteryDtos) {
                System.out.println("DTO: " + dto.getKcId() + " - " + dto.getKcName() + " - Mastery: " + dto.getPMastery());
            }

            // Try returning the list directly to see if that fixes serialization
            return ResponseEntity.ok(kcMasteryDtos);
        } catch (Exception e) {
            return ResponseEntity.status(401).build();
        }
    }
} 