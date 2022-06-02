package com.gis.medfind.Forms;

import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@Component
public class ReservationForm {

    String tag;

    String medicineName;

    String strength;

    String amount;
}
