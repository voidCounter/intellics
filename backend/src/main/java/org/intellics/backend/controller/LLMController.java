package org.intellics.backend.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.intellics.backend.services.LLMService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

/**
 * Controller for LLM-powered educational features.
 * 
 * Provides endpoints for:
 * - Written answer evaluation
 * - Scaffold guidance generation
 */
@RestController
@RequestMapping("/api/v1/llm")
@RequiredArgsConstructor
@Slf4j
public class LLMController {

    private final LLMService llmService;
    
    /**
     * Evaluate a written answer using LLM.
     * 
     * @param request The answer evaluation request
     * @return Evaluation result with correctness score and feedback
     */
    @PostMapping("/evaluate-answer")
    public ResponseEntity<LLMService.AnswerEvaluationResult> evaluateAnswer(
            @RequestBody AnswerEvaluationRequest request) {
        
        log.info("Evaluating answer for question: {}", request.questionText());
        log.debug("Request details - Correct answer: {}, User answer: {}, Context: {}", 
                request.correctAnswer(), request.userAnswer(), request.questionContext());
        
        LLMService.AnswerEvaluationResult result = llmService.evaluateWrittenAnswer(
            request.questionText(),
            request.correctAnswer(),
            request.userAnswer(),
            request.questionContext()
        );
        
        log.info("Evaluation result - Score: {}, IsCorrect: {}, Feedback length: {}, Analysis length: {}", 
                result.correctnessScore(), result.isCorrect(), result.feedback().length(), result.detailedAnalysis().length());
        log.debug("Full result: {}", result);
        
        // Log a sample of the feedback and analysis to help debug
        log.info("Feedback sample: '{}'", result.feedback().substring(0, Math.min(100, result.feedback().length())));
        log.info("Analysis sample: '{}'", result.detailedAnalysis().substring(0, Math.min(100, result.detailedAnalysis().length())));
        
        return ResponseEntity.ok(result);
    }
    
    /**
     * Generate scaffold guidance using LLM.
     * 
     * @param request The scaffold guidance request
     * @return Scaffold guidance without revealing the answer
     */
    @PostMapping("/generate-scaffold")
    public ResponseEntity<LLMService.ScaffoldGuidance> generateScaffold(
            @RequestBody ScaffoldGuidanceRequest request) {
        
        log.info("Generating scaffold guidance for question: {}, type: {}", 
            request.questionText(), request.scaffoldType());
        log.debug("Request details - User answer: {}, Correct answer: {}", 
                request.userAnswer(), request.correctAnswer());
        
        LLMService.ScaffoldGuidance guidance = llmService.generateScaffoldGuidance(
            request.questionText(),
            request.userAnswer(),
            request.correctAnswer(),
            request.scaffoldType()
        );
        
        log.info("Scaffold guidance result - Guidance length: {}, Hint level: {}, Next steps length: {}", 
                guidance.guidance().length(), guidance.hintLevel(), guidance.nextSteps().length());
        log.debug("Full guidance: {}", guidance);
        
        return ResponseEntity.ok(guidance);
    }
    
    /**
     * Test endpoint to verify LLM service is working.
     */
    @GetMapping("/test")
    public ResponseEntity<String> testLLM() {
        log.info("Testing LLM service...");
        return ResponseEntity.ok("LLM service is running");
    }
    
    /**
     * Request for answer evaluation.
     */
    public static record AnswerEvaluationRequest(
        String questionText,
        String correctAnswer,
        String userAnswer,
        String questionContext
    ) {}
    
    /**
     * Request for scaffold guidance.
     */
    public static record ScaffoldGuidanceRequest(
        String questionText,
        String userAnswer,
        String correctAnswer,
        String scaffoldType
    ) {}
}
