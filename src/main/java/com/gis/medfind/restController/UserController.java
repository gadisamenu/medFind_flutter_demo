package com.gis.medfind.restController;

import javax.persistence.EntityNotFoundException;

import com.gis.medfind.Forms.UserProfileForm;
import com.gis.medfind.entity.User;
import com.gis.medfind.jwt.JwtTokenUtil;
import com.gis.medfind.repository.UserRepository;
import com.gis.medfind.repository.WatchListRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class UserController {

    @Autowired
    UserRepository userRepo;

    @Autowired
    WatchListRepository  watchRepo;

    @Autowired 
    PasswordEncoder passEncoder;

    @Autowired
    JwtTokenUtil jwtTokenUtil;

    @RequestMapping(value="/api/v1/user" , method=RequestMethod.GET)
    public ResponseEntity<?> profile(@RequestHeader(name ="Authorization") String token){
        String email = jwtTokenUtil.getUsernameFromToken(token.substring(7));

        User user = userRepo.findByEmail(email);
        return new ResponseEntity<User>(user,HttpStatus.OK);
    }

    @RequestMapping(value="/api/v1/user", method = RequestMethod.PUT)
    public ResponseEntity<?> updateUser(@RequestBody UserProfileForm profile, @RequestHeader(name ="Authorization") String token){
            
            try{
                String email = jwtTokenUtil.getUsernameFromToken(token.substring(7));
                User user = userRepo.findByEmail(email);
    

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

    @RequestMapping(value="/api/v1/user", method= RequestMethod.DELETE)
    public ResponseEntity<String> deleteMyself(@RequestHeader(name ="Authorization") String token){
        try{
            String email = jwtTokenUtil.getUsernameFromToken(token.substring(7));
            User user = userRepo.findByEmail(email);
            
            watchRepo.delete(watchRepo.findWatchListByUserId(user.getId()));

            return new ResponseEntity<String>("Successfully deleted",HttpStatus.ACCEPTED);

        }
        catch  (Exception e){
            return new ResponseEntity<String>("deleting failed",HttpStatus.NOT_FOUND);
        }
        
       
    }
    
}


      
