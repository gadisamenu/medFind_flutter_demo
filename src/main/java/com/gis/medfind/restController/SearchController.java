package com.gis.medfind.restController;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.gis.medfind.serviceImplem.RoutingServiceImpl;
import com.gis.medfind.serviceImplem.SearchByUserLocationServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.gis.medfind.Forms.searchForm;
import com.gis.medfind.entity.Pharmacy;




@RestController
@RequestMapping(consumes = "application/json",produces = "application/json")
class SearchController{
    @Autowired
    RoutingServiceImpl routingService;
    
    @Autowired
    SearchByUserLocationServiceImpl searchloc;

    @Autowired
    RoutingServiceImpl router;

    @RequestMapping(value ="/api/v1/search",method = RequestMethod.POST,  consumes="application/json")
    public ResponseEntity<?> processSearchLocation(@RequestBody searchForm form){
        Double userLat = (form.getUserlat());
        Double userLon = (form.getUserlong());
        // Double userLat = 30.34034;
        // Double userLon = 27.02334;
      
        List<Pharmacy> pharm = searchloc.findPharmaciesByUserLocation(form.getMedicineName(), userLat, userLon);
        
        List<Map<String,String>> sizedPharm  = new ArrayList<>();

        
           pharm.forEach(
            i->{
                Map<String,String>  phar = new HashMap<>();
                phar.put("id", i.getId().toString());
                phar.put("name",i.getName());
                phar.put("address",i.getAddress());
                sizedPharm.add(phar);
            }
            );
          return new ResponseEntity<List<Map<String,String>>>(sizedPharm, HttpStatus.OK);
    }

}

    




   


 
 
