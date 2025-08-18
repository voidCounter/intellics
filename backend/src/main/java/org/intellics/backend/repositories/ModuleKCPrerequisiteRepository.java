package org.intellics.backend.repositories;

import org.intellics.backend.domain.entities.ModuleKCPrerequisite;
import org.intellics.backend.domain.entities.ModuleKCPrerequisiteId;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface ModuleKCPrerequisiteRepository extends CrudRepository<ModuleKCPrerequisite, ModuleKCPrerequisiteId> {
    // Find all prerequisites for a specific module
    List<ModuleKCPrerequisite> findById_ModuleId(UUID moduleId);
    
    // Find all prerequisites for a specific KC within a module
    List<ModuleKCPrerequisite> findById_ModuleIdAndId_KcId(UUID moduleId, UUID kcId);
}
