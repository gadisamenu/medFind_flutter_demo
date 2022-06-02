package com.gis.medfind.service;

import java.util.List;

import com.gis.medfind.entity.MedPack;
import com.gis.medfind.entity.Pharmacy;
import com.gis.medfind.entity.Pill;
import com.gis.medfind.entity.WatchList;

public interface WatchListService {

    public WatchList createWatchList(Long user_id);
    public WatchList findWatchListByUserId(Long user_id);
    public List<Pharmacy> findMedicinesCloseToUser(Long medpack_id,  double user_lat, double user_lon);

    //Create
    public MedPack createMedpackInWatchlist(Long user_id, String tag);

    //Read
    public List<MedPack> getMedpacksFromWatchlist(Long user_id);

    //Update
    public Pill addPillToMedpack(Long medpack_id, String medicine_name, int strength, int amount);
    public boolean removePillFromMedpack(Long pill_id, Long medpack_id);
    public MedPack editMedpackTag(Long medpack_id, String new_tag);
    public Pill updatePillAmount(Long pill_id, int amount);
    public Pill updatePillStrength(Long pill_id, int strength);

    //Delete
    public boolean deleteMedpack(Long user_id, Long medpack_id);
}
