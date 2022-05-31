
package com.gis.medfind.serviceImplem;

import java.util.Locale;
import java.util.Map;
import java.text.DecimalFormat;
import java.util.HashMap;


import com.gis.medfind.service.RoutingService;
import com.google.gson.Gson;
import com.graphhopper.GHRequest;
import com.graphhopper.GHResponse;
import com.graphhopper.GraphHopper;
import com.graphhopper.ResponsePath;
import com.graphhopper.util.Instruction;
import com.graphhopper.util.InstructionList;
import com.graphhopper.util.Parameters;
import com.graphhopper.util.PointList;
import com.graphhopper.util.Translation;

import org.locationtech.jts.geom.Coordinate;
import org.locationtech.jts.geom.LineString;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class RoutingServiceImpl implements RoutingService{

    @Autowired
    GraphHopper hopper;

    @Autowired
    Gson gson;

    @Override
    public double shortestPathDistance(Coordinate source, Coordinate target){
        System.out.println("****************Distance*********************");
        System.out.println(target.getX()+ " " +target.getY());
        System.out.println(source.getX()+ " " +source.getY());
        GHRequest req = new GHRequest(source.getX(), source.getY(), target.getX(), target.getY())
                // note that we have to specify which profile we are using even when there is only one like here
                         .setProfile("car")
                         .setAlgorithm(Parameters.Algorithms.DIJKSTRA_BI);

        System.out.println(source.getX()+","+source.getY());
        System.out.println(target.getX()+","+target.getY());
        GHResponse rsp = hopper.route(req);
        return rsp.getBest().getDistance();
    }

    @Override
    public String findRoute(Coordinate source, Coordinate target){
        System.out.println("****************Routes*********************");
        System.out.println(target.getX()+ " " +target.getY());
        System.out.println(source.getX()+ " " +source.getY());
        // simple configuration of the request object
        GHRequest req = new GHRequest(source.getX(), source.getY(), target.getX(), target.getY())
                // note that we have to specify which profile we are using even when there is only one like here
                         .setProfile("car")
                // define the language for the turn instructions
                         .setLocale(Locale.US)
                         .setAlgorithm(Parameters.Algorithms.DIJKSTRA_BI);

        GHResponse rsp = hopper.route(req);
        // handle errors
        if (rsp.hasErrors())
            throw new RuntimeException(rsp.getErrors().toString());

        // use the best path, see the GHResponse class for more possibilities.
        ResponsePath path = rsp.getBest();
        

        // points, distance in meters and time in millis of the full path
        PointList routePoints = path.getPoints();
        double totalDistance = path.getDistance();

        Translation tr = hopper.getTranslationMap().getWithFallBack(Locale.US);
        InstructionList il = path.getInstructions();
        
        String turnInstructions = "<p style='text-align:center; font-weight:bold; font-size:1.5rem;'>Turn Instruction</p>";
        DecimalFormat df = new DecimalFormat("0.00");
        // iterate over all turn instructions
        for (Instruction instruction : il) {
            System.out.println("distance " + instruction.getDistance() + " for instruction: " + instruction.getTurnDescription(tr));
            turnInstructions += "<p>"+instruction.getTurnDescription(tr)+"-distance: "+df.format(instruction.getDistance())+"m </p>";
        }
        
        LineString routeLineString = routePoints.toLineString(false);
        

        Coordinate[] cr = routeLineString.getCoordinateSequence().toCoordinateArray();
        Double[][] coords = new Double[cr.length][2];

        for(int i=0;i<cr.length;i++){
            coords[i][0] = cr[i].x;
            coords[i][1] = cr[i].y;
        }

        Map<String, Object> geom = new HashMap<>();
            geom.put("type", "LineString");
            geom.put("coordinates", coords);
            geom.put("totalDistance", totalDistance);
            geom.put("turnInstruction", turnInstructions);

        String routeGeoJson = gson.toJson(geom);
        

        return routeGeoJson;
        
    }

}