package org.intellics.backend.services;

import java.util.UUID;
import org.intellics.backend.domain.entities.QuestionEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface QuestionService {
    QuestionEntity createQuestion(QuestionEntity questionEntity);
    
    QuestionEntity getQuestion(UUID question_id);
    
    Page<QuestionEntity> findAll(Pageable pageable);
}
