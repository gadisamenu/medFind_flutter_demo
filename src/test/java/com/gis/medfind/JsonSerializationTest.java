package com.gis.medfind;

import static org.assertj.core.api.Assertions.assertThat;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;

// import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
// import com.gis.medfind.entity.Pharmacy;
// import com.gis.medfind.entity.Region;

import org.junit.jupiter.api.Test;
import org.locationtech.jts.geom.Coordinate;
import org.locationtech.jts.geom.GeometryFactory;
import org.locationtech.jts.geom.Point;
import org.n52.jackson.datatype.jts.JtsModule;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

import org.springframework.test.annotation.Rollback;
 
@DataJpaTest
@AutoConfigureTestDatabase(replace = Replace.NONE)
@Rollback(true)
public class JsonSerializationTest {
    @Autowired
    ObjectMapper objectMapper;

    @Autowired
    JtsModule module;

    @Autowired
    GeometryFactory geom;

    @Test
    void testJson() throws IOException {

        objectMapper.registerModule(module);

        Point point = geom.createPoint(new Coordinate(18.05, 85.89));

        String geojson = objectMapper.writeValueAsString(point);
        InputStream targetStream = new ByteArrayInputStream(geojson.getBytes());
        Point point2 = objectMapper.readValue(targetStream, Point.class);

        assertThat(point.equals(point2)).isEqualTo(true);
    }

    // @Test
    // public void givenBidirectionRelation_whenSerializing_thenException()throws JsonProcessingException {

    //     Pharmacy kenema = new Pharmacy();
    //         kenema.setName("kenema");
    //     Pharmacy markos = new Pharmacy();
    //         kenema.setName("markos");
    //     Pharmacy hana = new Pharmacy();
    //         kenema.setName("hana");
    //     Pharmacy ablium = new Pharmacy();
    //         kenema.setName("ablium");
    //     Pharmacy anbessa = new Pharmacy();
    //         kenema.setName("anbessa");

    //     Region bole = new Region();
    //         bole.setName("bole");
        
    //     bole.addPharmacy(kenema);
    //     bole.addPharmacy(markos);
    //     bole.addPharmacy(hana);
    //     bole.addPharmacy(ablium);
    //     bole.addPharmacy(anbessa);

    //     System.out.println(objectMapper.writeValueAsString(bole));
    // }

}
