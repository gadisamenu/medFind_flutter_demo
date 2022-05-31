package com.gis.medfind.service;

import com.gis.medfind.entity.Reservation;

import java.util.List;

public interface ReservationService {
    // create
    public Reservation createReservation(Long user_id , Long pharmacy_id,Long  medpack_id);


    // Read
   public List<Reservation> getAllReservationByUserId(Long user_id);
    public List<Reservation> getAllReservationByPharmacyId(Long pharmacy_id);

    // delete
    public void deleteReservation(Long reservation_id);
    //Update
    public  void addMedpackToReservation (Long reservation_id, Long medpack_id);
    public  void removeMedpackFromReservation(Long reservation_id , Long medpack_id);

// check reservation exist bofore

    public boolean isExistBefore(Long pharmacy_id, Long user_id,Long reservation_id);
}
