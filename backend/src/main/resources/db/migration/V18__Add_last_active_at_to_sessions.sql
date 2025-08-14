-- Add last_active_at field to sessions table for heartbeat tracking
ALTER TABLE sessions ADD COLUMN last_active_at TIMESTAMP(6) WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP(6);

-- Update existing sessions to have last_active_at = start_time
UPDATE sessions SET last_active_at = start_time WHERE last_active_at IS NULL;

-- Make last_active_at NOT NULL after setting default values
ALTER TABLE sessions ALTER COLUMN last_active_at SET NOT NULL;

-- Add index for efficient querying of inactive sessions
CREATE INDEX idx_sessions_last_active_at ON sessions(last_active_at);
