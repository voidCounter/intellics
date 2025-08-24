package org.intellics.backend.services;

import org.intellics.backend.domain.dto.QuestionRecommendationDto;
import org.intellics.backend.domain.dto.QuestionDto;
import org.intellics.backend.domain.dto.QuestionWithScaffoldsDto;

import java.util.List;
import java.util.UUID;

public interface QuestionRecommendationService {
    
    /**
     * Get the next recommended question for the user
     * 
     * @param userId The user ID to get recommendations for
     * @param lessonId Optional lesson ID for lesson-specific practice
     * @param moduleId Optional module ID for module-specific practice
     * @param includePrerequisites Whether to include prerequisite KCs (null = auto by context)
     * @param scope Scope for module practice: 'all' for all KCs, 'current' for current mastery level
     * @return The next recommended question with full data, or null if no more questions available
     */
    QuestionDto getNextQuestion(UUID userId, UUID lessonId, UUID moduleId, Boolean includePrerequisites, String scope);
    
    /**
     * Get the next recommended question for the user with scaffolds
     * 
     * @param userId The user ID to get recommendations for
     * @param lessonId Optional lesson ID for lesson-specific practice
     * @param moduleId Optional module ID for module-specific practice
     * @param includePrerequisites Whether to include prerequisite KCs (null = auto by context)
     * @param scope Scope for module practice: 'all' for all KCs, 'current' for current mastery level
     * @return The next recommended question with full data and scaffolds, or null if no more questions available
     */
    QuestionWithScaffoldsDto getNextQuestionWithScaffolds(UUID userId, UUID lessonId, UUID moduleId, Boolean includePrerequisites, String scope);
    
    /**
     * Get a set of questions for a practice session
     * 
     * @param userId The user ID
     * @param lessonId Optional lesson ID for lesson-specific practice
     * @param moduleId Optional module ID for module-specific practice
     * @param count Number of questions to get
     * @param includePrerequisites Whether to include prerequisite KCs (null = auto by context)
     * @param scope Scope for module practice: 'all' for all KCs, 'current' for current mastery level
     * @return List of recommended questions for the practice session
     */
    List<QuestionRecommendationDto> getPracticeSession(UUID userId, UUID lessonId, UUID moduleId, int count, Boolean includePrerequisites, String scope);
}
