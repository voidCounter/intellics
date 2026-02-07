package org.intellics.backend.services;

/**
 * Service for LLM-powered answer evaluation and scaffold guidance.
 * 
 * This service handles:
 * 1. Written answer evaluation (60-70% correctness threshold)
 * 2. Scaffold guidance generation (without revealing answers)
 * 3. Adaptive feedback based on answer quality
 */
public interface LLMService {
    
    /**
     * Evaluates a written answer against the correct answer and question context.
     * 
     * @param questionText The question text
     * @param correctAnswer The correct answer text
     * @param userAnswer The user's written answer
     * @param questionContext Additional context about the question (optional)
     * @return AnswerEvaluationResult containing correctness score and feedback
     */
    AnswerEvaluationResult evaluateWrittenAnswer(String questionText, String correctAnswer, String userAnswer, String questionContext);

    /**
     * Evaluates a written answer against the correct answer and question context with a custom API key.
     *
     * @param questionText The question text
     * @param correctAnswer The correct answer text
     * @param userAnswer The user's written answer
     * @param questionContext Additional context about the question (optional)
     * @param apiKey Custom API key to use for this request (optional)
     * @return AnswerEvaluationResult containing correctness score and feedback
     */
    default AnswerEvaluationResult evaluateWrittenAnswer(String questionText, String correctAnswer, String userAnswer, String questionContext, String apiKey) {
        return evaluateWrittenAnswer(questionText, correctAnswer, userAnswer, questionContext);
    }
    
    /**
     * Generates scaffold guidance to help the user without revealing the answer.
     * 
     * @param questionText The question text
     * @param userAnswer The user's current answer
     * @param correctAnswer The correct answer (for context, not revealed to user)
     * @param scaffoldType The type of scaffold (hint, step-by-step, etc.)
     * @return ScaffoldGuidance containing helpful guidance without giving away the answer
     */
    ScaffoldGuidance generateScaffoldGuidance(String questionText, String userAnswer, String correctAnswer, String scaffoldType);

    /**
     * Generates scaffold guidance to help the user without revealing the answer with a custom API key.
     *
     * @param questionText The question text
     * @param userAnswer The user's current answer
     * @param correctAnswer The correct answer (for context, not revealed to user)
     * @param scaffoldType The type of scaffold (hint, step-by-step, etc.)
     * @param apiKey Custom API key to use for this request (optional)
     * @return ScaffoldGuidance containing helpful guidance without giving away the answer
     */
    default ScaffoldGuidance generateScaffoldGuidance(String questionText, String userAnswer, String correctAnswer, String scaffoldType, String apiKey) {
        return generateScaffoldGuidance(questionText, userAnswer, correctAnswer, scaffoldType);
    }
    
    /**
     * Result of answer evaluation with correctness score and feedback.
     */
    record AnswerEvaluationResult(
        double correctnessScore,        // 0.0 to 1.0 (0.6-0.7 threshold for "good")
        boolean isCorrect,              // Whether answer meets correctness threshold
        String feedback,                // Constructive feedback for the user
        String detailedAnalysis         // Detailed analysis for teachers/admins
    ) {}
    
    /**
     * Scaffold guidance that helps without revealing answers.
     */
    record ScaffoldGuidance(
        String guidance,                // Helpful guidance text
        String hintLevel,               // Level of hint (basic, intermediate, advanced)
        boolean revealsAnswer,          // Whether this guidance reveals the answer
        String nextSteps                // Suggested next steps for the user
    ) {}
}
