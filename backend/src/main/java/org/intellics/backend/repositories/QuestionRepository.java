package org.intellics.backend.repositories;

import java.util.UUID;
import org.intellics.backend.domain.entities.QuestionEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.PagingAndSortingRepository;

public interface QuestionRepository extends JpaRepository<QuestionEntity, UUID>,
    PagingAndSortingRepository<QuestionEntity, UUID> {
}
