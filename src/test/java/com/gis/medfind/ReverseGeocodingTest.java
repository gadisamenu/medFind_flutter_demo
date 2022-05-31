package com.gis.medfind;

import com.gis.medfind.utils.utils;

import org.junit.jupiter.api.Test;

import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.test.annotation.Rollback;
 
@DataJpaTest
@AutoConfigureTestDatabase(replace = Replace.NONE)
@Rollback(true)
public class ReverseGeocodingTest {
    
    @Test
    public void testReverseGeocoder() {
        System.out.println(utils.reverseGeocode(9.032646402656406, 38.75419284044014)); 
    }

    
}
