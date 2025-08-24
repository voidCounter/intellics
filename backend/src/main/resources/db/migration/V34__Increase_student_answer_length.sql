-- Increase student_answer field length to accommodate longer written answers
-- This is needed for LLM-based evaluation where answers can be quite long

ALTER TABLE user_interactions 
ALTER COLUMN student_answer TYPE varchar(2000);

-- Add comment to document the change
COMMENT ON COLUMN user_interactions.student_answer IS 'Student answer text, increased from 255 to 2000 characters to support longer written answers';
