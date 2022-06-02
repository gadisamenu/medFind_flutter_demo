// package com.gis.medfind.controller;

// import javax.validation.Valid;

// import com.gis.medfind.Forms.UserProfileForm;
// import com.gis.medfind.entity.User;
// import com.gis.medfind.repository.UserRepository;
// import com.gis.medfind.serviceImplem.CustomSecurityService;

// import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.security.crypto.password.PasswordEncoder;
// import org.springframework.stereotype.Controller;
// import org.springframework.ui.Model;
// import org.springframework.validation.Errors;
// import org.springframework.web.bind.annotation.GetMapping;
// import org.springframework.web.bind.annotation.ModelAttribute;
// import org.springframework.web.bind.annotation.PostMapping;

// @Controller
// public class userAccountController {
//     @Autowired
//     CustomSecurityService currentUser;

//     @Autowired
//     UserRepository userRepo;
 
//     @Autowired 
//     PasswordEncoder encoder;


//     @Autowired
//     private UserProfileForm profileForm;

//     @ModelAttribute(name="profileForm")
//     public UserProfileForm getProfileForm() {
//         return profileForm;
//     }

//     @ModelAttribute(name = "currentUser")
//     public User getCurrentUser() {
//         return currentUser.findLoggedInUser();
        
//     }

//     @GetMapping("/profile")
//     public String getProfile(Model model) {

//         return "profile";
//     }
      
//     @PostMapping("/changeCredential")
//     public String changeCredential(@Valid @ModelAttribute UserProfileForm Form, Errors errors) {
//         if (errors.hasErrors()) {
//             return "profile";
//         }
//         User user = currentUser.findLoggedInUser();
//         if (encoder.encode(Form.getOldPassword()) == user.getPassword()) {
//             Form.saveData(user, userRepo, encoder);
//             return "profile";
//         }

//         return "profile";
//     }
    
    
    

    
// }
