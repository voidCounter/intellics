package org.intellics.backend.domain.entities;

import java.io.Serializable;
import java.util.Objects;
import java.util.UUID;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class InteractionKCMappingId implements Serializable {
    private UUID interaction;
    private UUID knowledgeComponent;
    
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        InteractionKCMappingId that = (InteractionKCMappingId) o;
        return Objects.equals(interaction, that.interaction) && 
               Objects.equals(knowledgeComponent, that.knowledgeComponent);
    }
    
    @Override
    public int hashCode() {
        return Objects.hash(interaction, knowledgeComponent);
    }
}
