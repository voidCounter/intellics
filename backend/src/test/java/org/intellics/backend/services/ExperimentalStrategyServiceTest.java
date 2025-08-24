package org.intellics.backend.services;

import org.intellics.backend.domain.entities.ExperimentalStrategy;
import org.intellics.backend.services.impl.ExperimentalStrategyServiceImpl;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.intellics.backend.repositories.ExperimentalStrategyRepository;

import java.util.Optional;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class ExperimentalStrategyServiceTest {

    @Mock
    private ExperimentalStrategyRepository experimentalStrategyRepository;

    @InjectMocks
    private ExperimentalStrategyServiceImpl experimentalStrategyService;

    @Test
    void testCreateStrategy() {
        // Given
        ExperimentalStrategy strategy = ExperimentalStrategy.builder()
            .strategyName("TEST_STRATEGY")
            .description("Test strategy for unit testing")
            .build();

        when(experimentalStrategyRepository.existsByStrategyName("TEST_STRATEGY")).thenReturn(false);
        when(experimentalStrategyRepository.save(any(ExperimentalStrategy.class))).thenReturn(strategy);

        // When
        ExperimentalStrategy result = experimentalStrategyService.createStrategy(strategy);

        // Then
        assertNotNull(result);
        assertEquals("TEST_STRATEGY", result.getStrategyName());
        assertEquals("Test strategy for unit testing", result.getDescription());
        assertTrue(result.getIsActive());
        assertNotNull(result.getCreatedAt());
        assertNotNull(result.getUpdatedAt());

        verify(experimentalStrategyRepository).existsByStrategyName("TEST_STRATEGY");
        verify(experimentalStrategyRepository).save(any(ExperimentalStrategy.class));
    }

    @Test
    void testCreateStrategyWithDuplicateName() {
        // Given
        ExperimentalStrategy strategy = ExperimentalStrategy.builder()
            .strategyName("DUPLICATE_STRATEGY")
            .description("Test strategy")
            .build();

        when(experimentalStrategyRepository.existsByStrategyName("DUPLICATE_STRATEGY")).thenReturn(true);

        // When & Then
        assertThrows(IllegalArgumentException.class, () -> {
            experimentalStrategyService.createStrategy(strategy);
        });

        verify(experimentalStrategyRepository).existsByStrategyName("DUPLICATE_STRATEGY");
        verify(experimentalStrategyRepository, never()).save(any(ExperimentalStrategy.class));
    }

    @Test
    void testGetStrategyById() {
        // Given
        UUID strategyId = UUID.randomUUID();
        ExperimentalStrategy strategy = ExperimentalStrategy.builder()
            .strategyId(strategyId)
            .strategyName("TEST_STRATEGY")
            .build();

        when(experimentalStrategyRepository.findById(strategyId)).thenReturn(Optional.of(strategy));

        // When
        Optional<ExperimentalStrategy> result = experimentalStrategyService.getStrategyById(strategyId);

        // Then
        assertTrue(result.isPresent());
        assertEquals(strategyId, result.get().getStrategyId());
        assertEquals("TEST_STRATEGY", result.get().getStrategyName());

        verify(experimentalStrategyRepository).findById(strategyId);
    }

    @Test
    void testGetStrategyByIdNotFound() {
        // Given
        UUID strategyId = UUID.randomUUID();
        when(experimentalStrategyRepository.findById(strategyId)).thenReturn(Optional.empty());

        // When
        Optional<ExperimentalStrategy> result = experimentalStrategyService.getStrategyById(strategyId);

        // Then
        assertFalse(result.isPresent());

        verify(experimentalStrategyRepository).findById(strategyId);
    }
}
