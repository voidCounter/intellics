package org.intellics.backend.domain.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.intellics.backend.domain.dto.knowledgeComponent.KnowledgeComponentSimpleDto;

import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class LessonWithKCsDto {
    private UUID lesson_id;
    private String lesson_name;
    private String lesson_content;
    private List<LessonKCInfoDto> knowledgeComponents;
    
    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    @Builder
    public static class LessonKCInfoDto {
        private UUID kcId;
        private String kcName;
        private String description;
        private BigDecimal targetMastery;
    }
}
