package org.intellics.backend.domain.dto;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotEmpty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ModuleLessonOrderUpdateDto {
    
    @NotEmpty(message = "Lesson order list cannot be empty")
    @Valid
    private List<LessonOrderItem> lessonOrders;
    
    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    @Builder
    public static class LessonOrderItem {
        private UUID lessonId;
        private Integer orderIndex;
    }
}
