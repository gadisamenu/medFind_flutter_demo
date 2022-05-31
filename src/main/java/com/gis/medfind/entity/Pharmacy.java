package com.gis.medfind.entity;

import lombok.Data;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
// import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
// import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.gis.medfind.utils.utils;
import com.gis.medfind.utils.utils.ConnectionMode;

import org.locationtech.jts.geom.Point;
import org.n52.jackson.datatype.jts.GeometrySerializer;
import org.n52.jackson.datatype.jts.GeometryDeserializer;

@Data
@Entity
public class Pharmacy{
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    @Column(name = "pharmacy_id")
    private int id;

    @Column(name = "pharmacy_name" ,nullable = true, length = 255)
    private String name;

    @Column(name = "pharmacy_location", columnDefinition="Geometry",nullable = true, unique = true)
    @JsonSerialize(using = GeometrySerializer.class)
    @JsonDeserialize(contentUsing = GeometryDeserializer.class)
    private Point location;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "fk_owner", referencedColumnName = "id")
    private User owner;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "fk_server", referencedColumnName = "server_id")
    private Server pharmacyServer;

    @Column(name = "pharmacy_address", unique = false, nullable = true, length = 400)
    private String address;

    // @ManyToOne
    // @JoinColumn(name = "fk_region", referencedColumnName = "region_id")
    // @JsonBackReference
    // private Region region;

    public boolean checkMedicine(String medicineName){
        String query = "SELECT drug_amount FROM "+ this.pharmacyServer.getDrugInventory().toLowerCase()
                        +" WHERE drug_name = \'"+medicineName+"\'";
        
        String amountString = utils.connect(this.pharmacyServer, query,ConnectionMode.GET,"drug_amount");
        int amount = 0;
        if(amountString != "")
            amount = Integer.parseInt(amountString);
        return amount > 10 ? true:false;
    }
}