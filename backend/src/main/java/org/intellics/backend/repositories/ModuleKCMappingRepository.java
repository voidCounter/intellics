package org.intellics.backend.repositories;

import org.intellics.backend.domain.entities.Module;
import org.intellics.backend.domain.entities.ModuleKCMapping;
import org.intellics.backend.domain.entities.ModuleKCMappingId;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ModuleKCMappingRepository extends CrudRepository<ModuleKCMapping, ModuleKCMappingId> {
    List<ModuleKCMapping> findByModule(Module module);
}
