-- Update lessons table to change description column to lesson_content
ALTER TABLE lessons 
RENAME COLUMN description TO lesson_content;
