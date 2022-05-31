package com.gis.medfind.service;

import com.gis.medfind.entity.User;

public interface SecurityService {
    public User findLoggedInUser();
}
