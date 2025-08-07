package org.intellics.backend.repositories;

import java.util.UUID;
import org.intellics.backend.domain.entities.Module;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ModuleRepository extends CrudRepository<Module, UUID> {
}
