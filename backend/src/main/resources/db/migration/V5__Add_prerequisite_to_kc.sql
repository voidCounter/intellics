ALTER TABLE knowledge_components
ADD COLUMN IF NOT EXISTS prerequisite_kc_id UUID;
ALTER TABLE knowledge_components DROP CONSTRAINT IF EXISTS fk_prerequisite_kc;
ALTER TABLE knowledge_components
ADD CONSTRAINT fk_prerequisite_kc
FOREIGN KEY (prerequisite_kc_id)
REFERENCES knowledge_components(kc_id);
