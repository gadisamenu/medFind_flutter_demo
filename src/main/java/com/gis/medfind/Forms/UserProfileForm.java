package com.gis.medfind.Forms;

import com.gis.medfind.entity.User;
import com.gis.medfind.repository.UserRepository;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import lombok.Data;

@Component
@Data
public class UserProfileForm {

    // @NotEmpty(message = "First Name Can't be Empty")
    // @Size(min = 5, message = "First Name must be at least 5 characters long")
    private String firstName;
     
    // @NotEmpty(message = "Last Name Can't be Empty")
    // @Size(min = 5, message = "Last Name must be at least 5 characters long")
    private String lastName;

    // @Email(message = "Invalid Email Address")
    private String email;

    // @NotNull(message = "Password Can't Be Empty")
    // @Size(min = 8, max = 15, message = "Password must be 8-15 characters long")
    private String oldPassword;

    // @NotNull(message = "Password Can't Be Empty")
    // @Size(min = 8, max = 15, message = "Password must be 8-15 characters long")
    private String newPassword;

    public boolean saveData(User user,UserRepository userRepo,PasswordEncoder passEncode){
        if (this.getNewPassword() != null ){
            if (passEncode.encode(this.getOldPassword()) == user.getPassword()){
            user.setPassword(passEncode.encode(this.getNewPassword()));
            }
            else { return false;
        }

        if (this.getLastName() != null) user.setLastName(this.getLastName());
        if (this.getFirstName() != null) user.setFirstName(this.getFirstName());
        if (this.getEmail() != null) user.setEmail(this.getEmail());
        userRepo.save(user);
        user.setEmail(this.email);
        user.setFirstName(this.firstName);
        user.setLastName(this.lastName);
        user.setPassword(passEncode.encode(this.newPassword));

        userRepo.save(user);
        }

        return true;

    }
}
