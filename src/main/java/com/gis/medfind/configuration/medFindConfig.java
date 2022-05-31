package com.gis.medfind.configuration;


import java.util.ArrayList;
import java.util.List;

import com.github.filosganga.geogson.gson.GeometryAdapterFactory;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.graphhopper.GraphHopper;
import com.graphhopper.config.CHProfile;
import com.graphhopper.config.Profile;

import org.locationtech.jts.geom.GeometryFactory;
import org.locationtech.jts.geom.PrecisionModel;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;


@Configuration
public class medFindConfig {

    @Bean
    GeometryFactory getGeometry(){
        return new GeometryFactory(new PrecisionModel(), 4326);
    }

    
    @Bean
    GraphHopper getGhopper(){
        List<Profile> profiles = new ArrayList<>();
        profiles.add(new Profile("car").setVehicle("car").setWeighting("fastest").setTurnCosts(false));
        profiles.add(new Profile("foot").setVehicle("foot").setWeighting("shortest"));
        profiles.add(new Profile("bike").setVehicle("bike").setWeighting("fastest"));
        
        GraphHopper hopper = new GraphHopper()
            .setOSMFile("src/main/resources/routing/ethiopia-latest.osm.pbf")
            // specify where to store graphhopper files
            .setGraphHopperLocation("src/main/resources/routing/routing-graph-cache")
            // see docs/core/profiles.md to learn more about profiles
            .setProfiles(profiles);
            // this enables speed mode for the profile we called car
        hopper.getCHPreparationHandler().setCHProfiles(new CHProfile("car"));
        // now this can take minutes if it imports or a few seconds for loading of course this is dependent on the area you import
        return hopper.importOrLoad();
    }
    @Bean(name = "multipartResolver")
    public CommonsMultipartResolver multipartResolver() {
        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver();
        multipartResolver.setMaxUploadSize(10000000);
        return multipartResolver;
    }

    @Bean
    Gson getGson(){
        return new GsonBuilder()
        .registerTypeAdapterFactory(new GeometryAdapterFactory())
        .serializeSpecialFloatingPointValues()
        .create();
    }
    
    
   
}
