ALTER TABLE knowledge_components
ADD COLUMN prerequisite_kc_id UUID,
ADD CONSTRAINT fk_prerequisite_kc
FOREIGN KEY (prerequisite_kc_id)
REFERENCES knowledge_components(kc_id);
