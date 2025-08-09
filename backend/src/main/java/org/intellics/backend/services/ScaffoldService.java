package org.intellics.backend.services;

import java.util.List;
import java.util.UUID;
import org.intellics.backend.domain.entities.Scaffold;

public interface ScaffoldService {
    
    Scaffold createScaffold(UUID questionId, Scaffold scaffold);
    
    List<Scaffold> getScaffoldsByQuestionId(UUID questionId);
    
    Scaffold getScaffold(UUID questionId, UUID scaffoldId);
    
    Scaffold updateScaffold(UUID questionId, UUID scaffoldId, Scaffold scaffold);
    
    void deleteScaffold(UUID questionId, UUID scaffoldId);
    
    List<Scaffold> reorderScaffolds(UUID questionId, List<UUID> scaffoldIds);
}
