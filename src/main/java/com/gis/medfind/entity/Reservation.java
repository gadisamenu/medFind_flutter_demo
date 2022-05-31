package com.gis.medfind.entity;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;

import javax.persistence.*;

import lombok.Data;
import lombok.RequiredArgsConstructor;
@Data

@RequiredArgsConstructor
@Entity
public class Reservation {
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    @Column(name = "reservation_id")
    private Long id;

    @ManyToOne
    @JoinColumn(name = "fk_pharmacy", referencedColumnName = "pharmacy_id" ,nullable = false)
    private Pharmacy pharmacy;
    @ManyToOne
    @JoinColumn(name = "fk_user", referencedColumnName = "user_id",nullable = false)
    private User user;

    @OneToOne
    @JoinColumn(name = "fk_medpack", referencedColumnName = "medpack_id",nullable =false)
    private  List<MedPack>  medPacks = new ArrayList<> ();


}
