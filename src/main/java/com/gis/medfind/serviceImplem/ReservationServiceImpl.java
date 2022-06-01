package com.gis.medfind.serviceImplem;

import com.gis.medfind.entity.MedPack;
import com.gis.medfind.entity.Pharmacy;
import com.gis.medfind.entity.Reservation;
import com.gis.medfind.entity.User;
import com.gis.medfind.repository.MedPackRepository;
import com.gis.medfind.repository.PharmacyRepository;
import com.gis.medfind.repository.ReservationRepository;
import com.gis.medfind.repository.UserRepository;
import com.gis.medfind.service.ReservationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.function.Predicate;

@Service
public class ReservationServiceImpl implements ReservationService{
    @Autowired
    private ReservationRepository reservationRepo;
    @Autowired
    private PharmacyRepository  pharmacyRepo;
    @Autowired
    private UserRepository userRepo;
    @Autowired
    private MedPackRepository medPackRepo;

    public Reservation createReservation(Long user_id , Long pharmacy_id,Long  medpack_id){

        User user = userRepo.findById(user_id).orElseThrow();
        Pharmacy pharmacy = pharmacyRepo.findById(pharmacy_id).orElseThrow();
        MedPack medPack = medPackRepo.findById( medpack_id).orElseThrow();

        Reservation reservation = new Reservation();
        reservation.setUser(user);
        reservation.setPharmacy(pharmacy);
        reservation.add_medpack(medPack);
        return reservationRepo.save(reservation);
    }


    // read

    public List<Reservation> getAllReservationByUserId(Long user_id){
       List<Reservation> reservation = reservationRepo.findAllReservationByUserId(user_id);
       return reservation;}


    public List<Reservation> getAllReservationByPharmacyId(Long pharmacy_id){
        List<Reservation> reservations = reservationRepo.findAllReservationByPharmacyId(pharmacy_id);
        return reservations;
       };

    // delete
    public void deleteReservation(Long reservation_id) {
        reservationRepo.deleteById(reservation_id);
       };


   // update
   public  void addMedpackToReservation (Long reservation_id, Long medpack_id){
       Reservation reservation = reservationRepo.getById(reservation_id);
       List<MedPack> medpacks = reservation.getMedPacks();
       MedPack medpack = medPackRepo.getById(medpack_id);
       medpacks.add(medpack);
       reservation.setMedPacks(medpacks);
       reservationRepo.save(reservation);
   }

   public  void removeMedpackFromReservation(Long reservation_id , Long medpack_id) {

       Reservation reservation = reservationRepo.getById(reservation_id);
       List<MedPack> medPacks = reservation.getMedPacks();

       Predicate<MedPack>  pred = new Predicate<MedPack>() {
           @Override
           public boolean test (MedPack mdpk ){
               return mdpk.getId() == medpack_id;
           }
       };
       
       medPacks.removeIf(pred); 
       reservation.setMedPacks(medPacks);
       reservationRepo.save(reservation);
   }

   // check if it exist before

    public boolean isExistBefore(Long pharmacy_id, Long user_id,Long reservation_id ){
       List<Reservation> reservations = getAllReservationByUserId(user_id);
       int no_of_reservations = reservations.size();

       for (int i= 0 ; i < no_of_reservations; i++){
           Reservation reservation = reservations.get(i);
           Pharmacy pharmacy = reservation.getPharmacy();
           Long pharm_id = pharmacy.getId();
           if (pharm_id == pharmacy_id){
               return true;
           }
       }
       return false;
    }
    };


