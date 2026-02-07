-- Increase text field limits for better question support

-- Update questions table - increase limits for question text and hints
ALTER TABLE questions 
    ALTER COLUMN question_text TYPE TEXT USING question_text::TEXT,
    ALTER COLUMN hint_level_1 TYPE TEXT USING hint_level_1::TEXT,
    ALTER COLUMN hint_level_2 TYPE TEXT USING hint_level_2::TEXT;

-- Update written_questions table - increase limits for answers and explanations  
ALTER TABLE written_questions
    ALTER COLUMN correct_answer_text TYPE TEXT USING correct_answer_text::TEXT,
    ALTER COLUMN answer_explanation TYPE TEXT USING answer_explanation::TEXT;

-- Update scaffolds table - increase limits for scaffold text and answers
ALTER TABLE scaffolds
    ALTER COLUMN scaffold_text TYPE TEXT USING scaffold_text::TEXT,
    ALTER COLUMN scaffold_correct_answer TYPE TEXT USING scaffold_correct_answer::TEXT;
