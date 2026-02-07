-- Rename session table to sessions for consistency
DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM pg_tables WHERE tablename = 'session') THEN
        ALTER TABLE session RENAME TO sessions;
    END IF;
END;
$$;
