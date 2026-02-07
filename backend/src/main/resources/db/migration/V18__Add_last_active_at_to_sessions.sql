-- Add last_active_at field to sessions table for heartbeat tracking
ALTER TABLE sessions ADD COLUMN IF NOT EXISTS last_active_at TIMESTAMP(6) WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP(6);

-- Update existing sessions to have last_active_at = start_time
UPDATE sessions SET last_active_at = start_time WHERE last_active_at IS NULL;

-- Make last_active_at NOT NULL after setting default values
DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'sessions' AND column_name = 'last_active_at' AND is_nullable = 'YES') THEN
        ALTER TABLE sessions ALTER COLUMN last_active_at SET NOT NULL;
    END IF;
END;
$$;

-- Add index for efficient querying of inactive sessions
CREATE INDEX IF NOT EXISTS idx_sessions_last_active_at ON sessions(last_active_at);
