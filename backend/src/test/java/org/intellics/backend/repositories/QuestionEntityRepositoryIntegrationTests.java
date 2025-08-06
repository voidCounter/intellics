package org.intellics.backend.repositories;

import static org.assertj.core.api.Assertions.assertThat;

import java.util.Optional;
import org.intellics.backend.AbstractIntegrationTests;
import org.intellics.backend.TestDataUtil;
import org.intellics.backend.domain.entities.QuestionEntity;
import org.intellics.backend.domain.entities.QuestionType;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

public class QuestionEntityRepositoryIntegrationTests extends AbstractIntegrationTests {
    private QuestionRepository underTest;
    
    @Autowired
    public QuestionEntityRepositoryIntegrationTests(QuestionRepository underTest) {
        this.underTest = underTest;
    }
    
    @Test
    public void testThatMultipleChoiceQuestionCanBeSaved() {
        QuestionEntity questionEntity = TestDataUtil.createTestQuestion(QuestionType.MULTIPLE_CHOICE);
        underTest.save(questionEntity);
        Optional<QuestionEntity> result = underTest.findById(questionEntity.getQuestion_id());
        assertThat(result).isPresent();
        assertThat(result.get()).isEqualTo(questionEntity);
    }
}
