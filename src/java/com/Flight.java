package com;


import java.util.Date;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author Huy pc
 */
public class Flight {
    private int flightID;
    private int airlineID;
    private int fromAirportID;
    private int toAirportID;
    private Date departureTime;
    private Date arrivalTime;
    private String gate;
    private String AirlineName;
    private String FromAirportName;
    private String ToAirportName;

    public String getToAirportName() {
        return ToAirportName;
    }

    public void setToAirportName(String ToAirportName) {
        this.ToAirportName = ToAirportName;
    }

    public String getAirlineName() {
        return AirlineName;
    }

    public void setAirlineName(String AirlineName) {
        this.AirlineName = AirlineName;
    }

    public String getFromAirportName() {
        return FromAirportName;
    }

    public void setFromAirportName(String FromAirportName) {
        this.FromAirportName = FromAirportName;
    }

    // Getters and Setters
    public int getFlightID() { return flightID; }
    public void setFlightID(int flightID) { this.flightID = flightID; }
    public int getAirlineID() { return airlineID; }
    public void setAirlineID(int airlineID) { this.airlineID = airlineID; }
    public int getFromAirportID() { return fromAirportID; }
    public void setFromAirportID(int fromAirportID) { this.fromAirportID = fromAirportID; }
    public int getToAirportID() { return toAirportID; }
    public void setToAirportID(int toAirportID) { this.toAirportID = toAirportID; }
    public Date getDepartureTime() { return departureTime; }
    public void setDepartureTime(java.util.Date departureTime) { this.departureTime = departureTime; }
    public Date getArrivalTime() { return arrivalTime; }
    public void setArrivalTime(java.util.Date arrivalTime) { this.arrivalTime = arrivalTime; }
    public String getGate() { return gate; }
    public void setGate(String gate) { this.gate = gate; }
}
