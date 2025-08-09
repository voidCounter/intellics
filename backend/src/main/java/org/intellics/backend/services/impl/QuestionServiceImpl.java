package org.intellics.backend.services.impl;

import java.util.UUID;
import org.intellics.backend.api.error.exceptions.ItemNotFoundException;
import org.intellics.backend.domain.entities.QuestionEntity;
import org.intellics.backend.repositories.QuestionRepository;
import org.intellics.backend.services.QuestionService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
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
            "Question not found!"));
    }
    
    @Override
    public QuestionEntity updateQuestion(UUID question_id, QuestionEntity questionEntity) {
        QuestionEntity existingQuestion = getQuestion(question_id);
        
        // Verify the question type matches (can't change type)
        if (!existingQuestion.getType().equals(questionEntity.getType())) {
            throw new IllegalArgumentException("Cannot change question type during update");
        }
        
        // Set the ID to ensure we're updating the existing entity
        questionEntity.setQuestion_id(question_id);
        
        // Just save the complete updated question - simple and straightforward
        return questionRepository.save(questionEntity);
    }
    
    @Override
    public void deleteQuestion(UUID question_id) {
        QuestionEntity question = getQuestion(question_id);
        questionRepository.delete(question);
    }
}
