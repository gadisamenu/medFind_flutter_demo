package com.gis.medfind.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.atlis.location.model.impl.Address;
import com.atlis.location.model.impl.MapPoint;
import com.atlis.location.nominatim.NominatimAPI;
import com.gis.medfind.entity.Server;

import org.apache.log4j.BasicConfigurator;



public class utils {

    private static String urlHeader = "jdbc:postgresql://";

    public enum ConnectionMode{
        POST,
        GET
    }
    public static String connect(Server sv, String query,ConnectionMode cm, String objectName) {
        Connection conn = null;
        ResultSet info = null;        
        try {
            String url = urlHeader + sv.getHost()+":"+sv.getPort()+"/"+sv.getDatabaseName();
            System.out.println(url);
            conn = DriverManager.getConnection(url, sv.getUsername(), sv.getPassword());
            System.out.println("Connected to the PostgreSQL server successfully.");
            
            Statement queryStmnt = conn.createStatement();
            if(cm == ConnectionMode.GET){
                info = queryStmnt.executeQuery(query);
                if(info.next()){
                    return info.getString(objectName);
                }
            }else{
                queryStmnt.execute(query);
            }
            
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            System.out.println("Connection to PostgreSQL server Failed!!");
        }
        finally{
            try{
                conn.close();
            }catch(SQLException sql){}
        }
        return "";
    }
    public static String reverseGeocode(Double lat, Double lon){
        BasicConfigurator.configure();

        String endpointUrl = "https://nominatim.openstreetmap.org/";
        MapPoint mapPoint = new MapPoint().buildMapPoint(lat, lon);
        Address address = NominatimAPI.with(endpointUrl).getAddressFromMapPoint(mapPoint);
        if(address != null)
            return address.getDisplayName();
        return "";
    }
}
