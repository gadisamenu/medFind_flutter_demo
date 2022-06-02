package com.gis.medfind.Forms;
import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@Component
public class PillForm{
    private String medicine_name;

    private int strength;

    private int amount;

}
