package com.gis.medfind.service;

import com.gis.medfind.entity.MedPack;
import com.gis.medfind.entity.Reservation;

import java.util.List;

public interface ReservationService {
    // create
    public Reservation createReservation(Long user_id , Long pharmacy_id,Long  medpack_id);


    // Read
   public List<Reservation> getAllReservationByUserId(Long user_id);
    public List<Reservation> getAllReservationByPharmacyId(Long pharmacy_id);

    // delete
    public boolean deleteReservation(Long reservation_id);
    //Update
    public  Reservation addMedpackToReservation (Long reservation_id, Long medpack_id);
    public  boolean removeMedpackFromReservation(Long reservation_id , Long medpack_id);

// check reservation exist bofore

    public boolean isExistBefore(Long pharmacy_id, Long user_id);

    public MedPack createMedPack(String tag);
}
