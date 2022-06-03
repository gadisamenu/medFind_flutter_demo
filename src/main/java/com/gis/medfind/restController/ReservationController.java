package com.gis.medfind.restController;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityNotFoundException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.gis.medfind.Forms.ReservationForm;
import com.gis.medfind.entity.MedPack;
import com.gis.medfind.entity.Reservation;
import com.gis.medfind.entity.Role;
import com.gis.medfind.entity.User;
import com.gis.medfind.jwt.JwtTokenUtil;
import com.gis.medfind.repository.PharmacyRepository;
import com.gis.medfind.repository.ReservationRepository;
import com.gis.medfind.repository.RoleRepository;
import com.gis.medfind.repository.UserRepository;
import com.gis.medfind.service.ReservationService;
import com.gis.medfind.service.WatchListService;

@RestController
@RequestMapping(consumes = "application/json",produces = "application/json")
public class ReservationController {

    @Autowired
    ReservationService reservationServ;

    @Autowired
    JwtTokenUtil jwtTokenUtil;

    @Autowired 
    UserRepository userRepo;

    @Autowired 
    RoleRepository roleRepo;

    @Autowired
    PharmacyRepository pharmRepo;

    @Autowired
    WatchListService watchlistServ;

    @Autowired
    ReservationRepository reservationRepo;


    @RequestMapping(value="/api/v1/reservations", method = RequestMethod.GET)
    public ResponseEntity<?> getReservations(@RequestHeader(name ="Authorization") String token){
        try{
            String email = jwtTokenUtil.getUsernameFromToken(token.substring(7));
            User user = userRepo.findByEmail(email);
            Role userRole = roleRepo.findByName("USER");

           

            List<Reservation>  reservations ;

            if (user.getRoles().contains(userRole)){
                reservations = (reservationServ.getAllReservationByUserId(user.getId()));
                
            }
            else{
                reservations = reservationServ.getAllReservationByPharmacyId(pharmRepo.findByOwner(user).getId());
            }
            List<Map<String,String>> reservation = new ArrayList<>();
            reservations.forEach(
                i->{
                    Map<String,String>  resr = new HashMap<>();
                    resr.put("id",i.getId().toString());
                    resr.put("medpack",i.getMedPacks().toString());
                    resr.put("user",i.getUser().getFirstName());
                    resr.put("pharmacy",i.getPharmacy().getName());
                    i.getPharmacy().getName();
                    reservation.add(resr);
                }
            );
            
            
            return new ResponseEntity<List<Map<String,String>>>(reservation,HttpStatus.OK);
        }
        catch (EntityNotFoundException e){
            return new ResponseEntity<String>("user not found",HttpStatus.NOT_FOUND);
        }
    }

    @RequestMapping(value ="/api/v1/reservations",method = RequestMethod.POST, consumes = "application/json")
    public ResponseEntity<?> createReservation(@RequestBody List<ReservationForm> reservationFroms ,@RequestParam(name ="pharm_id") String pharm_id, @RequestHeader(name="Authorization") String  token){
        try{
            String email = jwtTokenUtil.getUsernameFromToken(token.substring(7));
            User user = userRepo.findByEmail(email);

            // System.out.println(reservationFroms);
            Reservation reservation = null;
            if ( !reservationServ.isExistBefore(Long.parseLong(pharm_id), user.getId())){
                System.out.println("here");
                MedPack medpk =  reservationServ.createMedPack(reservationFroms.get(0).getTag());
                reservation = reservationServ.createReservation(user.getId(),Long.parseLong(pharm_id),medpk.getId());
            }
            else {
                List<Reservation> reservations =  reservationRepo.findByUser(user);
                for (Reservation reser: reservations){
                    if (reser.getPharmacy().getId() == Long.parseLong(pharm_id)){
                        reservation = reser;
                        break;
                    }
                }
            }

            if (reservation != null)
                for(int i  = 1; i<  reservationFroms.size();i++){
                    MedPack medpk =  reservationServ.createMedPack(reservationFroms.get(i).getTag());
                    watchlistServ.addPillToMedpack(medpk.getId(), reservationFroms.get(i).getMedicineName(), Integer.parseInt(reservationFroms.get(i).getStrength()),Integer.parseInt(reservationFroms.get(i).getAmount()));
                
                    reservationServ.addMedpackToReservation(reservation.getId(), medpk.getId());
            }

            return new ResponseEntity<Reservation >(reservation ,HttpStatus.ACCEPTED);
        }
        catch (EntityNotFoundException e){
            return new ResponseEntity<String>("user not found",HttpStatus.NOT_FOUND);
        }
    }

    @RequestMapping(value ="/api/v1/reservations",method = RequestMethod.DELETE)
    public ResponseEntity<?> deleteReservation(@RequestParam(name ="id") String id){
        try{
            if (reservationServ.deleteReservation(Long.parseLong(id)))
                return new ResponseEntity<String >("delete success",HttpStatus.ACCEPTED);
            return new ResponseEntity<String>("reservation not found",HttpStatus.NOT_FOUND);
        }
        catch (EntityNotFoundException e){
            return new ResponseEntity<String>("reservation not found",HttpStatus.NOT_FOUND);
        }
    }


    @RequestMapping(value = "/api/v1/reservations/medpacks",method=RequestMethod.DELETE)
    public ResponseEntity<?> removeMedpack(@RequestParam(name ="medpack_id") String medPack_id ,@RequestParam(name ="reserv_id") String reserv_id ){

        if (reservationServ.removeMedpackFromReservation(Long.parseLong(reserv_id),Long.parseLong(medPack_id)))
            return new ResponseEntity<String >("delete success",HttpStatus.ACCEPTED);

        return new ResponseEntity<String>("delete failed",HttpStatus.NOT_FOUND);
        
    }

}
