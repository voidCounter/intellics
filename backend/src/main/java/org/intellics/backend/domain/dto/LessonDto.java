package org.intellics.backend.domain.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class LessonDto {
    private UUID lesson_id;
    
    @NotBlank(message = "Lesson name cannot be blank")
    @Size(max = 255, message = "Lesson name cannot exceed 255 characters")
    private String lesson_name;
    
    @NotBlank(message = "Lesson content cannot be blank")
    @Size(max = 10000, message = "Lesson content cannot exceed 10000 characters")
    private String lesson_content;
    
    private UUID module_id;
}
