package org.intellics.backend.services.impl;

import org.intellics.backend.api.error.exceptions.ItemNotFoundException;
import org.intellics.backend.domain.dto.QuestionKCMappingDto;
import org.intellics.backend.domain.entities.KnowledgeComponent;
import org.intellics.backend.domain.entities.QuestionEntity;
import org.intellics.backend.domain.entities.QuestionKCMapping;
import org.intellics.backend.domain.entities.QuestionKCMappingId;
import org.intellics.backend.mappers.QuestionKCMappingMapper;
import org.intellics.backend.repositories.KnowledgeComponentRepository;
import org.intellics.backend.repositories.QuestionKCMappingRepository;
import org.intellics.backend.repositories.QuestionRepository;
import org.intellics.backend.services.QuestionKCMappingService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

@Service
@Transactional
public class QuestionKCMappingServiceImpl implements QuestionKCMappingService {
    
    private final QuestionKCMappingRepository questionKCMappingRepository;
    private final QuestionRepository questionRepository;
    private final KnowledgeComponentRepository knowledgeComponentRepository;
    private final QuestionKCMappingMapper questionKCMappingMapper;
    
    public QuestionKCMappingServiceImpl(QuestionKCMappingRepository questionKCMappingRepository,
                                       QuestionRepository questionRepository,
                                       KnowledgeComponentRepository knowledgeComponentRepository,
                                       QuestionKCMappingMapper questionKCMappingMapper) {
        this.questionKCMappingRepository = questionKCMappingRepository;
        this.questionRepository = questionRepository;
        this.knowledgeComponentRepository = knowledgeComponentRepository;
        this.questionKCMappingMapper = questionKCMappingMapper;
    }
    
    @Override
    public List<QuestionKCMappingDto> getKCsByQuestionId(UUID questionId) {
        // Validate question exists
        questionRepository.findById(questionId)
            .orElseThrow(() -> new ItemNotFoundException("Question not found!"));
        
        List<QuestionKCMapping> mappings = questionKCMappingRepository.findByQuestionId(questionId);
        return mappings.stream()
            .map(questionKCMappingMapper::mapTo)
            .toList();
    }
    
    @Override
    public QuestionKCMappingDto addKCToQuestion(UUID questionId, UUID kcId, double weight) {
        // Validate that both question and KC exist
        QuestionEntity question = questionRepository.findById(questionId)
            .orElseThrow(() -> new ItemNotFoundException("Question not found!"));
        KnowledgeComponent kc = knowledgeComponentRepository.findById(kcId)
            .orElseThrow(() -> new ItemNotFoundException("Knowledge Component not found!"));
        
        // Check if mapping already exists
        if (questionKCMappingRepository.existsByQuestionIdAndKcId(questionId, kcId)) {
            throw new IllegalArgumentException("Question is already mapped to this Knowledge Component");
        }
        
        // Create new mapping
        QuestionKCMappingId mappingId = QuestionKCMappingId.builder()
            .question_id(questionId)
            .kc_id(kcId)
            .build();
            
        QuestionKCMapping mapping = QuestionKCMapping.builder()
            .mappingId(mappingId)
            .question(question)
            .knowledge_component(kc)
            .weight(weight)
            .build();
            
        QuestionKCMapping savedMapping = questionKCMappingRepository.save(mapping);
        return questionKCMappingMapper.mapTo(savedMapping);
    }
    
    @Override
    public void removeKCFromQuestion(UUID questionId, UUID kcId) {
        if (!questionKCMappingRepository.existsByQuestionIdAndKcId(questionId, kcId)) {
            throw new ItemNotFoundException("Question-KC mapping not found!");
        }
        
        QuestionKCMappingId mappingId = QuestionKCMappingId.builder()
            .question_id(questionId)
            .kc_id(kcId)
            .build();
            
        questionKCMappingRepository.deleteById(mappingId);
    }
}
