// package com.gis.medfind.controller;

// import com.gis.medfind.entity.User;
// import com.gis.medfind.repository.RoleRepository;
// import com.gis.medfind.serviceImplem.CustomSecurityService;

// import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.stereotype.Controller;
// import org.springframework.ui.Model;
// import org.springframework.web.bind.annotation.GetMapping;

// @Controller
// public class LoginController {
//    @Autowired
//    CustomSecurityService sec;
//    @Autowired
//    RoleRepository roleRepo;

//    @GetMapping("/login")
//    public String loginPage(){
//          return "login";
//    }

//     @GetMapping("/login_success")
//     public String loginSuccess(){
//         User user=sec.findLoggedInUser();
//         if (user.getRoles().contains(roleRepo.findByName("USER"))){
//           return "redirect:/home";
//          }
//          else if (user.getRoles().contains(roleRepo.findByName("ADMIN"))){
//                return "redirect:/admin";
//          }
//          else if (user.getRoles().contains(roleRepo.findByName("STAFF"))){
//                return "redirect:/handle_request";
//          }
//          return null;
//          }
//       @GetMapping("/login_failure")
//       public String loginFailure(Model model){
//             model.addAttribute("error",true);
//             return "login";
//       }
//       }
    

