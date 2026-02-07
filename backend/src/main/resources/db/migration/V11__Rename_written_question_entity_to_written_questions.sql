-- Rename written_question_entity table to written_questions
DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM pg_tables WHERE tablename = 'written_question_entity') THEN
        ALTER TABLE written_question_entity RENAME TO written_questions;
    END IF;
END;
$$;
