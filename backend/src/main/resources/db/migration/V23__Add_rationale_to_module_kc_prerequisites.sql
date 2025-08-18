-- Add rationale field to module_kc_prerequisite table
-- This field explains why a particular KC was selected as a prerequisite
ALTER TABLE module_kc_prerequisite 
ADD COLUMN rationale TEXT;

-- Add a comment to document the purpose of this field
COMMENT ON COLUMN module_kc_prerequisite.rationale IS 'Explanation of why this KC was selected as a prerequisite for another KC in the module';
