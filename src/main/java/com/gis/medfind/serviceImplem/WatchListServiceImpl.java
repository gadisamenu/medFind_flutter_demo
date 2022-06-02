
package com.gis.medfind.serviceImplem;

import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.function.Predicate;

import javax.persistence.EntityNotFoundException;

import com.gis.medfind.entity.MedPack;
import com.gis.medfind.entity.Pharmacy;
import com.gis.medfind.entity.Pill;
import com.gis.medfind.entity.User;
import com.gis.medfind.entity.WatchList;
import com.gis.medfind.repository.MedPackRepository;
import com.gis.medfind.repository.MedicineRepository;
import com.gis.medfind.repository.PillRepository;
import com.gis.medfind.repository.UserRepository;
import com.gis.medfind.repository.WatchListRepository;
import com.gis.medfind.service.WatchListService;

import org.locationtech.jts.geom.Coordinate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class WatchListServiceImpl implements WatchListService{

    @Autowired
    private WatchListRepository watchlist_repo;

    @Autowired
    private UserRepository userRepo;

    @Autowired
    private MedicineRepository medicineRepo;

    @Autowired
    private MedPackRepository medPackRepo;

    @Autowired
    private SearchByUserLocationServiceImpl medicineSearchService;

    @Autowired
    private RoutingServiceImpl distanceService;

    @Autowired
    private PillRepository pillRepo;

    public WatchList createWatchList(Long user_id){
        User user = userRepo.getById(user_id);
        WatchList watch_list = new WatchList();
            watch_list.setOwner(user);
            watch_list.setCreationDate(new Date().toString());
            watch_list.setMedPacks(new ArrayList<>());
        return watchlist_repo.save(watch_list);
    }

    public WatchList findWatchListByUserId(Long user_id){ 
        return watchlist_repo.findWatchListByUserId(user_id);
    }

    public MedPack createMedpack(String tag){
        MedPack medpack = new MedPack();
            medpack.setTag(tag);
        return medPackRepo.save(medpack);
    }

    //Create
    public MedPack createMedpackInWatchlist(Long user_id, String tag){
        WatchList watch_list = findWatchListByUserId(user_id);
        MedPack new_medpack = createMedpack(tag);

        watch_list.add_medpack(new_medpack);
        watchlist_repo.save(watch_list);
        return new_medpack;
    }

    //Read
    public List<MedPack> getMedpacksFromWatchlist(Long user_id){
        WatchList watch_list = findWatchListByUserId(user_id);
        return watch_list.getMedPacks();
    }

    //Update
    public Pill addPillToMedpack(Long medpack_id, String medicine_name, int strength, int amount){
        Pill pill = new Pill();
        pill.setMedicine(medicineRepo.findByName(medicine_name));
        pill.setStrength(strength);
        pill.setAmount(amount);
        pillRepo.save(pill);

        MedPack medpack = medPackRepo.getById(medpack_id);
        medpack.addPill(pill);
        medPackRepo.save(medpack);
        return pill;
    }

    public boolean removePillFromMedpack(Long pill_id, Long medpack_id){
        MedPack medpack = medPackRepo.getById(medpack_id);
        List<Pill> pills = medpack.getPills();

        Predicate<Pill> pill_filter = new Predicate<Pill>(){

            @Override
            public boolean test(Pill arg0) {
                return arg0.getId() == pill_id;
            }

        }; 

        boolean removed = pills.removeIf(pill_filter);
        if(!removed)
            return false;

        medpack.setPills(pills);
        medPackRepo.save(medpack);
        return true;
    }

    public MedPack editMedpackTag(Long medpack_id, String new_tag){
        MedPack medpack = medPackRepo.getById(medpack_id);
        medpack.setTag(new_tag);
       return medPackRepo.save(medpack);
    }

    public Pill updatePillAmount(Long pill_id, int amount){
        Pill pill = pillRepo.getById(pill_id);
        pill.setAmount(amount);
        return pillRepo.save(pill);
    }

    public Pill updatePillStrength( Long pill_id, int strength){
        Pill pill = pillRepo.getById(pill_id);
        pill.setStrength(strength);
        return pillRepo.save(pill);
    }
    //Delete
    public boolean deleteMedpack(Long user_id, Long medpack_id){
        try{
            WatchList watch_list = findWatchListByUserId(user_id);
            List<MedPack> medpack = watch_list.getMedPacks();

            Predicate<MedPack> medpack_filter = new Predicate<>(){
                @Override
                public boolean test(MedPack arg0) {
                    return arg0.getId() == medpack_id;
                }
            };
            medpack.removeIf(medpack_filter);
            watch_list.setMedPacks(medpack);
            watchlist_repo.save(watch_list);

            medPackRepo.deleteById(medpack_id);

            return true;
        }
        catch (EntityNotFoundException e) {
            return false;
        }
    }

    public List<Pharmacy> findMedicinesCloseToUser(Long medpack_id, double user_lat, double user_lon)
    {   
        MedPack medpack = medPackRepo.getById(medpack_id);
        Set<Pharmacy> pharmacies = new HashSet<>();
        for(Pill pill: medpack.getPills()){
            List<Pharmacy> pharm_with_med = medicineSearchService.findPharmaciesByUserLocation(pill.getMedicine().getName(), user_lon, user_lat);
            pharmacies.addAll(pharm_with_med);
        }
        List<Pharmacy> pharmacies_with_medicines = new ArrayList<Pharmacy>();
        pharmacies_with_medicines.addAll(pharmacies);
        
        class PharmacyDistanceComparator implements Comparator<Pharmacy>{
            Coordinate ref;
            public PharmacyDistanceComparator(Coordinate ref){
                this.ref = ref;
            }
            @Override
            public int compare(Pharmacy arg0, Pharmacy arg1) {
                double pharm1Distance = distanceService.shortestPathDistance(
                    ref,
                    new Coordinate(arg0.getLocation().getX(), arg0.getLocation().getY()));
                double pharm2Distance = distanceService.shortestPathDistance(
                    ref, 
                    new Coordinate(arg1.getLocation().getX(), arg1.getLocation().getY()));

                return Float.valueOf((float)pharm1Distance).compareTo(Float.valueOf((float)pharm2Distance));
            }
        }
        pharmacies_with_medicines.sort(new PharmacyDistanceComparator(new Coordinate(user_lon, user_lat)));
        return pharmacies_with_medicines;
    }
    
}