package org.intellics.backend.repositories;

import static org.assertj.core.api.Assertions.assertThat;

import java.util.List;
import java.util.Optional;
import org.intellics.backend.AbstractIntegrationTests;
import org.intellics.backend.TestDataUtil;
import org.intellics.backend.domain.entities.Module;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

public class ModuleRepositoryIntegrationTests extends AbstractIntegrationTests {
    private ModuleRespository underTest;
    
    @Autowired
    public ModuleRepositoryIntegrationTests(ModuleRespository underTest) {
        this.underTest = underTest;
    }
    
    @Test
    public void contextLoads() {
        assertThat(underTest).isNotNull();
    }
    
    @Test
    public void testThatModuleCanBeCreatedAndRecalled() {
        Module module = TestDataUtil.createTestModule();
        // Arrange
        underTest.save(module);
        Optional<Module> result = underTest.findById(module.getModule_id());
        assertThat(result).isPresent();
        assertThat(result.get()).isEqualTo(module);
    }
    
    @Test
    public void testThatFindManyGeneratesCorrectSql() {
        List<Module> list = TestDataUtil.createTestModule(3);
        underTest.saveAll(list);
        Iterable<Module> results = underTest.findAll();
        assertThat(results).hasSize(3);
        assertThat(results).containsExactly(list.get(0), list.get(1), list.get(2));
    }
    
    @Test
    public void testThatModuleCanBeDeleted() {
        List<Module> list = TestDataUtil.createTestModule(2);
        underTest.saveAll(list);
        
        underTest.delete(list.get(0));
        Iterable<Module> result = underTest.findAll();
        
        assertThat(result).hasSize(1).containsExactly(list.get(1));
    }
}
