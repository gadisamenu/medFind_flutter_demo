package com.gis.medfind.serviceImplem;

import com.gis.medfind.service.SearchByUserLocationService;
import org.locationtech.jts.geom.Coordinate;

import java.util.Comparator;
import java.util.List;
import java.util.function.Predicate;

import com.gis.medfind.entity.Pharmacy;
import com.gis.medfind.repository.PharmacyRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class SearchByUserLocationServiceImpl implements SearchByUserLocationService {

    @Autowired
    PharmacyRepository pharmRepo;

    @Autowired
    RoutingServiceImpl distanceService;

    public List<Pharmacy> findPharmaciesByUserLocation(String medicineName, Double userLon, Double userLat){
        
        List<Pharmacy> pharmsCloseToUser = pharmRepo.findAllPharmaciesByDistanceFromUser(userLon, userLat);

        Predicate<Pharmacy> pr = new Predicate<Pharmacy>(){

            @Override
            public boolean test(Pharmacy arg0) {
                return !arg0.checkMedicine(medicineName);
            }

        }; 
        pharmsCloseToUser.removeIf(pr);

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
        pharmsCloseToUser.sort(new PharmacyDistanceComparator(new Coordinate(userLon, userLat)));
        return pharmsCloseToUser;
    }

}
