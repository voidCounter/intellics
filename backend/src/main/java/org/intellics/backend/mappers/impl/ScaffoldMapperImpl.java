package org.intellics.backend.mappers.impl;

import org.intellics.backend.domain.dto.ScaffoldDto;
import org.intellics.backend.domain.entities.Scaffold;
import org.intellics.backend.mappers.ScaffoldMapper;
import org.springframework.stereotype.Component;

@Component
public class ScaffoldMapperImpl implements ScaffoldMapper {
    
    @Override
    public ScaffoldDto mapTo(Scaffold scaffold) {
        if (scaffold == null) {
            return null;
        }
        
        return ScaffoldDto.builder()
            .scaffoldId(scaffold.getScaffold_id())
            .scaffoldText(scaffold.getScaffold_text())
            .scaffoldCorrectAnswer(scaffold.getScaffold_correct_answer())
            .orderIndex(scaffold.getOrder_index())
            .build();
    }
    
    @Override
    public Scaffold mapFrom(ScaffoldDto scaffoldDto) {
        if (scaffoldDto == null) {
            return null;
        }
        
        return Scaffold.builder()
            .scaffold_id(scaffoldDto.getScaffoldId())
            .scaffold_text(scaffoldDto.getScaffoldText())
            .scaffold_correct_answer(scaffoldDto.getScaffoldCorrectAnswer())
            .order_index(scaffoldDto.getOrderIndex())
            .build();
    }
}
