-- Add short_description field to lessons table for module page previews
ALTER TABLE lessons ADD COLUMN IF NOT EXISTS short_description VARCHAR(500);

-- Update existing lessons with a default short description based on lesson_content
UPDATE lessons 
SET short_description = CASE 
    WHEN LENGTH(lesson_content) > 150 THEN 
        CONCAT(LEFT(lesson_content, 147), '...')
    ELSE 
        lesson_content
    END
WHERE short_description IS NULL;

-- Make the field NOT NULL after populating it
DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'lessons' AND column_name = 'short_description' AND is_nullable = 'YES') THEN
        ALTER TABLE lessons ALTER COLUMN short_description SET NOT NULL;
    END IF;
END;
$$;

-- Add comment for documentation
COMMENT ON COLUMN lessons.short_description IS 'Short description/preview of the lesson content for display on module pages';
