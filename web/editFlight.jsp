<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Flight</title>
</head>
<body>
    <%@ include file="header.jsp" %>
    <h1>Edit Flight</h1>
    <form action="FlightServlet" method="POST">
        <input type="hidden" name="flightid" value="${flight.FlightID}"/>
        <input type="hidden" name="action" value="edit"/>
        
        <label for="airlineId">Airline ID:</label>
        <input type="text" name="airlineId" value="${flight.AirlineID}"/><br>

        <label for="fromAirportId">From Airport ID:</label>
        <input type="text" name="fromAirportId" value="${flight.FromAirportID}"/><br>

        <label for="toAirportId">To Airport ID:</label>
        <input type="text" name="toAirportId" value="${flight.ToAirportID}"/><br>

        <label for="departureTime">Departure Time:</label>
        <input type="text" name="departureTime" value="${flight.DepartureTime}"/><br>

        <label for="arrivalTime">Arrival Time:</label>
        <input type="text" name="arrivalTime" value="${flight.ArrivalTime}"/><br>

        <label for="gate">Gate:</label>
        <input type="text" name="gate" value="${flight.Gate}"/><br>

        <input type="submit" value="Update Flight"/>
    </form>
</body>
</html>
