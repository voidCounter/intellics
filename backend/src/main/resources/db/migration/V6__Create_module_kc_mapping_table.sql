CREATE TABLE module_kc_mapping (
    module_id UUID NOT NULL,
    kc_id UUID NOT NULL,
    prerequisite_kc_id UUID,
    PRIMARY KEY (module_id, kc_id),
    FOREIGN KEY (module_id) REFERENCES modules(module_id),
    FOREIGN KEY (kc_id) REFERENCES knowledge_components(kc_id),
    FOREIGN KEY (prerequisite_kc_id) REFERENCES knowledge_components(kc_id)
);

ALTER TABLE knowledge_components
DROP COLUMN prerequisite_kc_id;
