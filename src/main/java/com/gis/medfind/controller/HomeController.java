package com.gis.medfind.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import com.gis.medfind.Forms.searchForm;
import com.gis.medfind.entity.Pharmacy;
// import com.gis.medfind.repository.RegionRepository;
import com.gis.medfind.serviceImplem.RoutingServiceImpl;
// import com.gis.medfind.serviceImplem.SearchByRegionServiceImpl;
import com.gis.medfind.serviceImplem.SearchByUserLocationServiceImpl;

import org.locationtech.jts.geom.Coordinate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class HomeController {
    
    // @Autowired
    // SearchByRegionServiceImpl searchReg;

    // @Autowired
    // RegionRepository regrepo;


    @Autowired
    searchForm search;

    @Autowired
    RoutingServiceImpl routingService;
    
    @Autowired
    SearchByUserLocationServiceImpl searchloc;

    @Autowired
    RoutingServiceImpl router;

    @ModelAttribute(name="searchForm")
    public searchForm search(){
        return search;
    }
 
    @GetMapping("/")
    public String splash(){
        return "splash";
    }
    @GetMapping("/home")
    public String homepage(Model model) {
        // List<String> regionNames = regrepo.getAllRegionNames() ;
        // model.addAttribute("regionNames", regionNames);
        return "home";
    }

    // @PostMapping("/region")
    // public String processSearchRegion(@ModelAttribute searchForm form, Model model) {
    //     String regionName = form.generateRegion().getName();
    //     String medicineName = form.getMedicineName();
    //     List<Pharmacy> pharm = searchReg.findPharmaciesWithInRegion(regionName,
    //             medicineName);
    //     List<String> regionNames = regrepo.getAllRegionNames();
    //     model.addAttribute("regionNames", regionNames);
        
    //     if (pharm.isEmpty()) {
    //         model.addAttribute("medicineNotFound",true);
    //         return "homeResult";
    //     }
               
    //     model.addAttribute("pharmaList", pharm);
    //     return "homeResult";
    // }

    @PostMapping("/location")
    public String processSearchLocation(@Valid searchForm form, Model model){
        Double userLat = form.getUserlat();
        Double userLon = form.getUserlong();

        List<Pharmacy> pharm = searchloc.findPharmaciesByUserLocation(form.getMedicineName(), userLat,
                userLon);
        // List<String> regionNames = regrepo.getAllRegionNames();
        // model.addAttribute("regionNames", regionNames);
        
        if (pharm.isEmpty()) {
            model.addAttribute("medicineNotFound",true);
            return "homeResult";
        }
        
        Map<Integer, String> routes = new HashMap<>();
        pharm.forEach(
            i->{
                routes.put(i.getId(),
                    routingService.findRoute(
                        new Coordinate(userLat, userLon), 
                        new Coordinate(i.getLocation().getCoordinate())
                    )
                );
            }
        );
    
        model.addAttribute("routes", routes);
        model.addAttribute("user_lat", form.getUserlat());
        model.addAttribute("user_lon", form.getUserlong());
        
      
        model.addAttribute("pharmaList", pharm);
        return "homeResult";
    }
} 
