package org.intellics.backend.services.impl;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.intellics.backend.services.LLMService;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.stereotype.Service;

/**
 * Complete refactored implementation of LLM service using Spring AI 1.0.1.
 * This version leverages the framework's structured output features for cleaner, more reliable code.
 */
@Service
@RequiredArgsConstructor
@Slf4j
public class LLMServiceImpl implements LLMService {

    private final ChatClient chatClient;

    // Correctness threshold for written answers (80% - stricter grading)
    private static final double CORRECTNESS_THRESHOLD = 0.8;

    // No system prompts needed for Gemma models

    /**
     * Validate and adjust score if it seems unreasonable
     */
    private double validateAndAdjustScore(double originalScore, String userAnswer, String correctAnswer) {
        // If the answer is completely wrong, cap the score at 0.3
        if (originalScore > 0.3) {
            // Check if this is a simple factual question with a clear right/wrong answer
            if (isSimpleFactualQuestion(userAnswer, correctAnswer)) {
                log.warn("LLM gave score {} for clearly wrong answer '{}' vs correct '{}'. Adjusting to 0.0", 
                        originalScore, userAnswer, correctAnswer);
                return 0.0;
            }
            
            // Additional check: if the answers are completely different, don't allow high scores
            if (areAnswersCompletelyDifferent(userAnswer, correctAnswer)) {
                log.warn("LLM gave score {} for completely different answers. Capping at 0.2", originalScore);
                return Math.min(originalScore, 0.2);
            }
        }
        return originalScore;
    }
    
    /**
     * Check if this is a simple factual question (like capital cities, dates, etc.)
     */
    private boolean isSimpleFactualQuestion(String userAnswer, String correctAnswer) {
        // Simple heuristic: if answers are completely different and not similar at all
        String userLower = userAnswer.toLowerCase().trim();
        String correctLower = correctAnswer.toLowerCase().trim();
        
        // If they're completely different and not similar at all
        if (!userLower.equals(correctLower) && !userLower.contains(correctLower) && !correctLower.contains(userLower)) {
            // Check if this looks like a simple factual question
            return true;
        }
        return false;
    }
    
    /**
     * Check if answers are completely different (no similarity at all)
     */
    private boolean areAnswersCompletelyDifferent(String userAnswer, String correctAnswer) {
        String userLower = userAnswer.toLowerCase().trim();
        String correctLower = correctAnswer.toLowerCase().trim();
        
        // If they're the same, they're not different
        if (userLower.equals(correctLower)) {
            return false;
        }
        
        // If one contains the other, they're not completely different
        if (userLower.contains(correctLower) || correctLower.contains(userLower)) {
            return false;
        }
        
        // Check for any common words or significant overlap
        String[] userWords = userLower.split("\\s+");
        String[] correctWords = correctLower.split("\\s+");
        
        for (String userWord : userWords) {
            if (userWord.length() > 2) { // Only check words longer than 2 chars
                for (String correctWord : correctWords) {
                    if (correctWord.length() > 2 && (userWord.contains(correctWord) || correctWord.contains(userWord))) {
                        return false; // Found some similarity
                    }
                }
            }
        }
        
        return true; // No similarity found
    }

    /**
     * Structured response class for answer evaluation from LLM.
     */
    public record AnswerEvaluationResponse(
        double score,
        String feedback,
        String analysis
    ) {}
    
    /**
     * Structured response class for scaffold guidance from LLM.
     */
    public record ScaffoldGuidanceResponse(
        String guidance,
        String hintLevel,
        String nextSteps
    ) {}
    
    @Override
    public AnswerEvaluationResult evaluateWrittenAnswer(String questionText, String correctAnswer, String userAnswer, String questionContext) {
        try {
            log.info("=== Starting LLM Answer Evaluation ===");
            
            // Create a strict prompt that works with Gemma models (no system prompts)
            String prompt = String.format("""
    You are a strict but fair programming tutor. Grade student answers based on correctness, not on wording style. 
    Focus on whether the student demonstrates the correct understanding, even if phrased differently.

    SCORING RULES:
    - Score 0.0-0.2: Completely wrong or irrelevant
    - Score 0.3-0.4: Wrong overall, but shows tiny hints of understanding
    - Score 0.5-0.6: Partially correct, missing major elements or with significant mistakes
    - Score 0.7-0.8: Mostly correct, only minor omissions or lacks an example
    - Score 0.9-1.0: Correct or nearly perfect, fully explains the concept and/or provides a valid example

    SPECIAL NOTES:
    - Do NOT penalize differences in wording as long as the meaning is correct.
    - If the student answer explains the concept correctly but does not include an example, deduct a small amount (still 0.7+).
    - If the concept is clearly correct but phrased differently than the provided answer, treat it as correct.
    - If the answer is wrong, score it LOW (0.0–0.4). Never give high scores for wrong answers.

    Provide a JSON response in this exact format:
    {
      "score": your score,
      "feedback": "Short constructive feedback to the student",
      "analysis": "Explain why you gave this score, highlighting strengths/weaknesses"
    }

    QUESTION: %s

    %s

    CORRECT ANSWER: %s

    STUDENT ANSWER: %s

    Respond with ONLY a valid JSON object.
    """,
    questionText,
    questionContext != null && !questionContext.trim().isEmpty() ? "CONTEXT: " + questionContext + "\n\n" : "",
    correctAnswer,
    userAnswer
);

            // Use Spring AI to call the model and automatically map the JSON response
            AnswerEvaluationResponse response = chatClient.prompt()
                .user(prompt)
                .call()
                .entity(AnswerEvaluationResponse.class);

            // Use the score directly from LLM without adjustment
            double score = response.score();
            boolean isCorrect = score >= CORRECTNESS_THRESHOLD;

            log.info("Evaluation complete - Score: {}, IsCorrect: {}", score, isCorrect);
            
            return new AnswerEvaluationResult(
                score,
                isCorrect,
                response.feedback(),
                response.analysis()
            );

        } catch (Exception e) {
            log.error("Error evaluating written answer: {}", e.getMessage(), e);
            return createFallbackEvaluation(userAnswer);
        }
    }

    @Override
    public ScaffoldGuidance generateScaffoldGuidance(String questionText, String userAnswer, String correctAnswer, String scaffoldType) {
        try {
            log.info("=== Starting LLM Scaffold Guidance Generation ===");
            
            // Create a simple prompt that works with Gemma models (no system prompts)
            String prompt = String.format("""
                You are a helpful and patient programming tutor. Your job is to guide students without giving them the full answer.

                Please provide scaffold guidance for the following question, and provide a JSON response in this exact format:
                {
                  "guidance": "Here's a specific hint to help you...",
                  "hintLevel": "intermediate",
                  "nextSteps": "Try focusing on the constructor method..."
                }

                QUESTION: %s
                
                STUDENT'S CURRENT ANSWER: %s
                
                SCAFFOLD TYPE: %s
                
                Respond with ONLY a valid JSON object.
                """,
                questionText,
                userAnswer,
                scaffoldType
            );

            // Use Spring AI to call the model and automatically map the JSON response
            ScaffoldGuidanceResponse response = chatClient.prompt()
                .user(prompt)
                .call()
                .entity(ScaffoldGuidanceResponse.class);

            log.info("Scaffold guidance complete - Hint level: {}", response.hintLevel());
            
            return new ScaffoldGuidance(
                response.guidance(),
                response.hintLevel(),
                false, // Always false as per the original logic
                response.nextSteps()
            );
            
        } catch (Exception e) {
            log.error("Error generating scaffold guidance: {}", e.getMessage(), e);
            return createFallbackScaffoldGuidance(scaffoldType);
        }
    }

    /**
     * Fallback evaluation in case the LLM call or parsing fails.
     */
    private AnswerEvaluationResult createFallbackEvaluation(String userAnswer) {
        return new AnswerEvaluationResult(
            0.5,
            false,
            "I'm having trouble evaluating your answer right now. Please review your response and try again.",
            "LLM evaluation failed - manual review recommended"
        );
    }
    
    /**
     * Fallback scaffold guidance in case the LLM call or parsing fails.
     */
    private ScaffoldGuidance createFallbackScaffoldGuidance(String scaffoldType) {
        return new ScaffoldGuidance(
            "I'm having trouble providing guidance right now. Try breaking down the problem into smaller steps.",
            "basic",
            false,
            "Review the question carefully and identify what you know and what you need to find out."
        );
    }
}
