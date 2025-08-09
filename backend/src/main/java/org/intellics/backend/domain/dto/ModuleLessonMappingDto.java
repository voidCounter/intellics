package org.intellics.backend.domain.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ModuleLessonMappingDto {
    private UUID moduleId;
    private UUID lessonId;
    private String moduleName;
    private String lessonName;
    private Integer orderIndex;
}
