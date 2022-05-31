package com.gis.medfind.repository;

import java.util.List;

import com.gis.medfind.entity.Reservation;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ReservationRepository extends JpaRepository< Reservation,Long> {


    public List<Reservation> findAllReservationByUserId(Long user_id);

    public List<Reservation> findAllReservationByPharmacyId(Long pharmacy_id);



}
