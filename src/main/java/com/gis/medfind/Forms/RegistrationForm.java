package com.gis.medfind.Forms;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

// import com.gis.medfind.entity.Medicine;
import com.gis.medfind.entity.Role;
import com.gis.medfind.entity.User;
import com.gis.medfind.entity.WatchList;
import com.gis.medfind.repository.RoleRepository;
import com.gis.medfind.repository.UserRepository;
import com.gis.medfind.repository.WatchListRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import lombok.Data;

 
@Data
@Component
public class RegistrationForm {

    @Autowired
    private UserRepository userRepo;

    @Email(message = "Invalid Email Address")
    private String email;
     
    @NotBlank(message = "Password Can't Be Empty")
    @Size(min = 8, max = 15, message = "Password must be 8-15 characters long")
    private String password;
     
    @NotBlank(message = "First Name Can't be Empty")
    @Size(min = 5, message = "First Name must be at least 5 characters long")
    private String firstName;
     
    @NotBlank(message = "Last Name Can't be Empty")
    @Size(min = 5, message = "Last Name must be at least 5 characters long")
    private String lastName;


    public User toUser(UserRepository userRepo,PasswordEncoder passwordEncoder, RoleRepository roleRepo, WatchListRepository watchListRepo){
        User user = new User();
        user.setLastName(this.getLastName());
        user.setFirstName(this.getFirstName());
        user.setEmail(this.getEmail());
        user.setPassword(passwordEncoder.encode(this.getPassword()));
        user.setRoles(new ArrayList<Role>());
        Role role = roleRepo.findByName("USER");
        user.getRoles().add(role);
        userRepo.save(user);
        WatchList watch_list = new WatchList();
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
        LocalDateTime now = LocalDateTime.now();  
        watch_list.setCreationDate(dtf.format(now));
        // watch_list.setMedicines(new ArrayList<Medicine>());
        watch_list.setOwner(user);
        watchListRepo.save(watch_list);
        return user;
    }
     
    
    
}
