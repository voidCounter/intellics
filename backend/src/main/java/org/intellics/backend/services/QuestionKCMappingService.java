package org.intellics.backend.services;

import org.intellics.backend.domain.dto.QuestionKCMappingDto;

import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;

public interface QuestionKCMappingService {
    List<QuestionKCMappingDto> getKCsByQuestionId(UUID questionId);
    QuestionKCMappingDto addKCToQuestion(UUID questionId, UUID kcId, double weight);
    QuestionKCMappingDto updateQuestionKCWeight(UUID questionId, UUID kcId, BigDecimal weight);
    void removeKCFromQuestion(UUID questionId, UUID kcId);
}
