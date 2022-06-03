package com.gis.medfind.Forms;

import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@Component
public class PharmacyProfile {

    private String name;

    private String  owner_id;

    private String address;
}