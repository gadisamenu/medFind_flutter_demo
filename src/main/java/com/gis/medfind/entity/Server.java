package com.gis.medfind.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import lombok.Data;


@Entity
@Data
public class Server {
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    @Column(name = "server_id")
    private int id;

    @Column(name = "server_database_name",nullable = true)
    private String databaseName;

    @Column(nullable = true)
    private String username;

    @Column(nullable = true)
    private String password;

    @Column(name = "server_hostname",nullable = true, unique = false)
    private String host;

    @Column(name = "server_listening_port", nullable = true)
    private String port;

    public enum Engine{
        POSTGRES,
        MYSQL,
        MONGO_DB,
        ORACLE
    }
    @Column(name = "database_engine", nullable = true)
    private Engine engine_type = Engine.MYSQL;

    @Column(name = "drug_inventory")
    private String drugInventory;

}
