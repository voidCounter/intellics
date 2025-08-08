-- Update lesson_kc_mapping table to change target_mastery from bigint to decimal
ALTER TABLE lesson_kc_mapping 
ALTER COLUMN target_mastery TYPE DECIMAL(3,2);

-- Add constraint to ensure target_mastery is between 0.01 and 1.00
ALTER TABLE lesson_kc_mapping 
ADD CONSTRAINT chk_target_mastery_range 
CHECK (target_mastery >= 0.01 AND target_mastery <= 1.00);
