package org.intellics.backend.api;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ApiResponseDto<T> {
    private ApiResponseStatus status;
    private T data;
    private String message;
}

