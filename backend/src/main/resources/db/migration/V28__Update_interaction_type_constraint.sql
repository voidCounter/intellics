-- V28: Update interaction_type constraint to match current enum values
-- The current constraint only allows old values, but the enum has been expanded

-- Drop the old constraint
ALTER TABLE user_interactions 
DROP CONSTRAINT IF EXISTS student_interactions_interaction_type_check;

-- Add the new constraint with all current enum values
ALTER TABLE user_interactions 
ADD CONSTRAINT user_interactions_interaction_type_check 
CHECK (interaction_type IN (
    'LESSON_START',
    'LESSON_EXIT', 
    'HINT_REQUESTED',
    'SCAFFOLD_REQUESTED',
    'SCAFFOLD_ATTEMPTED',
    'SCAFFOLD_ANSWER',
    'QUESTION_PRESENTED',
    'QUESTION_ATTEMPTED',
    'QUESTION_SKIPPED'
));


-- Add comment for clarity
COMMENT ON CONSTRAINT user_interactions_interaction_type_check ON user_interactions 
IS 'Ensures interaction_type values match the current InteractionType enum';
