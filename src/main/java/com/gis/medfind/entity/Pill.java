package com.gis.medfind.entity;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;

import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;

import lombok.Data;

@Data
@Entity
public class Pill{
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    @Column(name = "pill_id")
    private Long id;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "fk_medicine", referencedColumnName = "medicine_id")
    private Medicine medicine;

    @Column(name = "strength", nullable = false, unique = false)
    private int strength;

    @Column(name = "amount", nullable = true, unique = false)
    private int amount;

}