// package com.gis.medfind.controller;


// import javax.validation.Valid;

// import com.gis.medfind.Forms.RegistrationForm;
// import com.gis.medfind.repository.RoleRepository;

// import com.gis.medfind.repository.UserRepository;
// import com.gis.medfind.repository.WatchListRepository;
// import com.gis.medfind.serviceImplem.CustomSecurityService;
// import com.gis.medfind.serviceImplem.CustomUserDetailServices;

// import org.springframework.stereotype.Controller;
// import org.springframework.ui.Model;
// import org.springframework.validation.Errors;
// import org.springframework.web.bind.annotation.GetMapping;
// import org.springframework.web.bind.annotation.ModelAttribute;
// import org.springframework.web.bind.annotation.PostMapping;
// import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.security.core.userdetails.UsernameNotFoundException;
// import org.springframework.security.crypto.password.PasswordEncoder;

// import lombok.RequiredArgsConstructor;
   

// @Controller
// @RequiredArgsConstructor
// public class RegistrationController {
//   @Autowired
//   private RoleRepository roleRepo;
//   @Autowired
//   private CustomUserDetailServices userService;
//   @Autowired
//   private UserRepository UserRepository;
//   @Autowired
//   private PasswordEncoder passwordEncoder;
//   @Autowired
//   private WatchListRepository watchListRepo;
  
//   @Autowired
//   CustomSecurityService currentUser;

//   @Autowired
//   private RegistrationForm RegForm;

//   @ModelAttribute(name="RegistrationForm")
//   public RegistrationForm form(){
//     return RegForm;
//   }
  
//    @GetMapping("/register")
//    public String showRegisterForm() { 
//      return "signup";
//    }
//    @PostMapping("/register")
//     public String processRegistration(@Valid @ModelAttribute(name="RegistrationForm") RegistrationForm Form, Errors errors,Model model) {  
//       if (errors.hasErrors()){
//           return "signup";
//         }
//         String email = Form.getEmail();
//         Boolean notfound=false;
//         try{
//           userService.loadUserByUsername(email);
//         }catch(UsernameNotFoundException e){
//            notfound =  true;
//         };
//         if(notfound != true){
//             model.addAttribute("UserAlreadyExist", true);
//             return "signup";
//         }
        
//         Form.toUser(UserRepository,passwordEncoder,roleRepo,watchListRepo);
//         model.addAttribute("SuccessfullRegistration", true);
//         return "login";
//     }
// }

