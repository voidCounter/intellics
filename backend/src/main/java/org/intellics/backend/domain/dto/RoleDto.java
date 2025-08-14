package org.intellics.backend.domain.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.intellics.backend.domain.enums.RoleName;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RoleDto {
    private RoleName name;
}
