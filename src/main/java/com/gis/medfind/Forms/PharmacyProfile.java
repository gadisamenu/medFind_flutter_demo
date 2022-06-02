package com.gis.medfind.Forms;
import com.gis.medfind.entity.Server;
import com.gis.medfind.entity.User;

import org.locationtech.jts.geom.Point;
import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@Component
public class PharmacyProfile {

    private String name;

    private Point location;

    private User owner;

    private Server pharmacyServer;

    private String address;
}