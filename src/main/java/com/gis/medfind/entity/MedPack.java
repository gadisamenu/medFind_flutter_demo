package com.gis.medfind.entity;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;

import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;

import lombok.Data;


@Data
@Entity
public class MedPack{
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    @Column(name = "medpack_id")
    private Long id;

    @Column(name = "tag" ,nullable = true, length = 500)
    private String tag;

    @ManyToMany(cascade = CascadeType.ALL)
    @JoinTable(
        name = "medpack_pill", 
        joinColumns = @JoinColumn(
            name = "medpack_id", referencedColumnName = "medpack_id"), 
        inverseJoinColumns = @JoinColumn(
            name = "pill_id", referencedColumnName = "pill_id"))
    private List<Pill> pills = new ArrayList<>();

    public void addPill(Pill pl){
        this.pills.add(pl);
    }

}