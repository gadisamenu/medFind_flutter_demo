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
    @JoinColumn(name = "fk_user", referencedColumnName = "id",nullable = false)
    private User user;

    @OneToMany(cascade = CascadeType.ALL)
    @JoinTable(
        name= "reservation_pack",
        joinColumns = @JoinColumn(name="reservation_id",referencedColumnName = "reservation_id"),
        inverseJoinColumns=@JoinColumn(name = "medpack_id", referencedColumnName = "medpack_id"))
    private  List<MedPack>  medPacks = new ArrayList<MedPack> ();

    public void add_medpack(MedPack new_medpack){
        this.medPacks.add(new_medpack);
    }

}
