package org.intellics.backend.repositories;

import org.intellics.backend.domain.entities.KnowledgeComponent;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface KnowledgeComponentRepository extends JpaRepository<KnowledgeComponent, UUID> {
}
