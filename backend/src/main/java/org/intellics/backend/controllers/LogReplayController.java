package org.intellics.backend.controllers;

import org.intellics.backend.services.LogReplayService;
import org.intellics.backend.domain.dto.ReplayResultDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/log-replay")
@PreAuthorize("hasRole('ADMIN')")
public class LogReplayController {
    
    private final LogReplayService logReplayService;
    
    @Autowired
    public LogReplayController(LogReplayService logReplayService) {
        this.logReplayService = logReplayService;
    }
    
    /**
     * Replay KC mastery progression for a user with custom interaction types
     */
    @PostMapping("/users/{userId}/replay")
    public ResponseEntity<List<ReplayResultDto>> replayKCMastery(
            @PathVariable UUID userId,
            @RequestBody List<String> allowedInteractionTypes) {
        
        List<ReplayResultDto> results = logReplayService.replayKCMastery(userId, allowedInteractionTypes);
        return ResponseEntity.ok(results);
    }
    
    /**
     * Replay KC mastery progression with only HINT_REQUESTED and QUESTION_ATTEMPTED
     */
    @GetMapping("/users/{userId}/replay/hint-and-question")
    public ResponseEntity<List<ReplayResultDto>> replayHintAndQuestionAttempts(@PathVariable UUID userId) {
        List<ReplayResultDto> results = logReplayService.replayHintAndQuestionAttempts(userId);
        return ResponseEntity.ok(results);
    }
    
    /**
     * Replay KC mastery progression with only HINT_REQUESTED
     */
    @GetMapping("/users/{userId}/replay/hint-only")
    public ResponseEntity<List<ReplayResultDto>> replayHintOnly(@PathVariable UUID userId) {
        List<ReplayResultDto> results = logReplayService.replayHintOnly(userId);
        return ResponseEntity.ok(results);
    }
    
    /**
     * Replay KC mastery progression with only QUESTION_ATTEMPTED
     */
    @GetMapping("/users/{userId}/replay/question-only")
    public ResponseEntity<List<ReplayResultDto>> replayQuestionAttemptsOnly(@PathVariable UUID userId) {
        List<ReplayResultDto> results = logReplayService.replayQuestionAttemptsOnly(userId);
        return ResponseEntity.ok(results);
    }
}
