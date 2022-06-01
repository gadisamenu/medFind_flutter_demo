package com.gis.medfind.RepositoryTests;

import com.gis.medfind.entity.MedPack;
import com.gis.medfind.entity.Pharmacy;
import com.gis.medfind.entity.Reservation;
import com.gis.medfind.entity.User;
import com.gis.medfind.repository.*;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.test.annotation.Rollback;


import static org.assertj.core.api.Assertions.assertThat;


@DataJpaTest
@AutoConfigureTestDatabase(replace = AutoConfigureTestDatabase.Replace.NONE)
@Rollback(true)
public class ReservationRepositoryTest {
  
    @Autowired
    private ReservationRepository reservationRepo;
    @Autowired
    private UserRepository userRepo;
    @Autowired
    private PharmacyRepository pharmRepo;
    @Autowired
    private MedPackRepository medpackRepo;



    @Test
    public void testCreateReservation() {
        long initial_count = reservationRepo.count();

        Reservation reservation = new Reservation();
        Pharmacy pharm1 = pharmRepo.save(new Pharmacy());
        reservation.setPharmacy(pharm1);

        User user1 = userRepo.save(new User());
        reservation.setUser(user1);

        MedPack md = new MedPack();
        medpackRepo.save(md);

        reservation.add_medpack(md);

        reservationRepo.save(reservation);

        assertThat(reservationRepo.count()).isEqualTo(initial_count +1);

    }
}




