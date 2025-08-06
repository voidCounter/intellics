package org.intellics.backend.domain.entities;

public enum QuestionType {
    MULTIPLE_CHOICE("Multiple Choice"), WRITTEN("Written");
    private final String displayValue;
    
    QuestionType(String displayValue) {
        this.displayValue = displayValue;
    }
    
    public String getDisplayValue() {
        return displayValue;
    }
}

