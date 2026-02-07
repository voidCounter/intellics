-- Update lessons table to change description column to lesson_content
DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'lessons' AND column_name = 'description') THEN
        ALTER TABLE lessons RENAME COLUMN description TO lesson_content;
    END IF;
END;
$$;
