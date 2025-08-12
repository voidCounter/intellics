-- V15: Rename student tables to user tables for consistency
-- This migration renames tables to use "user" instead of "student" prefix

-- Rename student_interactions to user_interactions
ALTER TABLE student_interactions RENAME TO user_interactions;

-- Rename studentkcmastery to user_kc_mastery (more readable)
ALTER TABLE studentkcmastery RENAME TO user_kc_mastery;

-- Update foreign key constraint references in interaction_kc_mapping
-- (The constraint should automatically update, but let's be explicit)
ALTER TABLE interaction_kc_mapping 
DROP CONSTRAINT interaction_kc_mapping_interaction_id_fkey;

ALTER TABLE interaction_kc_mapping 
ADD CONSTRAINT interaction_kc_mapping_interaction_id_fkey 
FOREIGN KEY (interaction_id) REFERENCES user_interactions(interaction_id) ON DELETE CASCADE;

-- Add comments for clarity
COMMENT ON TABLE user_interactions IS 'Records all user learning interactions across the platform (lessons, questions, scaffolds, hints)';
COMMENT ON TABLE user_kc_mastery IS 'Tracks individual user mastery levels for each Knowledge Component using BKT parameters';
COMMENT ON TABLE interaction_kc_mapping IS 'Maps user interactions to Knowledge Components with impact weights for mastery calculations';
