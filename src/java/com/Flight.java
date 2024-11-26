package com;

import java.util.Date;

/**
 * Class Flight để đại diện cho thông tin chuyến bay.
 */
public class Flight {
    private int flightID;
    private int airlineID;
    private int fromAirportID;
    private int toAirportID;
    private Date departureTime;
    private Date arrivalTime;
    private String gate;
    private String airlineName;  // Tên của hãng hàng không
    private String fromAirportName; // Tên của sân bay đi
    private String toAirportName; // Tên của sân bay đến

    // Getter và Setter
    public int getFlightID() { return flightID; }
    public void setFlightID(int flightID) { this.flightID = flightID; }
    public int getAirlineID() { return airlineID; }
    public void setAirlineID(int airlineID) { this.airlineID = airlineID; }
    public int getFromAirportID() { return fromAirportID; }
    public void setFromAirportID(int fromAirportID) { this.fromAirportID = fromAirportID; }
    public int getToAirportID() { return toAirportID; }
    public void setToAirportID(int toAirportID) { this.toAirportID = toAirportID; }
    public Date getDepartureTime() { return departureTime; }
    public void setDepartureTime(Date departureTime) { this.departureTime = departureTime; }
    public Date getArrivalTime() { return arrivalTime; }
    public void setArrivalTime(Date arrivalTime) { this.arrivalTime = arrivalTime; }
    public String getGate() { return gate; }
    public void setGate(String gate) { this.gate = gate; }

    public String getAirlineName() {
        return airlineName;
    }

    public void setAirlineName(String airlineName) {
        this.airlineName = airlineName;
    }

    public String getFromAirportName() {
        return fromAirportName;
    }

    public void setFromAirportName(String fromAirportName) {
        this.fromAirportName = fromAirportName;
    }

    public String getToAirportName() {
        return toAirportName;
    }

    public void setToAirportName(String toAirportName) {
        this.toAirportName = toAirportName;
    }
}
