-- Create module_lesson_mapping table
CREATE TABLE IF NOT EXISTS module_lesson_mapping (
    module_id UUID NOT NULL,
    lesson_id UUID NOT NULL,
    PRIMARY KEY (module_id, lesson_id),
    FOREIGN KEY (module_id) REFERENCES modules(module_id) ON DELETE CASCADE,
    FOREIGN KEY (lesson_id) REFERENCES lessons(lesson_id) ON DELETE CASCADE
);

-- Remove module_id column from lessons table since lessons are now independent
ALTER TABLE lessons DROP COLUMN IF EXISTS module_id;
