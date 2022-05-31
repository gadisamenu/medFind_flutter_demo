package com.gis.medfind.Forms;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import com.gis.medfind.entity.User;
import com.gis.medfind.repository.UserRepository;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import lombok.Data;

@Component
@Data
public class UserProfileForm {

    @NotEmpty(message = "First Name Can't be Empty")
    @Size(min = 5, message = "First Name must be at least 5 characters long")
    private String firstName;
     
    @NotEmpty(message = "Last Name Can't be Empty")
    @Size(min = 5, message = "Last Name must be at least 5 characters long")
    private String lastName;

    @Email(message = "Invalid Email Address")
    private String email;

    @NotNull(message = "Password Can't Be Empty")
    @Size(min = 8, max = 15, message = "Password must be 8-15 characters long")
    private String oldPassword;

    @NotNull(message = "Password Can't Be Empty")
    @Size(min = 8, max = 15, message = "Password must be 8-15 characters long")
    private String newPassword;

    public void saveData(User user,UserRepository userRepo,PasswordEncoder passEncode){
        user.setEmail(this.email);
        user.setFirstName(this.firstName);
        user.setLastName(this.lastName);
        user.setPassword(passEncode.encode(this.newPassword));

        userRepo.save(user);
    }

    
}
