package com.gis.medfind.ServiceImplementationTests;

import com.gis.medfind.entity.*;
import com.gis.medfind.repository.*;
import com.gis.medfind.service.ReservationService;
import com.gis.medfind.serviceImplem.ReservationServiceImpl;
import org.junit.jupiter.api.Test;
import org.locationtech.jts.geom.Coordinate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.test.annotation.Rollback;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import static org.hamcrest.MatcherAssert.assertThat;

@DataJpaTest
@AutoConfigureTestDatabase(replace = AutoConfigureTestDatabase.Replace.NONE)
@Rollback(true)
public class ReservationServiceImplTests {
    @Autowired
    private ReservationRepository reservationRepo;

    @Autowired
    private PharmacyRepository pharmRepo;

    @Autowired
    private MedPackRepository medpackRepo;

    @Autowired
    private UserRepository userRepo;

    @Autowired
    private MedicineRepository medRepo;

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
    @Test
    public MedPack createTestMedPack() {

        long initial_count = medpackRepo.count();
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
       return  medpackRepo.save(mp);
    }

    @Test
// create
    public void test_createReservation(Long user_id , Long pharmacy_id,Long  medpack_id){
            User ur = createTestUser("habte@gmail.com");
            Pharmacy pharm = createTestPharmacy();
            MedPack medPack = createTestMedPack();
            int initial_count = (int)reservationRepo.count();


            reservationService.createReservation(ur.getId(),pharm.getId(),medPack.getId());//


            assertThat(initial_count +1).isEqualTo(reservationRepo.count());

    }

@Test
    // Read
    public void test_getAllReservationByUserId(Long user_id){
    User user = createTestUser("habte@gmail.com");
    Pharmacy pharm = createTestPharmacy();
    MedPack medPack = createTestMedPack();
    int no_of_reservations_before = (int)reservationRepo.count();

   Reservation reservation = reservationService.createReservation(user.getId(),pharm.getId(),medPack.getId());
   List<Reservation> feched_reservation = reservationRepo.findAllReservationByUserId(user.getId());
   int no_of_reservations_after = feched_reservation.size();
   assertThat(no_of_reservations_before + 1).isEqualTo(no_of_reservations_after);

}
@Test
    public void  test_getAllReservationByPharmacyId(Long pharmacy_id){
    User user = createTestUser("habte@gmail.com");
    Pharmacy pharm = createTestPharmacy();
    MedPack medPack = createTestMedPack();
    int no_of_reservations_before = (int)reservationRepo.count();

    Reservation reservation = reservationService.createReservation(user.getId(),pharm.getId(),medPack.getId());
    List<Reservation> feched_reservation = reservationRepo.findAllReservationByPharmacyId(pharm.getId());
    int no_of_reservations_after = feched_reservation.size();
    assertThat(no_of_reservations_before + 1).isEqualTo(no_of_reservations_after);
}

    // delete
    @Test
    public void test_deleteReservation(Long reservation_id){
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
    public  void test_addMedpackToReservation (Long reservation_id, Long medpack_id){
    MedPack medPack = new MedPack();
    Reservation reservation = reservationRepo.getById(reservation_id);
    int amount_before = reservation.getMedPacks().size();

    reservationService.addMedpackToReservation(reservation.getId(),medPack.getId());
    int amount_after = reservation.getMedPacks().size();

    assertThat(amount_before + 1).isEqualTo(amount_after);

    }
    @Test
    public  void test_removeMedpackFromReservation(Long reservation_id , Long medpack_id){
        MedPack medPack = createTestMedPack();
        Reservation reservation = reservationRepo.getById(reservation_id);
        int amount_before = reservation.getMedPacks().size();

        reservationService.removeMedpackFromReservation(reservation.getId(),medPack.getId());
        int amount_after = reservation.getMedPacks().size();

        assertThat(amount_before - 1).isEqualTo(amount_after)
    }

// check reservation exist bofore
@Test
    public void test_isExistBefore(Long pharmacy_id, Long user_id,Long reservation_id){
    User ur = createTestUser("habte@gmail.com");
    Pharmacy pharm = createTestPharmacy();
    MedPack medPack = createTestMedPack();


    Reservation reservation = reservationService.createReservation(ur.getId(),pharm.getId(),medPack.getId());
    boolean check= reservationService.isExistBefore(pharm.getId(),ur.getId(),reservation.getId());
    assertThat(check).isTrue();
}

}