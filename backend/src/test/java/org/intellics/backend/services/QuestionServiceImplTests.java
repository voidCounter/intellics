package org.intellics.backend.services;

import static org.junit.Assert.assertThrows;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.util.Optional;
import java.util.UUID;
import org.intellics.backend.api.error.exceptions.ItemNotFoundException;
import org.intellics.backend.repositories.QuestionRepository;
import org.intellics.backend.services.impl.QuestionServiceImpl;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
public class QuestionServiceImplTests {
    @Mock
    private QuestionRepository questionRepository;
    
    @InjectMocks
    private QuestionServiceImpl underTest;
    
    @Test
    void getQuestionBYId_ShouldThrowItemNotFoundException_WhenQuestionDoesNotExist() {
        UUID id = UUID.randomUUID();
        when(questionRepository.findById(id)).thenReturn(Optional.empty());
        assertThrows(ItemNotFoundException.class, () -> underTest.getQuestion(id));
        verify(questionRepository, times(1)).findById(id);
    }
}
