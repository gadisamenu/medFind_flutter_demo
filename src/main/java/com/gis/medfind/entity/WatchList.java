package com.gis.medfind.entity;

import lombok.Data;

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
// import javax.persistence.JoinTable;
// import javax.persistence.ManyToMany;
import javax.persistence.Table;
import javax.persistence.OneToOne;


@Data
@Entity
@Table(name = "watch_list")
public class WatchList{
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    @Column(name = "watchList_id")
    private Long id;
    
    @Column(name = "creation_date")
    private String creationDate;
    
    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "fk_owner")
    private User owner;
    
    @ManyToMany(cascade = CascadeType.ALL)
    @JoinTable(
        name = "watchlist_medpack", 
        joinColumns = @JoinColumn(
            name = "watchlist_id", referencedColumnName = "watchlist_id"), 
        inverseJoinColumns = @JoinColumn(
            name = "medpack_id", referencedColumnName = "medpack_id"))
    private List<MedPack> medPacks = new ArrayList<>();
    
    public void add_medpack(MedPack new_medpack){
        this.medPacks.add(new_medpack);
    }
}
