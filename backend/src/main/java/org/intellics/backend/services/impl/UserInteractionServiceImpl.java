package org.intellics.backend.services.impl;

import lombok.RequiredArgsConstructor;
import org.intellics.backend.domain.dto.InteractionKCMappingDto;
import org.intellics.backend.domain.dto.UserInteractionDto;
import org.intellics.backend.domain.entities.InteractionKCMapping;
import org.intellics.backend.domain.entities.InteractionType;
import org.intellics.backend.domain.entities.UserInteraction;
import org.intellics.backend.repositories.InteractionKCMappingRepository;
import org.intellics.backend.repositories.UserInteractionRepository;
import org.intellics.backend.services.UserInteractionService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class UserInteractionServiceImpl implements UserInteractionService {

    private final UserInteractionRepository userInteractionRepository;
    private final InteractionKCMappingRepository interactionKCMappingRepository;

    @Override
    public Page<UserInteractionDto> getInteractionsWithFilters(
            UUID userId,
            UUID sessionId,
            UUID moduleId,
            UUID lessonId,
            UUID questionId,
            UUID scaffoldId,
            UUID kcId,
            InteractionType interactionType,
            Boolean isCorrect,
            Instant timestampAfter,
            Instant timestampBefore,
            Pageable pageable) {

        Page<UserInteraction> interactions = userInteractionRepository.findWithFilters(
            userId, sessionId, moduleId, lessonId, questionId, scaffoldId, kcId,
            interactionType, isCorrect, timestampAfter, timestampBefore, pageable
        );

        return interactions.map(this::mapToDto);
    }

    private UserInteractionDto mapToDto(UserInteraction interaction) {
        // Get KC mappings for this interaction
        List<InteractionKCMappingDto> kcMappings = getKCMappingsForInteraction(interaction.getInteraction_id());

        return UserInteractionDto.builder()
            .interactionId(interaction.getInteraction_id())
            .sessionId(interaction.getSession() != null ? interaction.getSession().getSession_id() : null)
            .userId(interaction.getUser() != null ? interaction.getUser().getUser_id() : null)
            .moduleId(interaction.getModule() != null ? interaction.getModule().getModule_id() : null)
            .lessonId(interaction.getLesson() != null ? interaction.getLesson().getLesson_id() : null)
            .questionId(interaction.getQuestion() != null ? interaction.getQuestion().getQuestion_id() : null)
            .scaffoldId(interaction.getScaffold() != null ? interaction.getScaffold().getScaffold_id() : null)
            .interactionType(interaction.getInteractionType())
            .studentAnswer(interaction.getStudent_answer())
            .isCorrect(interaction.is_correct())
            .hintLevel(interaction.getHint_level())
            .timeSpentSeconds(interaction.getTime_spent_seconds())
            .timestamp(interaction.getTimestamp())
            .kcMappings(kcMappings)
            .build();
    }

    private List<InteractionKCMappingDto> getKCMappingsForInteraction(UUID interactionId) {
        List<InteractionKCMapping> mappings = interactionKCMappingRepository.findByInteractionId(interactionId);
        
        return mappings.stream()
            .map(mapping -> InteractionKCMappingDto.builder()
                .interactionId(interactionId)
                .kcId(mapping.getKnowledgeComponent().getKc_id())
                .kcName(mapping.getKnowledgeComponent().getKc_name())
                .weight(mapping.getWeight())
                .kcMasteryBefore(mapping.getKcMasteryBefore())
                .kcMasteryAfter(mapping.getKcMasteryAfter())
                .build())
            .toList();
    }
}
