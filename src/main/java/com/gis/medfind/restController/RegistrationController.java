package com.gis.medfind.restController;

import com.gis.medfind.Forms.RegistrationForm;
import com.gis.medfind.repository.RoleRepository;
import com.gis.medfind.repository.UserRepository;
import com.gis.medfind.repository.WatchListRepository;
import com.gis.medfind.serviceImplem.CustomSecurityService;
import com.gis.medfind.serviceImplem.CustomUserDetailServices;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
// @RequiredArgsConstructor
@RequestMapping(consumes = "application/json",produces = "application/json")
public class RegistrationController {
  @Autowired
  private RoleRepository roleRepo;
  @Autowired
  private CustomUserDetailServices userService;
  @Autowired
  private UserRepository UserRepository;
  @Autowired
  private PasswordEncoder passwordEncoder;
  @Autowired
  private WatchListRepository watchListRepo;
  
  @Autowired
  CustomSecurityService currentUser;

//   @Autowired
//   private RegistrationForm RegForm;

  
  
   @RequestMapping(value="/api/v1/register",method = RequestMethod.POST )
    public ResponseEntity<?> processRegistration(@RequestBody RegistrationForm Form) {  
        String email = Form.getEmail();
        System.out.println(Form.getEmail());
        System.out.println(Form.getFirstName());

        try{
          userService.loadUserByUsername(email);
        }catch(UsernameNotFoundException e){
            Form.toUser(UserRepository,passwordEncoder,roleRepo,watchListRepo);


            return new ResponseEntity<>("Successfull Registration",HttpStatus.OK);
          
        };
        return new ResponseEntity<>("UserAlreadyExist",HttpStatus.NOT_ACCEPTABLE);
        
    }
}

