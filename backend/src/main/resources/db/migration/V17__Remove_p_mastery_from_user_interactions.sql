-- Remove p_mastery column from user_interactions table
-- Mastery is now handled per KC per interaction in the interaction_kc_mapping table
ALTER TABLE user_interactions DROP COLUMN p_mastery;
