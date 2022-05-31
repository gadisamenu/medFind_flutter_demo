package com.gis.medfind.repository;

import com.gis.medfind.entity.Privilege;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface PrivilegeRepository extends JpaRepository<Privilege, Long> {
    @Query(value = "SELECT prev.id, * FROM privilege prev WHERE prev.name = :name", nativeQuery = true)
    Privilege findByName(@Param("name") String name);
}
