ALTER TABLE module_kc_mapping
DROP COLUMN prerequisite_kc_id;

CREATE TABLE module_kc_prerequisite (
    module_id UUID NOT NULL,
    kc_id UUID NOT NULL,
    prerequisite_kc_id UUID NOT NULL,
    PRIMARY KEY (module_id, kc_id, prerequisite_kc_id),
    FOREIGN KEY (module_id, kc_id) REFERENCES module_kc_mapping(module_id, kc_id) ON DELETE CASCADE,
    FOREIGN KEY (prerequisite_kc_id) REFERENCES knowledge_components(kc_id)
);
