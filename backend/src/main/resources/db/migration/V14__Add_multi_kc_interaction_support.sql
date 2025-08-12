-- V14: Add multi-KC interaction support and module context
-- This migration:
-- 1. Adds module_id to student_interactions for full learning path context
-- 2. Creates interaction_kc_mapping table for multi-KC support
-- 3. Removes kc_id from student_interactions (moved to interaction_kc_mapping)
-- 4. Keeps time_spent_seconds as optional for individual question thinking time

-- Add module_id to student_interactions for learning path context
ALTER TABLE student_interactions 
ADD COLUMN module_id UUID REFERENCES modules(module_id);

-- Create interaction_kc_mapping table for multi-KC support
CREATE TABLE interaction_kc_mapping (
    interaction_id UUID NOT NULL REFERENCES student_interactions(interaction_id) ON DELETE CASCADE,
    kc_id UUID NOT NULL REFERENCES knowledge_components(kc_id) ON DELETE CASCADE,
    weight DOUBLE PRECISION NOT NULL DEFAULT 1.0,
    kc_mastery_before DOUBLE PRECISION,
    kc_mastery_after DOUBLE PRECISION,
    
    PRIMARY KEY (interaction_id, kc_id)
);

-- Create index for efficient KC-based queries
CREATE INDEX idx_interaction_kc_mapping_kc_id ON interaction_kc_mapping(kc_id);
CREATE INDEX idx_interaction_kc_mapping_interaction_id ON interaction_kc_mapping(interaction_id);

-- Migrate existing data: move kc_id from student_interactions to interaction_kc_mapping
-- Only migrate records that have a kc_id (some might be null)
INSERT INTO interaction_kc_mapping (interaction_id, kc_id, weight, kc_mastery_before, kc_mastery_after)
SELECT 
    interaction_id, 
    kc_id, 
    1.0 as weight,  -- Default weight for existing data
    p_mastery as kc_mastery_before,  -- Use existing p_mastery as before value
    p_mastery as kc_mastery_after    -- Use existing p_mastery as after value
FROM student_interactions 
WHERE kc_id IS NOT NULL;

-- Remove kc_id column from student_interactions (data is now in interaction_kc_mapping)
ALTER TABLE student_interactions DROP COLUMN kc_id;

-- Add comments for documentation
COMMENT ON TABLE interaction_kc_mapping IS 'Maps interactions to Knowledge Components with weights. Supports both single-KC (most common) and multi-KC scenarios.';
COMMENT ON COLUMN interaction_kc_mapping.weight IS 'Weight of this KC in the interaction. From question_kc_mapping.weight or 1.0 for lesson KCs.';
COMMENT ON COLUMN interaction_kc_mapping.kc_mastery_before IS 'Student KC mastery before this interaction occurred.';
COMMENT ON COLUMN interaction_kc_mapping.kc_mastery_after IS 'Student KC mastery after this interaction occurred.';
COMMENT ON COLUMN student_interactions.module_id IS 'Module context for this interaction, enables module-level analytics.';
COMMENT ON COLUMN student_interactions.p_mastery IS 'Average mastery across all KCs involved in this interaction.';
