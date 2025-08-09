package org.intellics.backend;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import org.intellics.backend.domain.entities.Module;
import org.intellics.backend.domain.entities.MultipleChoiceQuestionEntity;
import org.intellics.backend.domain.entities.QuestionEntity;
import org.intellics.backend.domain.entities.QuestionOption;
import org.intellics.backend.domain.entities.QuestionType;
import org.intellics.backend.domain.entities.WrittenQuestionEntity;

public final class TestDataUtil {
    public static Module createTestModule() {
        return Module.builder().module_name("OOP").description("Object " +
            "Oriented Programming").build();
    }
    
    public static QuestionEntity createTestQuestion(QuestionType questionType) {
        return switch (questionType) {
            case MULTIPLE_CHOICE -> {
                QuestionOption option1 =
                    QuestionOption.builder().option_text("a").option_explanation("b").build();
                QuestionOption option2 =
                    QuestionOption.builder().option_text("b").option_explanation("b").build();
                QuestionOption option3 =
                    QuestionOption.builder().option_text("c").option_explanation("b").build();
                QuestionOption option4 =
                    QuestionOption.builder().option_text("d").option_explanation("b").build();
                yield MultipleChoiceQuestionEntity.builder().question_text("What is " +
                        "happening?").options(List.of(option1, option2, option3, option4))
                    .correct_option_key("a").build();
            }
            case WRITTEN -> WrittenQuestionEntity.builder().question_text("What is happening?")
                .correct_answer_text("a").build();
        };
    }
    
    public static List<Module> createTestModule(int number) {
        List<Module> list = new ArrayList<>();
        while (number > 0) {
            list.add(
                Module.builder().module_name(UUID.randomUUID().toString())
                    .description("Another module").build());
            number--;
        }
        return list;
    }
    
}
