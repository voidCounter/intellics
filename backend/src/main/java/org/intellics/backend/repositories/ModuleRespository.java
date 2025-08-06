package org.intellics.backend.repositories;

import java.util.UUID;
import org.intellics.backend.domain.entities.Module;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ModuleRespository extends CrudRepository<Module, UUID> {
}
