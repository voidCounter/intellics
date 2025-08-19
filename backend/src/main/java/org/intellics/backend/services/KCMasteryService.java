package org.intellics.backend.services;

import org.intellics.backend.domain.entities.UserInteraction;

public interface KCMasteryService {
    
    /**
     * Updates KC mastery based on user interaction
     * @param interaction The user interaction that triggered the mastery update
     */
    void updateMastery(UserInteraction interaction);
    
    /**
     * Calculates BKT mastery update for a specific KC
     * @param currentMastery Current mastery level (0.0 to 1.0)
     * @param isCorrect Whether the user answered correctly
     * @param pGuess Probability of guessing correctly
     * @param pSlip Probability of slipping (making a mistake when known)
     * @param pTransit Probability of transitioning to learned state
     * @param weight Weight of this KC in the interaction
     * @return Updated mastery level
     */
    double calculateBKTUpdate(double currentMastery, boolean isCorrect, double pGuess, double pSlip, double pTransit, double weight);
}
