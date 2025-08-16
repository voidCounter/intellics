package org.intellics.backend.repositories;

import org.intellics.backend.domain.entities.KnowledgeComponent;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface KnowledgeComponentRepository extends JpaRepository<KnowledgeComponent, UUID> {
    
    // Find only active knowledge components (default behavior)
    List<KnowledgeComponent> findByIsActiveTrue();
    
    // Find only inactive knowledge components
    List<KnowledgeComponent> findByIsActiveFalse();
    
    // Find ALL knowledge components regardless of status (admin use)
    @Query("SELECT kc FROM KnowledgeComponent kc ORDER BY kc.kc_name")
    List<KnowledgeComponent> findAllOrdered();
    
    // Count active knowledge components
    long countByIsActiveTrue();
    
    // Count inactive knowledge components
    long countByIsActiveFalse();
    
    // Find by ID and active status
    @Query("SELECT kc FROM KnowledgeComponent kc WHERE kc.kc_id = :kc_id AND kc.isActive = true")
    KnowledgeComponent findByKcIdAndIsActiveTrue(@Param("kc_id") UUID kc_id);
    
    // Find by ID and inactive status
    @Query("SELECT kc FROM KnowledgeComponent kc WHERE kc.kc_id = :kc_id AND kc.isActive = false")
    KnowledgeComponent findByKcIdAndIsActiveFalse(@Param("kc_id") UUID kc_id);
    
    // Find by ID regardless of status (admin use)
    @Query("SELECT kc FROM KnowledgeComponent kc WHERE kc.kc_id = :kc_id")
    KnowledgeComponent findByKcId(@Param("kc_id") UUID kc_id);
}
