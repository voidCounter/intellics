package org.intellics.backend.controllers;

import static org.assertj.core.api.Assertions.assertThat;

import org.intellics.backend.AbstractIntegrationTests;
import org.intellics.backend.TestDataUtil;
import org.intellics.backend.domain.dto.MultipleChoiceQuestionDto;
import org.intellics.backend.domain.entities.MultipleChoicequestionEntity;
import org.intellics.backend.domain.entities.QuestionEntity;
import org.intellics.backend.domain.entities.QuestionType;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.http.MediaType;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import org.springframework.transaction.annotation.Transactional;
import org.testcontainers.shaded.com.fasterxml.jackson.databind.ObjectMapper;

@ExtendWith(SpringExtension.class)
@Transactional
@AutoConfigureMockMvc
public class QuestionControllerIntegrationTests extends AbstractIntegrationTests {
    private final MockMvc mockMvc;
    private final ObjectMapper objectMapper;
    
    @Autowired
    public QuestionControllerIntegrationTests(MockMvc mockMvc) {
        this.mockMvc = mockMvc;
        this.objectMapper = new ObjectMapper();
    }
    
    @Test
    void testThatCreateQuestionSuccessfullyReturnsHttp201Created() throws Exception {
        QuestionEntity questionEntity =
            TestDataUtil.createTestQuestion(QuestionType.MULTIPLE_CHOICE);
        String questionJson = objectMapper.writeValueAsString(questionEntity);
        mockMvc.perform(
            MockMvcRequestBuilders.post("/questions")
                .contentType(MediaType.APPLICATION_JSON)
                .content(questionJson)
        ).andExpect(
            MockMvcResultMatchers.status().isCreated()
        );
    }
    
    @Test
    void testThatCreateQuestionSuccessfullyReturnsSavedQuestion() throws Exception {
        // arrange
        QuestionEntity questionEntity =
            TestDataUtil.createTestQuestion(QuestionType.MULTIPLE_CHOICE);
        String questionJson = objectMapper.writeValueAsString(questionEntity);
        // act
        MvcResult result = mockMvc.perform(
            MockMvcRequestBuilders.post("/questions")
                .contentType(MediaType.APPLICATION_JSON)
                .content(questionJson)
        ).andReturn();
        String response = result.getResponse().getContentAsString();
        MultipleChoiceQuestionDto dto = objectMapper.readValue(response,
            MultipleChoiceQuestionDto.class);
        questionEntity.setQuestion_id(dto.getQuestion_id());
        assertThat(questionEntity).usingRecursiveComparison()
            .ignoringFields("type").isEqualTo(dto);
    }
}
