package org.intellics.backend.domain.entities;

import jakarta.persistence.Embeddable;
import java.io.Serializable;
import java.util.UUID;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Embeddable
public class LessonKCMappingId implements Serializable {
    private UUID lesson_id;
    private UUID kc_id;
}
