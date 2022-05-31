package com.gis.medfind.repository;
import com.gis.medfind.entity.WatchList;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface WatchListRepository extends JpaRepository<WatchList, Long> {
    @Query(value ="SELECT wl.watch_list_id, * FROM watch_list wl WHERE wl.fk_owner =:id", nativeQuery=true)
    public WatchList findWatchListByUserId(@Param("id") Long userId);

}

