-- Add timestamp fields to interaction_kc_mapping table for audit trail
ALTER TABLE interaction_kc_mapping 
ADD COLUMN IF NOT EXISTS created_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6);

ALTER TABLE interaction_kc_mapping 
ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6);

-- Add comments for documentation
COMMENT ON COLUMN interaction_kc_mapping.created_at IS 'Timestamp when this KC mapping was first created';
COMMENT ON COLUMN interaction_kc_mapping.updated_at IS 'Timestamp when this KC mapping was last updated';

-- Create index on created_at for efficient querying by creation time
CREATE INDEX IF NOT EXISTS idx_interaction_kc_mapping_created_at ON interaction_kc_mapping(created_at);

-- Create index on updated_at for efficient querying by update time
CREATE INDEX IF NOT EXISTS idx_interaction_kc_mapping_updated_at ON interaction_kc_mapping(updated_at);
