package com.gis.medfind;


// import static org.assertj.core.api.Assertions.assertThat;

import com.gis.medfind.entity.Server;
import com.gis.medfind.entity.Server.Engine;
import com.gis.medfind.repository.ServerRepository;
// import com.gis.medfind.utils.utils;
// import com.gis.medfind.utils.utils.ConnectionMode;

import org.junit.jupiter.api.Test;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.test.annotation.Rollback;
 
@DataJpaTest
@AutoConfigureTestDatabase(replace = Replace.NONE)
@Rollback(true)
public class ConnectionTest {
 
     
    @Autowired
    private ServerRepository serverRepo;

     
    @Test
    public void testPharmacyConnection() {
        
        Server pharmServer = new Server();
            pharmServer.setDatabaseName("drugstore");
            pharmServer.setDrugInventory("table_1020");
            pharmServer.setEngine_type(Engine.POSTGRES);
            pharmServer.setHost("localhost");
            pharmServer.setPassword("123456789");
            pharmServer.setPort("5432");
            pharmServer.setUsername("postgres");
        pharmServer = serverRepo.save(pharmServer);
        // String amount = utils.connect(pharmServer, "select drug_amount from table_1020 where drug_name = \'Aceon\'", ConnectionMode.GET,"drug_amount");
        // assertThat(amount).isEqualTo("118");
    }

    
}
