package com.gis.medfind.repository;

import com.gis.medfind.entity.MedPack;

import org.springframework.data.jpa.repository.JpaRepository;
// import org.springframework.data.jpa.repository.Query;
// import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface MedPackRepository extends JpaRepository<MedPack, Long> {
    
}
