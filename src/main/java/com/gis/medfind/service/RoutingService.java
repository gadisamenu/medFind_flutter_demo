package com.gis.medfind.service;

import org.locationtech.jts.geom.Coordinate;


public interface RoutingService{
    public String findRoute(Coordinate source, Coordinate target);
    public double shortestPathDistance(Coordinate source, Coordinate target);
}
