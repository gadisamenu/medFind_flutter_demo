package com.gis.medfind.entity;
 
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinTable;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

import lombok.Data;
 
@Data
@Entity
@Table(name = "users")
public class User {
     
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
     
    @Column(nullable = true, unique = true, length = 70)
    private String email;
     
    @Column(nullable = true, length = 200)
    private String password;
     
    @Column(name = "first_name", nullable = true, length = 25)
    private String firstName;
     
    @Column(name = "last_name", nullable = true, length = 25)
    private String lastName;
     
    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable( 
        name = "users_roles", 
        joinColumns = @JoinColumn(
          name = "user_id", referencedColumnName = "id"), 
        inverseJoinColumns = @JoinColumn(
          name = "role_id", referencedColumnName = "id")) 
    private List<Role> roles;
}