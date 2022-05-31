package com.gis.medfind.startup;
 
import java.util.List;
import java.util.Random;
import java.util.random.RandomGenerator;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;

import javax.transaction.Transactional;

// import com.gis.medfind.entity.FileInfo;
import com.gis.medfind.entity.Medicine;
import com.gis.medfind.entity.Pharmacy;
import com.gis.medfind.entity.Privilege;
// import com.gis.medfind.entity.Region;
import com.gis.medfind.entity.Role;
import com.gis.medfind.entity.Server;
import com.gis.medfind.entity.User;
import com.gis.medfind.entity.WatchList;
import com.gis.medfind.entity.Server.Engine;
import com.gis.medfind.repository.*;
import com.gis.medfind.utils.utils;
import com.gis.medfind.utils.utils.ConnectionMode;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import org.json.*;
import org.locationtech.jts.geom.Coordinate;
import org.locationtech.jts.geom.GeometryFactory;
import org.locationtech.jts.geom.Point;
// import org.locationtech.jts.geom.Polygon;


@Component
public class StartUpDataLoader implements ApplicationListener<ContextRefreshedEvent> {

    boolean started = false;

    @Autowired
    private PrivilegeRepository privRepo;

    @Autowired
    private RoleRepository roleRepo;

    @Autowired
    private MedicineRepository medicineRepo;

    @Autowired
    private UserRepository userRepo;

    @Autowired
    private GeometryFactory geometryFactory;

    @Autowired
    private PasswordEncoder passwordEncoder;
    
    // @Autowired
    // private FileInfoRepository fileRepo;
    
    // @Autowired
    // private RegionRepository regionRepo;
    
    @Autowired
    private ServerRepository serverRepo;
    
    @Autowired
    private PharmacyRepository pharmRepo;

    @Autowired
    private WatchListRepository watchlistRepo;
 
    @Override
    @Transactional
    public void onApplicationEvent(ContextRefreshedEvent event) {

        this.userSetup();
        this.loadMedicines();
        // this.loadRegionBoundaries();
        this.loadPharmacies();
        
        started = true;
    }

    @Transactional
    void userSetup(){

        if (roleRepo.count() > 0)
            return;

        Privilege readPrivilege = getOrCreatePrivilegeIfNotFound("READ");

        Privilege writePrivilege= getOrCreatePrivilegeIfNotFound("WRITE");

        Privilege deletePrivilege = getOrCreatePrivilegeIfNotFound("DELETE");
 
        List<Privilege> adminPrivileges = new ArrayList<>();
            adminPrivileges.add(readPrivilege);
            adminPrivileges.add(writePrivilege);
            adminPrivileges.add(deletePrivilege);

        List<Privilege> userPrivileges = new ArrayList<>();
            userPrivileges.add(readPrivilege);

        List<Privilege> staffPrivileges = new ArrayList<>();
            userPrivileges.add(writePrivilege);


        getOrCreateRoleIfNotFound("ADMIN", adminPrivileges);
        getOrCreateRoleIfNotFound("USER", userPrivileges);
        getOrCreateRoleIfNotFound("STAFF", staffPrivileges);
        //...other roles

        //Create an Admin User
        Role adminRole = roleRepo.findByName("ADMIN");
        User user = new User();
            user.setEmail("amhaznif@gmail.com");
            user.setFirstName("Amha");
            user.setLastName("Kindu");
            user.setPassword(passwordEncoder.encode("WARMACHINEROX"));
            List<Role> role = new ArrayList<>();
                role.add(adminRole);
            user.setRoles(role);
        if(userRepo.findByEmail(user.getEmail())==null)
            userRepo.save(user);

        //Create Validator 
        Role staffrole = roleRepo.findByName("STAFF");
        user = new User();
            user.setEmail("amhakindu@gmail.com");
            user.setFirstName("Gabriel");
            user.setLastName("Kassa");
            user.setPassword(passwordEncoder.encode("password"));
            role = new ArrayList<>();
                role.add(staffrole);
            user.setRoles(role);
        if(userRepo.findByEmail(user.getEmail())==null)
            userRepo.save(user);

        //Create Pharmacy Owner 
        Role customerRole = roleRepo.findByName("USER");
        user = new User();
            user.setEmail("segniDessalegn@gmail.com");
            user.setFirstName("Segni");
            user.setLastName("Dessalegn");
            user.setPassword(passwordEncoder.encode("gadisa"));
            role = new ArrayList<>();
                role.add(customerRole);
            user.setRoles(role);
        WatchList w= new WatchList();
            w = watchlistRepo.save(w);
            w.setOwner(user);
        if(userRepo.findByEmail(user.getEmail())==null)
            userRepo.save(user);
    }

    @Transactional
    Privilege getOrCreatePrivilegeIfNotFound(String name) {
 
        Privilege privilege = privRepo.findByName(name);
        if (privilege == null) {
            privilege = new Privilege();
                privilege.setName(name);
            privRepo.save(privilege);
        }
        return privilege;
    }
    
    @Transactional
    Role getOrCreateRoleIfNotFound(String name, List<Privilege> privileges) {
 
        Role role = roleRepo.findByName(name);
        if (role == null) {
            role = new Role();
            role.setName(name);
            role.setPrivileges(privileges);
            roleRepo.save(role);
        }
        return role;
    }
    @Transactional
    boolean loadMedicines() {
        if(medicineRepo.count() > 0){
            System.out.println("Already loaded medicines");
            return false;
        }
        BufferedReader bf = null;
        try{
            String path = "src/main/java/com/gis/medfind/startup/InitialData";
            FileReader fr = new FileReader(path + "/drugs.json");
            bf = new BufferedReader(fr);

            String data = "";
            String line = bf.readLine();
            while(line != null){
                data += line;
                line = bf.readLine();
            }
            JSONObject obj = new JSONObject(data);
            JSONArray drug_array = obj.getJSONArray("drugs");
            for(int i = 0;i < drug_array.length();i++){
                Medicine med = new Medicine();
                    med.setName(drug_array.getString(i));
                medicineRepo.save(med);
            }
            return true;
            
        }catch(IOException io)
        {
            System.out.println("Couldnot find file!!");
        }
        return true;
    }
    // @Transactional
    // boolean loadRegionBoundaries() {
    //     if(regionRepo.count() > 0){
    //         System.out.println("Already loaded Region Boundaries");
    //         return false;
    //     }
    //     BufferedReader bf = null;
    //     try{
    //         String path = "src/main/java/com/gis/medfind/startup/InitialData";
    //         FileReader fr = new FileReader(path + "/addisababa_subcity_boundaries.json");
    //         bf = new BufferedReader(fr);

    //         String data = "";
    //         String line = bf.readLine();
    //         while(line != null){
    //             data += line;
    //             line = bf.readLine();
    //         }
    //         JSONObject obj = new JSONObject(data);
    //         JSONArray featuresArray = obj.getJSONArray("features");
            
    //         for(int j = 0; j < featuresArray.length();j++){
                
    //             JSONObject feat = featuresArray.getJSONObject(j);
    //             JSONObject poly = feat.getJSONObject("geometry");
    //             String name = feat.getJSONObject("properties").getString("name");
    //             JSONArray coords = poly.getJSONArray("coordinates");
    //             JSONArray coordinates = coords.getJSONArray(0);

    //             Coordinate[] polygonPoints = new Coordinate[coordinates.length()];
    //             for(int i = 0;i<coordinates.length();i++){
    //                 JSONArray location = coordinates.getJSONArray(i);
    //                 Double latitude = location.getDouble(0);
    //                 Double longitude = location.getDouble(1);
    //                 Coordinate coor = new Coordinate(longitude, latitude);
    //                 polygonPoints[i] = coor;
    //             }
    //             Polygon border = geometryFactory.createPolygon(polygonPoints);
    //             border.setSRID(4326);

    //             Region region = new Region();
    //                 region.setBoundary(border);
    //                 region.setName(name);
    //             region = regionRepo.save(region);
    //         }
    //     }catch(IOException io)
    //     {
    //         System.out.println("Couldnot find file!!");
    //     }finally{
    //         try{
    //             bf.close();
    //         }catch(IOException io){}
    //     }
    //     return true;
    // }
    

    @Transactional
    boolean loadPharmacies() {
        if(pharmRepo.count() > 0){
            System.out.println("Already loaded Pharmacies");
            return false;
        }
        
        BufferedReader bf = null;
        try{
            String path = "src/main/java/com/gis/medfind/startup/InitialData";
            FileReader fr = new FileReader(path + "/pharmacies_in_addisababa.json");
            bf = new BufferedReader(fr);

            String data = "";
            String line = bf.readLine();
            while(line != null){
                data += line;
                line = bf.readLine();
            }
            JSONObject obj = new JSONObject(data);

            JSONArray featuresArray = obj.getJSONArray("features");
            for(int i = 0; i< featuresArray.length();i++){
                Double coordinate[] = new Double[2];
                String name;
                try{
                    JSONObject node = featuresArray.getJSONObject(i).getJSONObject("properties");
                    name = node.getString("name");
                    JSONObject geom = featuresArray.getJSONObject(i).getJSONObject("geometry");
                    coordinate[0] = geom.getJSONArray("coordinates").getDouble(1);
                    coordinate[1] = geom.getJSONArray("coordinates").getDouble(0);
                    

                }catch(JSONException je){
                    continue;
                }
                

                Pharmacy pharm = new Pharmacy();
                pharm.setName(name);
                Coordinate location = new Coordinate(coordinate[0], coordinate[1]);
                Point geomPoint = geometryFactory.createPoint(location);
                geomPoint.setSRID(4326);
                pharm.setLocation(geomPoint);
                pharm.setAddress(utils.reverseGeocode(geomPoint.getX(), geomPoint.getY()));
                pharm = pharmRepo.save(pharm);
                // name = "license_"+pharm.getId();     
                    // FileInfo license = new FileInfo();
                    //     license.setName(name);
                    //     license.setUrl("uploads/license/");
                    // license = fileRepo.save(license);
                
                // Point tempLoc = pharm.getLocation();
                // Region surround = regionRepo.findRegionContaining(tempLoc);
                // pharm.setRegion(surround);
                // if(surround != null)
                // {
                //     System.out.println("------->>>"+surround.getName());
                // }else{System.out.println("----------->>>null");}
                pharm = pharmRepo.save(pharm);
                pharm.setOwner(userRepo.findByEmail("segniDessalegn@gmail.com"));
                    Server pharmServer = new Server();
                        pharmServer.setDatabaseName("drugstore");
                        pharmServer.setDrugInventory("Table_"+pharm.getId());
                        pharmServer.setEngine_type(Engine.POSTGRES);
                        pharmServer.setHost("localhost");
                        pharmServer.setPassword("123456789");
                        pharmServer.setPort("5432");
                        pharmServer.setUsername("postgres");
                    pharmServer = serverRepo.save(pharmServer);
                pharm.setPharmacyServer(pharmServer);
                pharm = pharmRepo.save(pharm);
                String query = "CREATE TABLE table_"+pharm.getId()+
                        "(id SERIAL,"+
                        "drug_name VARCHAR(100) UNIQUE, "+
                        "drug_amount int); ";

                for(Medicine med: medicineRepo.findAll()){
                    RandomGenerator rg = new Random();
                    int amount = rg.nextInt(0, 200);;
                    query += " INSERT INTO table_"+pharm.getId()+
                             " (drug_name, drug_amount) "+
                             " VALUES (\'"+med.getName()+"\',"+amount+"); ";
                }
                utils.connect(pharm.getPharmacyServer(), query, ConnectionMode.POST,"");
            }
        }catch(IOException io)
        {
            System.out.println("Couldnot find file!!");
        }
        
        return true;
    }
}
