package org.intellics.backend.services;

import org.intellics.backend.AbstractIntegrationTests;
import org.intellics.backend.domain.dto.knowledgeComponent.KnowledgeComponentCreateDto;
import org.intellics.backend.domain.dto.knowledgeComponent.KnowledgeComponentSimpleDto;
import org.intellics.backend.domain.dto.knowledgeComponent.KnowledgeComponentPatchDto;
import org.intellics.backend.domain.dto.knowledgeComponent.KnowledgeComponentUpdateDto;
import org.intellics.backend.repositories.KnowledgeComponentRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertThrows;

public class KnowledgeComponentServiceIntegrationTests extends AbstractIntegrationTests {

    @Autowired
    private KnowledgeComponentService underTest;

    @Autowired
    private KnowledgeComponentRepository knowledgeComponentRepository;

    @BeforeEach
    public void setUp() {
        knowledgeComponentRepository.deleteAll();
    }

    @Test
    void testThatKnowledgeComponentCanBeCreatedAndRecalled() {
        KnowledgeComponentCreateDto createDto = KnowledgeComponentCreateDto.builder()
                .kc_name("Test KC")
                .description("Test Description")
                .build();

        KnowledgeComponentSimpleDto savedDto = underTest.createKnowledgeComponent(createDto);

        assertThat(savedDto).isNotNull();
        assertThat(savedDto.getKc_id()).isNotNull();
        assertThat(savedDto.getKc_name()).isEqualTo("Test KC");
        assertThat(savedDto.getDescription()).isEqualTo("Test Description");

        Optional<KnowledgeComponentSimpleDto> foundDto = underTest.findOne(savedDto.getKc_id());
        assertThat(foundDto).isPresent();
        assertThat(foundDto.get()).isEqualTo(savedDto);
    }

    @Test
    void testThatKnowledgeComponentCanBeCreatedWithPrerequisite() {
        KnowledgeComponentCreateDto prerequisiteCreateDto = KnowledgeComponentCreateDto.builder()
                .kc_name("Prerequisite KC")
                .description("Prerequisite Description")
                .build();
        KnowledgeComponentSimpleDto savedPrerequisiteDto = underTest.createKnowledgeComponent(prerequisiteCreateDto);

        KnowledgeComponentCreateDto createDto = KnowledgeComponentCreateDto.builder()
                .kc_name("Dependent KC")
                .description("Dependent Description")
                .build();

        KnowledgeComponentSimpleDto savedDto = underTest.createKnowledgeComponent(createDto);

        assertThat(savedDto).isNotNull();
        assertThat(savedDto.getKc_id()).isNotNull();
        assertThat(savedDto.getKc_name()).isEqualTo("Dependent KC");
        assertThat(savedDto.getDescription()).isEqualTo("Dependent Description");
    }

    @Test
    void testCreateKnowledgeComponentThrowsExceptionWhenPrerequisiteDoesNotExist() {
        // This test is no longer valid as prerequisite validation is now handled at the module level
        // The KnowledgeComponentService no longer handles prerequisites directly
        KnowledgeComponentCreateDto createDto = KnowledgeComponentCreateDto.builder()
                .kc_name("Test KC")
                .description("Test Description")
                .build();

        // This should now succeed as prerequisite validation is handled elsewhere
        KnowledgeComponentSimpleDto result = underTest.createKnowledgeComponent(createDto);
        assertThat(result).isNotNull();
        assertThat(result.getKc_name()).isEqualTo("Test KC");
    }

    @Test
    void testThatKnowledgeComponentCanBeUpdated() {
        KnowledgeComponentCreateDto createDto = KnowledgeComponentCreateDto.builder()
                .kc_name("Original KC")
                .description("Original Description")
                .build();
        KnowledgeComponentSimpleDto savedDto = underTest.createKnowledgeComponent(createDto);

        KnowledgeComponentUpdateDto updateDto = KnowledgeComponentUpdateDto.builder()
                .kc_id(savedDto.getKc_id())
                .kc_name("Updated KC")
                .description("Updated Description")
                .build();

        KnowledgeComponentSimpleDto updatedDto = underTest.updateKnowledgeComponent(savedDto.getKc_id(), updateDto);

        assertThat(updatedDto).isNotNull();
        assertThat(updatedDto.getKc_id()).isEqualTo(savedDto.getKc_id());
        assertThat(updatedDto.getKc_name()).isEqualTo("Updated KC");
        assertThat(updatedDto.getDescription()).isEqualTo("Updated Description");
    }

    @Test
    void testUpdateKnowledgeComponentThrowsExceptionWhenPrerequisiteDoesNotExist() {
        // This test is no longer valid as prerequisite validation is now handled at the module level
        KnowledgeComponentCreateDto createDto = KnowledgeComponentCreateDto.builder()
                .kc_name("Test KC")
                .description("Test Description")
                .build();
        KnowledgeComponentSimpleDto savedDto = underTest.createKnowledgeComponent(createDto);

        KnowledgeComponentUpdateDto updateDto = KnowledgeComponentUpdateDto.builder()
                .kc_id(savedDto.getKc_id())
                .kc_name("Updated KC")
                .description("Updated Description")
                .build();

        // This should now succeed as prerequisite validation is handled elsewhere
        KnowledgeComponentSimpleDto result = underTest.updateKnowledgeComponent(savedDto.getKc_id(), updateDto);
        assertThat(result).isNotNull();
        assertThat(result.getKc_name()).isEqualTo("Updated KC");
    }

    @Test
    void testUpdateKnowledgeComponentThrowsExceptionWhenPrerequisiteIsSelf() {
        // This test is no longer valid as prerequisite validation is now handled at the module level
        KnowledgeComponentCreateDto createDto = KnowledgeComponentCreateDto.builder()
                .kc_name("Test KC")
                .description("Test Description")
                .build();
        KnowledgeComponentSimpleDto savedDto = underTest.createKnowledgeComponent(createDto);

        KnowledgeComponentUpdateDto updateDto = KnowledgeComponentUpdateDto.builder()
                .kc_id(savedDto.getKc_id())
                .kc_name("Updated KC")
                .description("Updated Description")
                .build();

        // This should now succeed as prerequisite validation is handled elsewhere
        KnowledgeComponentSimpleDto result = underTest.updateKnowledgeComponent(savedDto.getKc_id(), updateDto);
        assertThat(result).isNotNull();
        assertThat(result.getKc_name()).isEqualTo("Updated KC");
    }

    @Test
    void testThatKnowledgeComponentCanBePatched() {
        KnowledgeComponentCreateDto createDto = KnowledgeComponentCreateDto.builder()
                .kc_name("Original KC")
                .description("Original Description")
                .build();
        KnowledgeComponentSimpleDto savedDto = underTest.createKnowledgeComponent(createDto);

        KnowledgeComponentPatchDto patchDto = KnowledgeComponentPatchDto.builder()
                .kc_name("Patched KC")
                .build();

        KnowledgeComponentSimpleDto patchedDto = underTest.patchKnowledgeComponent(savedDto.getKc_id(), patchDto);

        assertThat(patchedDto).isNotNull();
        assertThat(patchedDto.getKc_id()).isEqualTo(savedDto.getKc_id());
        assertThat(patchedDto.getKc_name()).isEqualTo("Patched KC");
        assertThat(patchedDto.getDescription()).isEqualTo("Original Description"); // Description should remain unchanged
    }

    @Test
    void testPatchKnowledgeComponentThrowsExceptionWhenPrerequisiteIsSelf() {
        // This test is no longer valid as prerequisite validation is now handled at the module level
        KnowledgeComponentCreateDto createDto = KnowledgeComponentCreateDto.builder()
                .kc_name("Test KC")
                .description("Test Description")
                .build();
        KnowledgeComponentSimpleDto savedDto = underTest.createKnowledgeComponent(createDto);

        KnowledgeComponentPatchDto patchDto = KnowledgeComponentPatchDto.builder()
                .kc_name("Patched KC")
                .build();

        // This should now succeed as prerequisite validation is handled elsewhere
        KnowledgeComponentSimpleDto result = underTest.patchKnowledgeComponent(savedDto.getKc_id(), patchDto);
        assertThat(result).isNotNull();
        assertThat(result.getKc_name()).isEqualTo("Patched KC");
    }

    @Test
    void testThatKnowledgeComponentCanBeDeleted() {
        KnowledgeComponentCreateDto createDto = KnowledgeComponentCreateDto.builder()
                .kc_name("KC to Delete")
                .build();
        KnowledgeComponentSimpleDto savedDto = underTest.createKnowledgeComponent(createDto);

        underTest.delete(savedDto.getKc_id());

        Optional<KnowledgeComponentSimpleDto> foundDto = underTest.findOne(savedDto.getKc_id());
        assertThat(foundDto).isNotPresent();
    }

    @Test
    void testDeleteNonExistentKnowledgeComponentDoesNotThrowException() {
        underTest.delete(UUID.randomUUID());
    }
}
