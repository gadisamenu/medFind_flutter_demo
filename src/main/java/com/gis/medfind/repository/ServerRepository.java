package com.gis.medfind.repository;

import com.gis.medfind.entity.Server;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ServerRepository extends JpaRepository<Server,Long> {
}
