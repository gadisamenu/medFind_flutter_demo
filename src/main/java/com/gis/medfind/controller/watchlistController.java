// package com.gis.medfind.controller;


// import java.util.List;
// import java.util.HashMap;
// import java.util.Map;

// import com.gis.medfind.Forms.searchForm;
// import com.gis.medfind.entity.Medicine;
// import com.gis.medfind.entity.Pharmacy;
// import com.gis.medfind.repository.MedicineRepository;
// import com.gis.medfind.repository.WatchListRepository;
// import com.gis.medfind.entity.User;
// import com.gis.medfind.entity.WatchList;
// import com.gis.medfind.serviceImplem.CustomSecurityService;
// import com.gis.medfind.serviceImplem.SearchByUserLocationServiceImpl;
// import com.gis.medfind.serviceImplem.WatchListServiceImpl;
// import com.gis.medfind.serviceImplem.RoutingServiceImpl;

// import org.locationtech.jts.geom.Coordinate;
 
// import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.stereotype.Controller;
// import org.springframework.ui.Model;
// import org.springframework.web.bind.annotation.GetMapping;
// import org.springframework.web.bind.annotation.ModelAttribute;
// import org.springframework.web.bind.annotation.PostMapping;
// import org.springframework.web.bind.annotation.RequestMapping;
  
// @Controller
// @RequestMapping("/watchlist")
// public class watchlistController {
//     @Autowired
//     WatchListRepository watchlistRepo;
//     @Autowired
//     searchForm search;
//     @Autowired
//     MedicineRepository medRepo;
//     @Autowired
//     CustomSecurityService currentUser;
//     @Autowired
//     WatchListServiceImpl watchlistServ;

//     @Autowired
//     RoutingServiceImpl routingService;

//     @Autowired
//     SearchByUserLocationServiceImpl searchloc;
    
//     @ModelAttribute("searchForm")
//     public searchForm searchForm() {
//         return search;
//     }
//     @GetMapping
//     public String watchlist(Model model){
//         // User user=currentUser.findLoggedInUser();
//         // model.addAttribute("watchlist", watchlistServ.findWatchListByUserId(user.getId()).getMedicines());
//         return "watchList";
//     }
//     @PostMapping("/addToWatchlist")
//     public String addtoWatchlist(String medicineName,  Model model){
//         // User user=currentUser.findLoggedInUser();
//         // WatchList watchList=watchlistServ.findWatchListByUserId(user.getId());
        
//         Medicine medicine = medRepo.findByName(medicineName);

//         // model.addAttribute("watchlist", watchlistServ.findWatchListByUserId(user.getId()).getMedicines());
//         model.addAttribute("medName", medicineName);

//         if (medicine == null ){
//             model.addAttribute("medicineNotFound", true);
//             return "watchList";
//         }
//         model.addAttribute("medicineNotFound", false);
//         // if(!watchList.getMedicines().contains(medicine)){
//         //     watchList.addMedicine(medicine);
//         //     watchlistRepo.save(watchList);
//         //     model.addAttribute("addSuccess",true);
//         // }
        
//         return "watchList";
//     }
//     @PostMapping("/removeFromWatchlist")
//     public String removeFromWatchlist(String medicineName,Model model){
//         User user=currentUser.findLoggedInUser();
//         WatchList watchList=watchlistServ.findWatchListByUserId(user.getId());
//         // Medicine medicine = medRepo.findByName(medicineName);
//         // watchList.removeMedicine(medicine);
//         watchlistRepo.save(watchList);
//         model.addAttribute("removeSuccess",true);
//         model.addAttribute("medName", medicineName);
//         // model.addAttribute("watchlist", watchlistServ.findWatchListByUserId(user.getId()).getMedicines());
//         return "watchList";
          
//     }
//     @PostMapping("/search")
//     public String searchFromWatchlist(@ModelAttribute("searchForm") searchForm form, Model model){
//         Double userLat = form.getUserlat();
//         Double userLon = form.getUserlong();

//         List<Pharmacy> pharm = searchloc.findPharmaciesByUserLocation(form.getMedicineName(), userLat,
//                 userLon);

        
//         // User user=currentUser.findLoggedInUser();
//         // WatchList watchList = watchlistServ.findWatchListByUserId(user.getId());
        
//         // model.addAttribute("watchlist", watchList.getMedicines());

//         if (pharm.isEmpty()) {
//             model.addAttribute("medicineNotFound",true);
//             return "watchList";
//         }

//         System.out.println(pharm.size());
//         System.out.println(form.getMedicineName());
//         Map<Long, String> routes = new HashMap<>();
//         pharm.forEach(
//             i->{
//                 routes.put(i.getId(),
//                     routingService.findRoute(
//                         new Coordinate(userLat, userLon), 
//                         new Coordinate(i.getLocation().getCoordinate())
//                     )
//                 );
//             }
//         );
    
//         model.addAttribute("routes", routes);
        
//         model.addAttribute("user_lat", form.getUserlat());
//         model.addAttribute("user_lon", form.getUserlong());

//         model.addAttribute("pharmaList", pharm);
//         return "watchList";
          
//     }    

    
// }
