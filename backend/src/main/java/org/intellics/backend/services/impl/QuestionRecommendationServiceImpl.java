package org.intellics.backend.services.impl;

import java.util.List;
import java.util.UUID;

import org.intellics.backend.domain.dto.QuestionDto;
import org.intellics.backend.domain.dto.QuestionRecommendationDto;
import org.intellics.backend.domain.dto.QuestionWithScaffoldsDto;
import org.intellics.backend.domain.entities.QuestionEntity;
import org.intellics.backend.mappers.Mapper;
import org.intellics.backend.mappers.QuestionWithScaffoldsMapper;
import org.intellics.backend.services.QuestionRecommendationService;
import org.intellics.backend.services.QuestionService;
import org.intellics.backend.services.UserInteractionService;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class QuestionRecommendationServiceImpl implements QuestionRecommendationService {

    private final JdbcTemplate jdbcTemplate;
    private final QuestionService questionService;
    private final Mapper<QuestionDto, QuestionEntity> questionMapper;
    private final QuestionWithScaffoldsMapper questionWithScaffoldsMapper;
    private final UserInteractionService userInteractionService;
    
    // Row mapper for converting SQL results to DTOs
    private final RowMapper<QuestionRecommendationDto> recommendationRowMapper = (rs, rowNum) ->
        QuestionRecommendationDto.builder()
            .questionId(UUID.fromString(rs.getString("question_id")))
            .questionText(rs.getString("question_text"))
            .primaryKc(UUID.fromString(rs.getString("primary_kc")))
            .priorityScore(rs.getBigDecimal("priority_score"))
            .masteryGap(rs.getBigDecimal("mastery_gap"))
            .recencyFactor(rs.getBigDecimal("recency_factor"))
            .lastCorrectAnswer(rs.getTimestamp("last_correct_answer") != null ? 
                rs.getTimestamp("last_correct_answer").toInstant() : null)
            .build();

    @Override
    public QuestionDto getNextQuestion(UUID userId, UUID lessonId, UUID moduleId, Boolean includePrerequisites) {
        log.debug("Getting next question for user {} (lesson: {}, module: {})", userId, lessonId, moduleId);
        
        // Determine context and parameters
        String context = lessonId != null ? "lesson" : "global";
        Boolean includePrereqs = includePrerequisites != null ? includePrerequisites : (context.equals("global"));
        
        String sql = """
            SELECT * FROM recommend_questions(
                ?, ?, ?, ?, ?, ?, ?, ?
            )
            LIMIT 1
            """;
        
        try {
            List<QuestionRecommendationDto> recommendations = jdbcTemplate.query(
                sql,
                recommendationRowMapper,
                userId,
                context,
                lessonId,
                moduleId,
                1, // Get only 1 question
                includePrereqs,
                30, // Default max recency days
                1   // Default per KC limit
            );
            
            if (recommendations.isEmpty()) {
                log.debug("No more questions available for user {}", userId);
                return null;
            }
            
            QuestionRecommendationDto recommendation = recommendations.get(0);
            log.debug("Found recommendation for question {} with priority {}", 
                recommendation.getQuestionId(), recommendation.getPriorityScore());
            
            // Fetch the full question data
            QuestionEntity questionEntity = questionService.getQuestion(recommendation.getQuestionId());
            QuestionDto questionDto = questionMapper.mapTo(questionEntity);
            
            log.debug("Retrieved full question data for question {}", questionDto.getQuestion_id());
            
            // Log that this question was presented to the user
            try {
                userInteractionService.logQuestionPresented(userId, questionDto.getQuestion_id(), lessonId, moduleId);
            } catch (Exception e) {
                log.warn("Failed to log question presented interaction for question {}: {}", 
                    questionDto.getQuestion_id(), e.getMessage());
            }
            
            return questionDto;
            
        } catch (Exception e) {
            log.error("Error getting next question for user {}: {}", userId, e.getMessage(), e);
            throw new RuntimeException("Failed to get next question", e);
        }
    }

    @Override
    public QuestionWithScaffoldsDto getNextQuestionWithScaffolds(UUID userId, UUID lessonId, UUID moduleId, Boolean includePrerequisites) {
        log.debug("Getting next question with scaffolds for user {} (lesson: {}, module: {})", userId, lessonId, moduleId);
        
        // Determine context and parameters
        String context = lessonId != null ? "lesson" : "global";
        Boolean includePrereqs = includePrerequisites != null ? includePrerequisites : (context.equals("global"));
        
        String sql = """
            SELECT * FROM recommend_questions(
                ?, ?, ?, ?, ?, ?, ?, ?
            )
            LIMIT 1
            """;
        
        try {
            List<QuestionRecommendationDto> recommendations = jdbcTemplate.query(
                sql,
                recommendationRowMapper,
                userId,
                context,
                lessonId,
                moduleId,
                1, // Get only 1 question
                includePrereqs,
                30, // Default max recency days
                1   // Default per KC limit
            );
            
            if (recommendations.isEmpty()) {
                log.debug("No more questions available for user {}", userId);
                return null;
            }
            
            QuestionRecommendationDto recommendation = recommendations.get(0);
            log.debug("Found recommendation for question {} with priority {}", 
                recommendation.getQuestionId(), recommendation.getPriorityScore());
            
            // Fetch the full question data with scaffolds
            QuestionEntity questionEntity = questionService.getQuestion(recommendation.getQuestionId());
            QuestionWithScaffoldsDto questionDto = questionWithScaffoldsMapper.mapTo(questionEntity);
            
            log.debug("Retrieved full question data with scaffolds for question {}", questionDto.getQuestion_id());
            
            // Log that this question was presented to the user
            try {
                userInteractionService.logQuestionPresented(userId, questionDto.getQuestion_id(), lessonId, moduleId);
            } catch (Exception e) {
                log.warn("Failed to log question presented interaction for question {}: {}", 
                    questionDto.getQuestion_id(), e.getMessage());
            }
            
            return questionDto;
            
        } catch (Exception e) {
            log.error("Error getting next question with scaffolds for user {}: {}", userId, e.getMessage(), e);
            throw new RuntimeException("Failed to get next question with scaffolds", e);
        }
    }

    @Override
    public List<QuestionRecommendationDto> getPracticeSession(UUID userId, UUID lessonId, UUID moduleId, int count, Boolean includePrerequisites) {
        log.debug("Getting practice session for user {} (lesson: {}, module: {}, count: {})", 
            userId, lessonId, moduleId, count);
        
        // Determine context and parameters
        String context = lessonId != null ? "lesson" : "global";
        Boolean includePrereqs = includePrerequisites != null ? includePrerequisites : (context.equals("global"));
        
        String sql = """
            SELECT * FROM recommend_questions(
                ?, ?, ?, ?, ?, ?, ?, ?
            )
            """;
        
        try {
            List<QuestionRecommendationDto> questions = jdbcTemplate.query(
                sql,
                recommendationRowMapper,
                userId,
                context,
                lessonId,
                moduleId,
                count,
                includePrereqs,
                30, // Default max recency days
                2   // Default per KC limit
            );
            
            log.debug("Found {} practice questions for user {}", questions.size(), userId);
            return questions;
            
        } catch (Exception e) {
            log.error("Error getting practice session for user {}: {}", userId, e.getMessage(), e);
            throw new RuntimeException("Failed to get practice session", e);
        }
    }
}
