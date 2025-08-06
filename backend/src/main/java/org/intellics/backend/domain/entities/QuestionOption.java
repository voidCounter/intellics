package org.intellics.backend.domain.entities;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class QuestionOption {
    private String option_key;
    private String option_text;
    private String option_explanation;
}
