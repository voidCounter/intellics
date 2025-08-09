-- Add order_index field to module_lesson_mapping table
ALTER TABLE module_lesson_mapping 
ADD COLUMN order_index INTEGER DEFAULT 0;

-- Update existing records to have sequential order_index values
-- Group by module_id and assign incremental order_index starting from 1
WITH ordered_lessons AS (
    SELECT 
        module_id,
        lesson_id,
        ROW_NUMBER() OVER (PARTITION BY module_id ORDER BY lesson_id) AS new_order_index
    FROM module_lesson_mapping
)
UPDATE module_lesson_mapping 
SET order_index = ordered_lessons.new_order_index
FROM ordered_lessons
WHERE module_lesson_mapping.module_id = ordered_lessons.module_id
  AND module_lesson_mapping.lesson_id = ordered_lessons.lesson_id;

-- Make order_index NOT NULL after setting initial values
ALTER TABLE module_lesson_mapping 
ALTER COLUMN order_index SET NOT NULL;
