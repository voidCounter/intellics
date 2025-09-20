package org.intellics.backend.domain.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.Instant;
import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class KCMasteryDto {
    private UUID kcId;
    
    private String kcName;
    
    private String kcDescription;
    
    private double pMastery;
    
    private double pGuess;
    
    private double pSlip;
    
    private double pTransit;
    
    private Instant updatedAt;
    
    // Explicit getters to ensure proper JSON serialization with camelCase names
    public UUID getKcId() { return kcId; }
    public String getKcName() { return kcName; }
    public String getKcDescription() { return kcDescription; }
    public double getPMastery() { return pMastery; }
    public double getPGuess() { return pGuess; }
    public double getPSlip() { return pSlip; }
    public double getPTransit() { return pTransit; }
    public Instant getUpdatedAt() { return updatedAt; }
}
