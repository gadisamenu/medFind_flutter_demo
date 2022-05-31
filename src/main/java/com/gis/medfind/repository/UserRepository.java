package com.gis.medfind.repository;

import com.gis.medfind.entity.User;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;


@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    @Query(value = "SELECT u.id, u.email,u.password "+ 
                    ",u.first_name, u.last_name FROM users u "+
                    "INNER JOIN users_roles ur "+
                    "ON u.id = ur.user_id "+
                    "WHERE u.email = :email", nativeQuery = true)
    User findByEmail(@Param("email") String email);

    User findByFirstName(String firstName);
}
