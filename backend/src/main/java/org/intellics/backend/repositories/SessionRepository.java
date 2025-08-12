package org.intellics.backend.repositories;

import java.util.List;
import java.util.UUID;

import org.intellics.backend.domain.entities.Session;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface SessionRepository extends JpaRepository<Session, UUID>, JpaSpecificationExecutor<Session> {

    /**
     * Find all sessions for a specific user
     */
    @Query("SELECT s FROM Session s WHERE s.user.user_id = :userId ORDER BY s.start_time DESC")
    List<Session> findByUserId(@Param("userId") UUID userId);
}
