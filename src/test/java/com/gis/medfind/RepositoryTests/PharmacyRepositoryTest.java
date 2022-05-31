package com.gis.medfind.RepositoryTests;

import static org.assertj.core.api.Assertions.assertThat;

import java.util.ArrayList;
import java.util.List;
// import java.util.stream.Collectors;

import com.gis.medfind.entity.Pharmacy;
import com.gis.medfind.entity.Server;
import com.gis.medfind.entity.User;
import com.gis.medfind.repository.PharmacyRepository;
// import com.gis.medfind.repository.RegionRepository;

import org.junit.jupiter.api.Test;
import org.locationtech.jts.geom.Coordinate;
import org.locationtech.jts.geom.GeometryFactory;
import org.locationtech.jts.geom.Point;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.test.autoconfigure.orm.jpa.TestEntityManager;
import org.springframework.test.annotation.Rollback;
 
@DataJpaTest
@AutoConfigureTestDatabase(replace = Replace.NONE)
@Rollback(true)
public class PharmacyRepositoryTest {
 
    @Autowired
    private TestEntityManager entityManager;
     
    @Autowired
    private PharmacyRepository pharmRepo;
     
    // @Autowired
    // private RegionRepository regionRepo;
     
    @Autowired
    private GeometryFactory geometryFactory;
     
    @Test
    public void testCreatePharmacy() {
        
        Pharmacy pharm = new Pharmacy();
        Coordinate loc = new Coordinate(52.003, 25.478);
        pharm.setLocation(geometryFactory.createPoint(loc));
        pharm.setAddress("Addis Ababa");
        pharm.setName("ST. Markos");
        pharm.setOwner(new User());
        pharm.setPharmacyServer(new Server());
        Pharmacy savedPharmacy = pharmRepo.save(pharm);
        Pharmacy existPharmacy = entityManager.find(Pharmacy.class, savedPharmacy.getId());
        
        assertThat(pharm.getName()).isEqualTo(existPharmacy.getName());
        
    }
    // @Test
    // public void testFindPharmaciesWithInRegion() {
    //     String region1 = "Yeka";
    //     List<Pharmacy> yeka_pharms = pharmRepo
    //         .findAllPharmacyWithInRegion(
    //             regionRepo.findByName(region1).getId()
    //         );
    //     System.out.println(yeka_pharms.size());

    //     String region2 = "Bole";
    //     List<Pharmacy> bole_pharms = pharmRepo
    //         .findAllPharmacyWithInRegion(
    //             regionRepo.findByName(region2).getId()
    //         );
        
    //     System.out.println(bole_pharms.size());

    //     List<Pharmacy> commonElements = yeka_pharms.stream()
    //             .filter(bole_pharms::contains)
    //             .collect(Collectors.toList());

    //     assertThat(commonElements.size()).isEqualTo(0);
       
    // }
    @Test
    public void testFindPharmaciesCloseToUser() {
        Coordinate loc = new Coordinate(38.5, 9.56);
        List<Pharmacy> closeToUser = pharmRepo
            .findAllPharmaciesByDistanceFromUser(
                loc.x, loc.y
            );

        Point userLocation = geometryFactory.createPoint(loc);
        List<Double> distances = new ArrayList<>();
        for(Pharmacy pharm:closeToUser){
            Double dist = pharm.getLocation().distance(userLocation);
            distances.add(dist);
            System.out.println(dist);
        }
        List<Double> sorted = distances;
        sorted.sort((a, b) -> Double.compare(b, a));
        assertThat(distances).isEqualTo(sorted);
    }
}
