package com.gis.medfind.ServiceImplementationTests;

import com.gis.medfind.entity.*;
import com.gis.medfind.repository.*;
import com.gis.medfind.serviceImplem.ReservationServiceImpl;


import org.junit.jupiter.api.Test;
import org.locationtech.jts.geom.Coordinate;
import org.locationtech.jts.geom.GeometryFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.test.annotation.Rollback;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;

@DataJpaTest
@AutoConfigureTestDatabase(replace = AutoConfigureTestDatabase.Replace.NONE)
@Rollback(true)
public class ReservationServiceImplTests {

    @Autowired
    private GeometryFactory geometryFactory;

    @Autowired
    private ReservationRepository reservationRepo;

    @Autowired
    private PharmacyRepository pharmRepo;

    @Autowired
    private MedPackRepository medpackRepo;

    @Autowired
    private UserRepository userRepo;


    @Autowired
    private ReservationServiceImpl reservationService;
    @Autowired
    private  PillRepository pillRepo;

    public User createTestUser(String email){
        User ur = new User();
        ur.setEmail(email);
        ur.setFirstName("Habtamu");
        ur.setLastName("Tsegaye");
        ur.setPassword("1q2w3e4r");
        ur.setRoles(null);
        return userRepo.save(ur);
    }
    public Pharmacy createTestPharmacy() {
        Pharmacy pharm = new Pharmacy();
        Coordinate loc = new Coordinate(52.003, 25.478);
        pharm.setLocation(geometryFactory.createPoint(loc));
        pharm.setAddress("Addis Ababa");
        pharm.setName("ST. Markos");
        pharm.setOwner(new User());
        pharm.setPharmacyServer(new Server());
        return pharmRepo.save(pharm);
    }

    private Reservation createTestReservation(){
        Reservation res = new Reservation();
        res.setUser(createTestUser("medfind@gmail.com"));
        List<MedPack>  medpack = new ArrayList<MedPack>();
        medpack.add(createTestMedPack());
        res.setMedPacks(medpack);
        res.setPharmacy(createTestPharmacy());
        return reservationRepo.save(res);
    }

    public MedPack createTestMedPack() {

        // long initial_count = medpackRepo.count();

        Medicine md = new Medicine();
        Pill pl = new Pill();
        pl.setMedicine(md);
        pl.setAmount(20);
        pl.setStrength(500);
        pillRepo.save(pl);

        Medicine md1 = new Medicine();
        Pill pl1 = new Pill();
        pl1.setMedicine(md1);
        pl1.setAmount(20);
        pl1.setStrength(500);
        pillRepo.save(pl1);

        Medicine md2 = new Medicine();
        Pill pl2 = new Pill();
        pl2.setMedicine(md2);
        pl2.setAmount(20);
        pl2.setStrength(500);
        pillRepo.save(pl2);

        Medicine md3 = new Medicine();
        Pill pl3 = new Pill();
        pl3.setMedicine(md3);
        pl3.setAmount(20);
        pl3.setStrength(500);
        pillRepo.save(pl3);

        List<Pill> pills = new ArrayList<>();
        pills.add(pl);
        pills.add(pl1);
        pills.add(pl2);
        pills.add(pl3);

        MedPack mp = new MedPack();
        mp.setPills(pills);
        return medpackRepo.save(mp);
    }

    @Test
// create
    public void test_createReservation(){
            User ur = createTestUser("habte@gmail.com");
            Pharmacy pharm = createTestPharmacy();

            int initial_count = (int)reservationRepo.count();
            reservationService.createReservation(ur.getId(),pharm.getId(),createTestMedPack().getId());//

            assertThat(initial_count +1).isEqualTo(reservationRepo.count());

    }

@Test
    // Read
    public void test_getAllReservationByUserId(){
    User user = createTestUser("habte@gmail.com");
    Pharmacy pharm = createTestPharmacy();
   
    List<Reservation> reserves = new ArrayList<>();
    for (int i = 0 ; i< 2; i++){
        reserves.add(reservationService.createReservation(user.getId(),pharm.getId(),createTestMedPack().getId()));
    }
    
    List<Reservation> fetched_reservation = reservationRepo.findAllReservationByUserId(user.getId());
    int no_of_reservations_after = fetched_reservation.size();
    assertThat(2).isEqualTo(no_of_reservations_after);
    assertThat(reserves.containsAll(fetched_reservation)).isTrue();
}
@Test
    public void  test_getAllReservationByPharmacyId(){
    User user = createTestUser("habte@gmail.com");
    Pharmacy pharm = createTestPharmacy();
    List<Reservation> reserves = new ArrayList<>();

    for (int i = 0 ; i< 2; i++){
        reserves.add(reservationService.createReservation(user.getId(),pharm.getId(),createTestMedPack().getId()));
    }

    List<Reservation> fetched_reservation = reservationRepo.findAllReservationByPharmacyId(pharm.getId());
    int no_of_reservations_after = fetched_reservation.size();

    assertThat(reserves.containsAll(fetched_reservation)).isTrue();
    assertThat(2).isEqualTo(no_of_reservations_after);

}

    // delete
    @Test
    public void test_deleteReservation(){
        User user = createTestUser("habte@gmail.com");
        Pharmacy pharm = createTestPharmacy();
        MedPack medPack = createTestMedPack();

        Reservation reservation = reservationService.createReservation(user.getId(),pharm.getId(),medPack.getId());

        reservationService.deleteReservation(reservation.getId());

        Optional<Reservation> opt_reservation = reservationRepo.findById(reservation.getId());


        assertThat(opt_reservation.isPresent()).isFalse();
    }

    
    //Update
    @Test
    public void test_addMedpackToReservation (){
        Reservation reservation = createTestReservation();
        int amount_before = reservation.getMedPacks().size();

        reservationService.addMedpackToReservation(reservation.getId(),createTestMedPack().getId());
        int amount_after = reservation.getMedPacks().size();

        assertThat(amount_before + 1).isEqualTo(amount_after);
    }


    @Test
    public  void test_removeMedpackFromReservation(){
        
        Reservation reservation = reservationRepo.getById(createTestReservation().getId());
        MedPack md = createTestMedPack();
        reservationService.addMedpackToReservation(reservation.getId(), md.getId()); 
        int amount_before = reservation.getMedPacks().size();

        reservationService.removeMedpackFromReservation(reservation.getId(),md.getId());


        int amount_after = reservation.getMedPacks().size();
        assertThat(amount_before - 1).isEqualTo(amount_after);
    }

// check reservation exist bofore
@Test
    public void test_isExistBefore(){
        User ur = createTestUser("habte@gmail.com");
        Pharmacy pharm = createTestPharmacy();
        MedPack medPack = createTestMedPack();


        Reservation reservation = reservationService.createReservation(ur.getId(),pharm.getId(),medPack.getId());
        boolean check= reservationService.isExistBefore(pharm.getId(),ur.getId(),reservation.getId());
        assertThat(check).isTrue();
   }

}