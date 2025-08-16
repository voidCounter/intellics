package org.intellics.backend.repositories;

import org.intellics.backend.domain.entities.ModuleKCPrerequisite;
import org.intellics.backend.domain.entities.ModuleKCPrerequisiteId;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ModuleKCPrerequisiteRepository extends CrudRepository<ModuleKCPrerequisite, ModuleKCPrerequisiteId> {
    // Add custom query methods if needed
}
