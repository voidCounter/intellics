package org.intellics.backend.domain.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Embeddable
public class ModuleLessonMappingId implements Serializable {
    @Column(name = "module_id")
    private UUID moduleId;

    @Column(name = "lesson_id")
    private UUID lessonId;
}
