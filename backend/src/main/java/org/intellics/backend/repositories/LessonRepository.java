package org.intellics.backend.repositories;

import org.intellics.backend.domain.entities.Lesson;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface LessonRepository extends CrudRepository<Lesson, UUID> {
}
