ALTER TABLE knowledge_components ALTER COLUMN description TYPE TEXT USING description::TEXT;
ALTER TABLE lessons ALTER COLUMN description TYPE TEXT USING description::TEXT;
ALTER TABLE modules ALTER COLUMN description TYPE TEXT USING description::TEXT;