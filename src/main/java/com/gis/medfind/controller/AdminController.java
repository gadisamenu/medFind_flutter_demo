// package com.gis.medfind.controller;

// import java.util.List;

// import javax.validation.Valid;

// import com.gis.medfind.entity.Pharmacy;
// import com.gis.medfind.entity.User;
// import com.gis.medfind.repository.PharmacyRepository;
// import com.gis.medfind.repository.UserRepository;

// import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.stereotype.Controller;
// import org.springframework.ui.Model;
// import org.springframework.web.bind.annotation.GetMapping;
// import org.springframework.web.bind.annotation.ModelAttribute;
// import org.springframework.web.bind.annotation.PathVariable;
// import org.springframework.web.bind.annotation.PostMapping;




// import com.gis.medfind.Forms.RegistrationForm;
// import com.gis.medfind.repository.RoleRepository;

// import com.gis.medfind.repository.WatchListRepository;
// import com.gis.medfind.serviceImplem.CustomSecurityService;
// import com.gis.medfind.serviceImplem.CustomUserDetailServices;
// import org.springframework.validation.Errors;

// import org.springframework.security.core.userdetails.UsernameNotFoundException;
// import org.springframework.security.crypto.password.PasswordEncoder;






// @Controller

// public class AdminController {
    
//     @Autowired
//     private RoleRepository roleRepo;
//     @Autowired
//     private CustomUserDetailServices userService;
//     @Autowired
//     private UserRepository UserRepository;
//     @Autowired
//     private PasswordEncoder passwordEncoder;
//     @Autowired
//     private WatchListRepository watchListRepo;

//     @Autowired
//     private RegistrationForm RegForm;
    
//     @Autowired
//     CustomSecurityService currentUser;
    
//     @Autowired
//     UserRepository userRepo;
    
//     @Autowired
//     PharmacyRepository pharmaRepo;

//     @ModelAttribute(name="RegistrationForm")
//     public RegistrationForm form(){
//     return RegForm;
//     }


//     @GetMapping("/admin")
//     public String admin() {
//         return "admin";
//     }
//     @GetMapping("/admin/users")
//     public String showUsers(Model model) {
//         List<User> users = userRepo.findAll();
//         model.addAttribute("users", users);
//         return "admin";
//     }

//     @GetMapping("/admin/pharmacies")
//     public String showPharmacies(Model model) {
//         List<Pharmacy> pharmacies = pharmaRepo.findAll();
//         model.addAttribute("pharmacies", pharmacies);
//         return "admin";
//     }


//     @PostMapping("/admin/register")
//     public String processRegistration(@Valid @ModelAttribute(name = "RegistrationForm") RegistrationForm Form,
//             Errors errors, Model model) {

//         if (errors.hasErrors()) {
//             return "admin";
//         }
//         String email = Form.getEmail();
//         Boolean notfound = false;
//         try {
//             userService.loadUserByUsername(email);
//         } catch (UsernameNotFoundException e) {
//             notfound = true;
//         }
//         ;

//         if (notfound != true) {
//             model.addAttribute("UserAlreadyExist", true);
//             return "admin";
//         }

//         Form.toUser(UserRepository, passwordEncoder, roleRepo, watchListRepo);
//         model.addAttribute("SuccessfullRegistration", true);
//         return "admin";
//     }

//     @PostMapping( value = "/admin/delete/user/{id}")
//     public String deleteUser(@PathVariable("id") Long id ,Model model) {
//         userRepo.deleteById(id);
//         model.addAttribute("users", userRepo.findAll());
//         return "admin";
//     }
// //     @RequestMapping(value = "/users/{id}", method = RequestMethod.DELETE)
// //  public void deleteUser(@PathVariable String id) {
// //       userService.deleteUser(id);
// //  }
// }
