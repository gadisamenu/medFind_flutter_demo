package com.gis.medfind.service;

import java.util.List;

import com.gis.medfind.entity.Pharmacy;

public interface SearchByUserLocationService {
    public List<Pharmacy> findPharmaciesByUserLocation(String medicineName, Double userLat, Double userLon);
}
