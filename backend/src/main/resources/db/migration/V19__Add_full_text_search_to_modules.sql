-- Add full-text search vector column to modules table
ALTER TABLE modules ADD COLUMN search_vector tsvector;

-- Create a GIN index for fast full-text search
CREATE INDEX modules_search_idx ON modules USING GIN(search_vector);

-- Update existing modules with search vectors
UPDATE modules SET search_vector = 
  to_tsvector('english', module_name || ' ' || COALESCE(description, ''));

-- Create a function to automatically update search vector
CREATE OR REPLACE FUNCTION update_modules_search_vector()
RETURNS TRIGGER AS $$
BEGIN
  NEW.search_vector := to_tsvector('english', NEW.module_name || ' ' || COALESCE(NEW.description, ''));
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger to automatically update search vector
CREATE TRIGGER modules_search_vector_update
  BEFORE INSERT OR UPDATE ON modules
  FOR EACH ROW
  EXECUTE FUNCTION update_modules_search_vector();
