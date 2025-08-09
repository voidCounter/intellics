package org.intellics.backend.services.impl;

import java.util.List;
import java.util.UUID;
import org.intellics.backend.api.error.exceptions.ItemNotFoundException;
import org.intellics.backend.domain.entities.QuestionEntity;
import org.intellics.backend.domain.entities.Scaffold;
import org.intellics.backend.repositories.ScaffoldRepository;
import org.intellics.backend.services.QuestionService;
import org.intellics.backend.services.ScaffoldService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class ScaffoldServiceImpl implements ScaffoldService {
    
    private final ScaffoldRepository scaffoldRepository;
    private final QuestionService questionService;
    
    public ScaffoldServiceImpl(ScaffoldRepository scaffoldRepository, QuestionService questionService) {
        this.scaffoldRepository = scaffoldRepository;
        this.questionService = questionService;
    }
    
    @Override
    public Scaffold createScaffold(UUID questionId, Scaffold scaffold) {
        QuestionEntity question = questionService.getQuestion(questionId);
        
        // Set the order index to be the next available position
        int nextOrderIndex = scaffoldRepository.countByQuestionQuestionId(questionId);
        scaffold.setOrder_index(nextOrderIndex);
        
        scaffold.setQuestion(question);
        return scaffoldRepository.save(scaffold);
    }
    
    @Override
    @Transactional(readOnly = true)
    public List<Scaffold> getScaffoldsByQuestionId(UUID questionId) {
        // Verify question exists
        questionService.getQuestion(questionId);
        return scaffoldRepository.findByQuestionQuestionIdOrderByOrderIndex(questionId);
    }
    
    @Override
    @Transactional(readOnly = true)
    public Scaffold getScaffold(UUID questionId, UUID scaffoldId) {
        // Verify question exists
        questionService.getQuestion(questionId);
        
        Scaffold scaffold = scaffoldRepository.findByQuestionQuestionIdAndScaffoldId(questionId, scaffoldId);
        if (scaffold == null) {
            throw new ItemNotFoundException("Scaffold not found with id: " + scaffoldId + " for question: " + questionId);
        }
        return scaffold;
    }
    
    @Override
    public Scaffold updateScaffold(UUID questionId, UUID scaffoldId, Scaffold updatedScaffold) {
        Scaffold existingScaffold = getScaffold(questionId, scaffoldId);
        
        // Update fields but preserve the question relationship and order
        existingScaffold.setScaffold_text(updatedScaffold.getScaffold_text());
        existingScaffold.setScaffold_correct_answer(updatedScaffold.getScaffold_correct_answer());
        
        return scaffoldRepository.save(existingScaffold);
    }
    
    @Override
    public void deleteScaffold(UUID questionId, UUID scaffoldId) {
        Scaffold scaffold = getScaffold(questionId, scaffoldId);
        scaffoldRepository.delete(scaffold);
        
        // Reorder remaining scaffolds to fill the gap
        List<Scaffold> remainingScaffolds = scaffoldRepository.findByQuestionQuestionIdOrderByOrderIndex(questionId);
        for (int i = 0; i < remainingScaffolds.size(); i++) {
            remainingScaffolds.get(i).setOrder_index(i);
        }
        scaffoldRepository.saveAll(remainingScaffolds);
    }
    
    @Override
    public List<Scaffold> reorderScaffolds(UUID questionId, List<UUID> scaffoldIds) {
        // Verify question exists
        questionService.getQuestion(questionId);
        
        List<Scaffold> scaffolds = scaffoldRepository.findByQuestionQuestionIdOrderByOrderIndex(questionId);
        
        // Validate that all scaffold IDs belong to this question
        if (scaffolds.size() != scaffoldIds.size()) {
            throw new IllegalArgumentException("Number of scaffold IDs must match existing scaffolds count");
        }
        
        for (UUID scaffoldId : scaffoldIds) {
            boolean found = scaffolds.stream()
                .anyMatch(s -> s.getScaffold_id().equals(scaffoldId));
            if (!found) {
                throw new ItemNotFoundException("Scaffold not found with id: " + scaffoldId + " for question: " + questionId);
            }
        }
        
        // Update order indices
        for (int i = 0; i < scaffoldIds.size(); i++) {
            UUID scaffoldId = scaffoldIds.get(i);
            Scaffold scaffold = scaffolds.stream()
                .filter(s -> s.getScaffold_id().equals(scaffoldId))
                .findFirst()
                .orElseThrow();
            scaffold.setOrder_index(i);
        }
        
        return scaffoldRepository.saveAll(scaffolds);
    }
}
