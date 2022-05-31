package com.gis.medfind.repository;

import com.gis.medfind.entity.Medicine;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface MedicineRepository extends JpaRepository<Medicine, Long> {
    @Query(value = "SELECT med.medicine_id, * FROM medicine med WHERE med.medicine_name = :medicineName", nativeQuery = true)
    Medicine findByName(@Param("medicineName") String medicineName);
}
