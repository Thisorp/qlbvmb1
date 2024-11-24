/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com;

import java.math.BigDecimal;

/**
 *
 * @author Huy pc
 */
public class seat {
    private int seatID;
    private String seatNumber;
    private boolean isAvailable;
    private BigDecimal price;

    // Constructor
    public seat(int seatID, String seatNumber, boolean isAvailable, BigDecimal price) {
        this.seatID = seatID;
        this.seatNumber = seatNumber;
        this.isAvailable = isAvailable;
        this.price = price;
    }

    // Getters and Setters
    public int getSeatID() {
        return seatID;
    }

    public void setSeatID(int seatID) {
        this.seatID = seatID;
    }

    public String getSeatNumber() {
        return seatNumber;
    }

    public void setSeatNumber(String seatNumber) {
        this.seatNumber = seatNumber;
    }

    public boolean isAvailable() {
        return isAvailable;
    }

    public void setAvailable(boolean available) {
        isAvailable = available;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    
}
