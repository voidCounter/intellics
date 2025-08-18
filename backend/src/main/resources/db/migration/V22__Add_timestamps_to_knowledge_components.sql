-- Add created_at and updated_at columns to knowledge_components table
ALTER TABLE knowledge_components 
ADD COLUMN created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE knowledge_components 
ADD COLUMN updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP;

-- Update existing records to have current timestamp
UPDATE knowledge_components SET created_at = CURRENT_TIMESTAMP, updated_at = CURRENT_TIMESTAMP;

-- Create a function to automatically update the updated_at column
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Create a trigger to automatically update the updated_at column
CREATE TRIGGER update_knowledge_components_updated_at 
    BEFORE UPDATE ON knowledge_components 
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column();

-- Add indexes for better query performance
CREATE INDEX idx_knowledge_components_created_at ON knowledge_components(created_at);
CREATE INDEX idx_knowledge_components_updated_at ON knowledge_components(updated_at);
