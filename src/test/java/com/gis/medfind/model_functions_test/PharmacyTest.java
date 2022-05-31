package com.gis.medfind.model_functions_test;


import com.gis.medfind.entity.Server;
import com.gis.medfind.entity.Server.Engine;
import com.gis.medfind.repository.ServerRepository;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.test.annotation.Rollback;
 
@DataJpaTest
@AutoConfigureTestDatabase(replace = Replace.NONE)
@Rollback(true)
public class PharmacyTest {

     
    @Autowired
    private ServerRepository serverRepo;

     
    @Test
    public void testPharmacyConnection() {
        
        Server pharmServer = new Server();
            pharmServer.setDatabaseName("drugstore");
            pharmServer.setDrugInventory("Table_1020");
            pharmServer.setEngine_type(Engine.POSTGRES);
            pharmServer.setHost("localhost");
            pharmServer.setPassword("123456789");
            pharmServer.setPort("5432");
            pharmServer.setUsername("postgres");
        pharmServer = serverRepo.save(pharmServer);

        
        
        
    }

    
}
