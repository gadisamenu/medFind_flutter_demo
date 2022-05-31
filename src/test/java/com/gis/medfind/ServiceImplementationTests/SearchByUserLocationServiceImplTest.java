package com.gis.medfind.ServiceImplementationTests;

import java.util.List;

import com.gis.medfind.serviceImplem.SearchByUserLocationServiceImpl;

import com.gis.medfind.entity.Pharmacy;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.test.annotation.Rollback;
 
@DataJpaTest
@AutoConfigureTestDatabase(replace = Replace.NONE)
@Rollback(true)
public class SearchByUserLocationServiceImplTest {

    @Autowired
    private SearchByUserLocationServiceImpl searchService;


    @Test
    public void testFindPharmaciesByUserLocation() {
        List<Pharmacy> close_to_user_pharms = searchService
            .findPharmaciesByUserLocation(
                "Aceon",
                9.04352514110343, 38.761747659617775
            );

        for(Pharmacy pc: close_to_user_pharms){
            System.out.println(pc.getName());
            System.out.println(pc.getAddress());
        }
       
    }
}
