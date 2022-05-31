package com.gis.medfind.RepositoryTests;

import static org.assertj.core.api.Assertions.assertThat;

import com.gis.medfind.entity.Privilege;
import com.gis.medfind.repository.PrivilegeRepository;

import org.junit.jupiter.api.Test;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.test.autoconfigure.orm.jpa.TestEntityManager;
import org.springframework.test.annotation.Rollback;
 
@DataJpaTest
@AutoConfigureTestDatabase(replace = Replace.NONE)
@Rollback(true)
public class PrivilegeRepositoryTest {
 
    @Autowired
    private TestEntityManager entityManager;
    
    @Autowired
    private PrivilegeRepository privilegeRepo;
    
    @Test
    public void testCreatePrivilege() {
        Privilege prev = new Privilege();
            prev.setName("CREATE");
            
        Privilege saved_prev = privilegeRepo.save(prev);

        Privilege exist_prev = entityManager.find(Privilege.class, prev.getId());
        assertThat(exist_prev.getName()).isEqualTo(saved_prev.getName());        
    }
}