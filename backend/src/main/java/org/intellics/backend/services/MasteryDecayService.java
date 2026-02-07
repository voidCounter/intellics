package org.intellics.backend.services;

import java.util.UUID;

public interface MasteryDecayService {
    
    /**
     * Applies time-based decay to user's mastery of knowledge components.
     * Starts from the KCs associated with the given context (lesson/module)
     * and propagates to related KCs.
     * 
     * @param userId The user ID
     * @param lessonId Optional lesson context
     * @param moduleId Optional module context
     */
    void applyDecay(UUID userId, UUID lessonId, UUID moduleId);
}
