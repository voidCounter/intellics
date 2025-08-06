package org.intellics.backend.services.impl;

import java.util.UUID;
import org.intellics.backend.api.error.exceptions.ItemNotFoundException;
import org.intellics.backend.domain.entities.QuestionEntity;
import org.intellics.backend.repositories.QuestionRepository;
import org.intellics.backend.services.QuestionService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
public class QuestionServiceImpl implements QuestionService {
    private final QuestionRepository questionRepository;
    
    public QuestionServiceImpl(QuestionRepository questionRepository) {
        this.questionRepository = questionRepository;
    }
    
    @Override
    public QuestionEntity createQuestion(QuestionEntity questionEntity) {
        return questionRepository.save(questionEntity);
    }
    
    @Override
    public Page<QuestionEntity> findAll(Pageable pageable) {
        return questionRepository.findAll(pageable);
    }
    
    @Override
    public QuestionEntity getQuestion(UUID question_id) {
        return questionRepository.findById(question_id).orElseThrow(() -> new ItemNotFoundException(
            "Question " +
                "not found!"));
    }
    
    
}
