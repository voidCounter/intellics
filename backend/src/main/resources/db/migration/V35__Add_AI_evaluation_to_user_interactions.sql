-- Migration: Add AI evaluation results to user_interactions table
-- This allows us to store the LLM's correctness score and detailed analysis
-- for better learning analytics and insights

-- Add answer_correctness column (0.0 to 1.0 score from AI evaluation)
ALTER TABLE user_interactions 
ADD COLUMN answer_correctness DECIMAL(3,2) CHECK (answer_correctness >= 0.0 AND answer_correctness <= 1.0);

-- Add answer_analysis column (detailed AI feedback and analysis)
ALTER TABLE user_interactions 
ADD COLUMN answer_analysis TEXT;

-- Add comments for documentation
COMMENT ON COLUMN user_interactions.answer_correctness IS 'AI-evaluated correctness score from 0.0 to 1.0, where 0.0 is completely wrong and 1.0 is perfect';
COMMENT ON COLUMN user_interactions.answer_analysis IS 'Detailed AI analysis and feedback explaining the correctness score and providing constructive guidance';

-- Update the table comment to reflect the new purpose
COMMENT ON TABLE user_interactions IS 'Records all user learning interactions across the platform (lessons, questions, scaffolds, hints) with AI evaluation results';
