package org.intellics.backend.repositories;

import org.intellics.backend.domain.entities.Module;
import org.intellics.backend.domain.entities.ModuleKCMapping;
import org.intellics.backend.domain.entities.ModuleKCMappingId;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface ModuleKCMappingRepository extends CrudRepository<ModuleKCMapping, ModuleKCMappingId> {
    List<ModuleKCMapping> findByModule(Module module);
    
    @Query("SELECT COUNT(m) > 0 FROM ModuleKCMapping m WHERE m.mappingId.moduleId = :moduleId AND m.mappingId.kcId = :kcId")
    boolean existsByModuleIdAndKnowledgeComponentId(@Param("moduleId") UUID moduleId, @Param("kcId") UUID kcId);
}
