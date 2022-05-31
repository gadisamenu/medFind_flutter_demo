package com.gis.medfind.RepositoryTests;
 
import static org.assertj.core.api.Assertions.assertThat;

import com.gis.medfind.entity.Server;
import com.gis.medfind.entity.Server.Engine;
import com.gis.medfind.repository.ServerRepository;

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
public class ServerRepositoryTest {
 
    @Autowired
    private TestEntityManager entityManager;
     
    @Autowired
    private ServerRepository repo;
     
    @Test
    public void testCreateServer() {
        Server pharmServer = new Server();
        pharmServer.setDatabaseName("medfind");
        pharmServer.setDrugInventory("medicines");
        pharmServer.setEngine_type(Engine.POSTGRES);
        pharmServer.setHost("localhost");
        pharmServer.setPassword("WARMACHINEROX");
        pharmServer.setPort("5468");
        pharmServer.setUsername("medfinduser");
        
        Server savedServer = repo.save(pharmServer);
        
        Server existServer = entityManager.find(Server.class, savedServer.getId());
        
        assertThat(savedServer.getDatabaseName()).isEqualTo(existServer.getDatabaseName());
    }
}