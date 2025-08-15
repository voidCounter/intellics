-- Remove the search vector trigger
DROP TRIGGER IF EXISTS modules_search_vector_update ON modules;

-- Remove the search vector function
DROP FUNCTION IF EXISTS update_modules_search_vector();

-- Remove the search vector index
DROP INDEX IF EXISTS modules_search_idx;

-- Remove the search vector column
ALTER TABLE modules DROP COLUMN IF EXISTS search_vector;
