<%-- 
    Document   : displayFlight
    Created on : Nov 22, 2024, 8:30:00 PM
    Author     : Huy pc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
    </head>
    <body>
       <form action="FlightServlet" method="post">
            <input type="hidden" name="action" value="create">
            <label for="FlightId">Flight ID:</label>
            <input type="text" id="flightid" name="flightid" required>
            
            <label for="airlineId">Airline ID:</label>
            <input type="text" id="airlineId" name="airlineId" required>

            <label for="fromAirportId">From Airport ID:</label>
            <input type="text" id="fromAirportId" name="fromAirportId" required>

            <label for="toAirportId">To Airport ID:</label>
            <input type="text" id="toAirportId" name="toAirportId" required>

            <label for="departureTime">Departure Time:</label>
            <input type="datetime-local" id="departureTime" name="departureTime" required>

            <label for="arrivalTime">Arrival Time:</label>
            <input type="datetime-local" id="arrivalTime" name="arrivalTime" required>

            <label for="gate">Gate:</label>
            <input type="text" id="gate" name="gate" required>

            <button type="submit">Add Flight</button>
        </form>
        
        
        <jsp:include page="flights.jsp"></jsp:include>
        
        <jsp:include page="airline.jsp"></jsp:include>
    </body>
</html>
