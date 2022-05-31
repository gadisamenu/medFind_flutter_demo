package com.gis.medfind.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;

import javax.persistence.Id;


import lombok.Data;

@Data
@Entity
public class Medicine{
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    @Column(name = "medicine_id")
    private Long id;

    @Column(name ="medicine_name", nullable = true, unique = false)
    private String name;

}