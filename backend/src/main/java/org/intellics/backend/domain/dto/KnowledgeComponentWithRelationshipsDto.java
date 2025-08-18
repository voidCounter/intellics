package org.intellics.backend.domain.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.Instant;
import java.util.List;
import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class KnowledgeComponentWithRelationshipsDto {
    private UUID kc_id;
    private String kc_name;
    private String description;
    
    private Instant created_at;
    private Instant updated_at;
    
    private List<LinkedModuleDto> linkedModules;
    private List<LinkedLessonDto> linkedLessons;
    private List<LinkedQuestionDto> linkedQuestions;
    
    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    @Builder
    public static class LinkedModuleDto {
        private UUID module_id;
        private String module_name;
    }
    
    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    @Builder
    public static class LinkedLessonDto {
        private UUID lesson_id;
        private String lesson_name;
        private Double target_mastery;
    }
    
    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    @Builder
    public static class LinkedQuestionDto {
        private UUID question_id;
        private String question_text;
        private Double weight;
    }
}
