package com.gis.medfind.repository;

import java.util.List;

import com.gis.medfind.entity.Pharmacy;
import com.gis.medfind.entity.Reservation;
import com.gis.medfind.entity.User;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ReservationRepository extends JpaRepository< Reservation,Long> {


    public List<Reservation> findAllReservationByUserId(Long user_id);

    public List<Reservation> findAllReservationByPharmacyId(Long pharmacy_id);

    public List<Reservation> findByPharmacy(Pharmacy pharmacy);

    public List<Reservation> findByUser(User user);

}
