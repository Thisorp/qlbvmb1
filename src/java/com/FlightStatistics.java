package com;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author thy
 */
public class FlightStatistics {
    private int FlightID;
    private int AirlineID;
    private int TotalSeatsBooked;
    private int AvailableSeats;

    // Constructor
    public FlightStatistics(int FlightID, int AirlineID, int TotalSeatsBooked, int AvailableSeats) {
        this.FlightID = FlightID;
        this.AirlineID = AirlineID;
        this.TotalSeatsBooked = TotalSeatsBooked;
        this.AvailableSeats = AvailableSeats;
    }

    // Getters and setters
    public int getFlightID() {
        return FlightID;
    }

    public void setFlightID(int flightID) {
        FlightID = flightID;
    }

    public int getAirlineID() {
        return AirlineID;
    }

    public void setAirlineID(int airlineID) {
        AirlineID = airlineID;
    }

    public int getTotalSeatsBooked() {
        return TotalSeatsBooked;
    }

    public void setTotalSeatsBooked(int totalSeatsBooked) {
        TotalSeatsBooked = totalSeatsBooked;
    }

    public int getAvailableSeats() {
        return AvailableSeats;
    }

    public void setAvailableSeats(int availableSeats) {
        AvailableSeats = availableSeats;
    }
}
