package org.intellics.backend.repositories;

import org.intellics.backend.domain.entities.StudentKCMastery;
import org.intellics.backend.domain.entities.StudentKCMasteryId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface StudentKCMasteryRepository extends JpaRepository<StudentKCMastery, StudentKCMasteryId> {
    
    /**
     * Find KC mastery for a specific user and KC
     */
    @Query("SELECT skm FROM StudentKCMastery skm WHERE skm.studentKCMasteryId.user_id = :userId AND skm.studentKCMasteryId.kc_id = :kcId")
    Optional<StudentKCMastery> findByUserIdAndKcId(@Param("userId") UUID userId, @Param("kcId") UUID kcId);
    
    /**
     * Find all KC masteries for a specific user
     */
    @Query("SELECT skm FROM StudentKCMastery skm WHERE skm.studentKCMasteryId.user_id = :userId")
    List<StudentKCMastery> findByUserId(@Param("userId") UUID userId);
    
    /**
     * Find all KC masteries for a specific KC
     */
    @Query("SELECT skm FROM StudentKCMastery skm WHERE skm.studentKCMasteryId.kc_id = :kcId")
    List<StudentKCMastery> findByKcId(@Param("kcId") UUID kcId);
    
    /**
     * Check if KC mastery exists for a user and KC
     */
    @Query("SELECT COUNT(skm) > 0 FROM StudentKCMastery skm WHERE skm.studentKCMasteryId.user_id = :userId AND skm.studentKCMasteryId.kc_id = :kcId")
    boolean existsByUserIdAndKcId(@Param("userId") UUID userId, @Param("kcId") UUID kcId);
}
