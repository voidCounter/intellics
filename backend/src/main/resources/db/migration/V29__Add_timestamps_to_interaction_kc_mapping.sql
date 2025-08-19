-- Add timestamp fields to interaction_kc_mapping table for audit trail
ALTER TABLE interaction_kc_mapping 
ADD COLUMN created_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6);

ALTER TABLE interaction_kc_mapping 
ADD COLUMN updated_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6);

-- Add comments for documentation
COMMENT ON COLUMN interaction_kc_mapping.created_at IS 'Timestamp when this KC mapping was first created';
COMMENT ON COLUMN interaction_kc_mapping.updated_at IS 'Timestamp when this KC mapping was last updated';

-- Create index on created_at for efficient querying by creation time
CREATE INDEX idx_interaction_kc_mapping_created_at ON interaction_kc_mapping(created_at);

-- Create index on updated_at for efficient querying by update time
CREATE INDEX idx_interaction_kc_mapping_updated_at ON interaction_kc_mapping(updated_at);
