package com.gis.medfind.serviceImplem;


import com.gis.medfind.entity.User;
import com.gis.medfind.repository.UserRepository;
import com.gis.medfind.security.CustomUserDetails;
import com.gis.medfind.service.SecurityService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

@Service
public class CustomSecurityService implements SecurityService{
    @Autowired
    private UserRepository userRepo;

    @Override
    public User findLoggedInUser() {
        Object userDetails = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (userDetails instanceof UserDetails) {
            String email=((CustomUserDetails)userDetails).getEmail();
            return userRepo.findByEmail(email);
        }

        return null;
    }
}
