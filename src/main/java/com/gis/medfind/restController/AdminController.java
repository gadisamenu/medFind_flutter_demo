package com.gis.medfind.restController;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import javax.persistence.EntityNotFoundException;

import com.gis.medfind.Forms.PharmacyProfile;
import com.gis.medfind.Forms.UserProfileForm;
import com.gis.medfind.entity.Pharmacy;
import com.gis.medfind.entity.Role;
import com.gis.medfind.entity.User;
import com.gis.medfind.repository.PharmacyRepository;
import com.gis.medfind.repository.RoleRepository;
import com.gis.medfind.repository.UserRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class AdminController {

    @Autowired
    UserRepository userRepo;

    @Autowired
    PharmacyRepository pharmRepo;

    @Autowired 
    PasswordEncoder passEncoder;

    @Autowired
    RoleRepository roleRepo;

    //users
    @RequestMapping(value = "/api/v1/admin/users", method = RequestMethod.GET)
    public ResponseEntity<? > getUser(@RequestParam(required = false, name = "id") String id){
        
        if (id != null){
            Optional<User> user = userRepo.findById(Long.parseLong(id));
            if (user.isEmpty())
                return new ResponseEntity<String>("user not found",HttpStatus.NOT_FOUND);
            return new ResponseEntity<User>(user.get(),HttpStatus.OK);
        }
        List<User> users = userRepo.findAll();
        return new ResponseEntity<List<User>>(users,HttpStatus.OK);
    }

    @RequestMapping(value = "/api/v1/admin/users", method = RequestMethod.DELETE)
    public ResponseEntity<List<User>> deleteUser(@RequestParam(name = "id") String id){
        if (id != null){
            userRepo.deleteById(Long.parseLong(id));
            List<User> user = userRepo.findAll();
            return new ResponseEntity<List<User>>(user,HttpStatus.OK);
        }
        List<User> user = userRepo.findAll();

        return new ResponseEntity<List<User>>(user,HttpStatus.NOT_ACCEPTABLE);
    }

    @RequestMapping(value = "/api/v1/admin/users", method = RequestMethod.PUT)
    public ResponseEntity<?> updateUser(@RequestParam(name = "id") String id,@RequestBody UserProfileForm profile){
        
            try{
                User user = userRepo.getById(Long.parseLong(id));

                if (profile.saveData(user, userRepo, passEncoder)){
                    return new ResponseEntity<User>(user,HttpStatus.ACCEPTED);
                }
                else{
                    return new ResponseEntity<String>("Wrong old password",HttpStatus.NOT_MODIFIED);
                }

            }
            catch (EntityNotFoundException e ){
                new ResponseEntity<>("User not found",HttpStatus.NOT_FOUND);
            }
            return new ResponseEntity<String>("Empty",HttpStatus.NOT_MODIFIED);
    }

    @RequestMapping(value = "/api/v1/admin/roles", method = RequestMethod.POST)
    public ResponseEntity<?> changeUserRole(@RequestParam(name = "id") String id, @RequestBody String roleName){
        try{
           User user =  userRepo.getById(Long.parseLong(id));
           List<Role> roles = new ArrayList<>();
           roles.add(roleRepo.findByName(roleName));
           
           user.setRoles(roles);
           userRepo.save(user);

        return new ResponseEntity<String>("role change success",HttpStatus.ACCEPTED);
        }
        catch (EntityNotFoundException e){
            return new ResponseEntity<String>("user not found", HttpStatus.NOT_FOUND);
        }
    }

    @RequestMapping(value = "/api/v1/admin/pharmacies", method = RequestMethod.GET)
    public ResponseEntity<? > getPharmacy(@RequestParam(required = false, name = "id") String id){
        if (id != null){
            Optional<Pharmacy> pharmacy = pharmRepo.findById(Long.parseLong(id));
            if (pharmacy.isEmpty())
                return new ResponseEntity<String>("pharmacy not found",HttpStatus.NOT_FOUND);
            return new ResponseEntity<Pharmacy>(pharmacy.get(),HttpStatus.OK);
        }
        List<Pharmacy> pharmacies = pharmRepo.findAll();
        return new ResponseEntity<List<Pharmacy>>(pharmacies, HttpStatus.OK);
    }

    @RequestMapping(value = "/api/v1/admin/pharmacies", method = RequestMethod.DELETE)
    public ResponseEntity<?> deletePharmacy(@RequestParam(name = "id") String id){
        try{
            pharmRepo.deleteById(Long.parseLong(id));
            List<Pharmacy> pharmacies = pharmRepo.findAll();
            return new ResponseEntity<List<Pharmacy>>(pharmacies,HttpStatus.OK);
        }
        catch (EntityNotFoundException e){
            return new ResponseEntity<String>("pharmacy not found",HttpStatus.NOT_FOUND);
        }
        
    }


    @RequestMapping(value = "/api/v1/admin/pharmacies", method = RequestMethod.PUT)
    public ResponseEntity<?> updatePharmacy(@RequestParam(name = "id") String id,@RequestBody PharmacyProfile body){
        try{
            Pharmacy pharmacy = pharmRepo.getById(Long.parseLong(id));
            if (body.getAddress() != null) pharmacy.setAddress(body.getAddress());
            if (body.getName() != null) pharmacy.setName(body.getName());
            if (body.getLocation() != null) pharmacy.setLocation(body.getLocation());
            pharmRepo.save(pharmacy);
            return new ResponseEntity<Pharmacy>(pharmacy,HttpStatus.ACCEPTED);
        }catch (EntityNotFoundException e){
            return new ResponseEntity<>("pharmacy not found",HttpStatus.NOT_FOUND);
        }
    }
}
