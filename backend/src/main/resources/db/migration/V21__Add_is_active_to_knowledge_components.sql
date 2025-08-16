-- Add is_active column to knowledge_components table for soft delete functionality
ALTER TABLE knowledge_components 
ADD COLUMN is_active BOOLEAN NOT NULL DEFAULT TRUE;

-- Add index on is_active for better query performance
CREATE INDEX idx_knowledge_components_is_active ON knowledge_components(is_active);

-- Update existing records to be active by default
UPDATE knowledge_components SET is_active = TRUE WHERE is_active IS NULL;
