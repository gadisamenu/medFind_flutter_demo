package com.gis.medfind.serviceImplem;

import com.gis.medfind.entity.MedPack;
import com.gis.medfind.entity.Pharmacy;
import com.gis.medfind.entity.Pill;
import com.gis.medfind.entity.Reservation;
import com.gis.medfind.entity.User;
import com.gis.medfind.repository.MedPackRepository;
import com.gis.medfind.repository.PharmacyRepository;
import com.gis.medfind.repository.PillRepository;
import com.gis.medfind.repository.ReservationRepository;
import com.gis.medfind.repository.UserRepository;
import com.gis.medfind.service.ReservationService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

import javax.persistence.EntityNotFoundException;

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

    @Autowired
    private PillRepository pillRepo;

    public Reservation createReservation(Long user_id , Long pharmacy_id,Long  medpack_id){

        User user = userRepo.findById(user_id).get();
        // System.out.println("1rd");
        Pharmacy pharmacy = pharmacyRepo.findById(pharmacy_id).get();
        // System.out.println("2rd");
        MedPack medPack = medPackRepo.findById( medpack_id).get();
        // System.out.println("3rd");

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
    public boolean deleteReservation(Long reservation_id) {
        try{
            reservationRepo.deleteById(reservation_id);
            return true;
        }
        catch (Exception e){
            return false;
        }
        
    };


   // update
   public Reservation addMedpackToReservation (Long reservation_id, Long medpack_id){

       Reservation reservation = reservationRepo.getById(reservation_id);
       List<MedPack> medpacks = reservation.getMedPacks();
       MedPack medpack = medPackRepo.getById(medpack_id);
       MedPack copied =  new MedPack();
       copied.setTag(medpack.getTag());
       for (Pill p : medpack.getPills()){
           Pill pill = new Pill();
           pill.setAmount(p.getAmount());
           pill.setMedicine(p.getMedicine());
           pill.setStrength(p.getStrength());
           pillRepo.save(pill);
           copied.addPill(pill);
       }
       medPackRepo.save(copied);
       medpacks.add(copied);
       reservation.setMedPacks(medpacks);
       return reservationRepo.save(reservation);
   }

   public boolean removeMedpackFromReservation(Long reservation_id , Long medpack_id) {
       try{
        //    System.out.println(reservation_id +"________impl" + medpack_id);
           Reservation reservation = reservationRepo.getById(reservation_id);
           List<MedPack> medPacks = reservation.getMedPacks();

            medPacks.remove(medPackRepo.getById(medpack_id));
            reservation.setMedPacks(medPacks);
            reservationRepo.save(reservation);
            return true;
       }
       catch (EntityNotFoundException e){
           return false;
       }
       
   }

   // check if it exist before

    public boolean isExistBefore(Long pharmacy_id, Long user_id){
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


        @Override
        public MedPack createMedPack(String tag) {
            MedPack medPack = new MedPack();
            medPack.setTag(tag);
            return medPackRepo.save(medPack);

        }
};


