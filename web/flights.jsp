<%-- 
    Document   : flights
    Created on : Nov 21, 2024, 7:49:07 PM
    Author     : Huy pc
--%>

<%@page import="com.Database"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.*" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.Connection" %>
<%@page import="com.Flight" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>flights</title>
    </head>
    <body>
        <form action="FlightServlet" method="post">
            <input type="hidden" name="action" value="create">
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
        <%
            List<Flight> flights = new ArrayList<>();
            try (Connection con = Database.getConnection()) {
                String sql = "SELECT f.FlightID, a.Name AS AirlineName, ap_from.Name AS FromAirportName, ap_to.Name AS ToAirportName, " +
                     "f.DepartureTime, f.ArrivalTime, f.Gate " +
                     "FROM flight f " +
                     "JOIN airline a ON f.AirlineID = a.AirlineID " +
                     "JOIN airport ap_from ON f.FromAirportID = ap_from.AirportID " +
                     "JOIN airport ap_to ON f.ToAirportID = ap_to.AirportID";
        PreparedStatement statement = con.prepareStatement(sql);
        ResultSet resultSet = statement.executeQuery();
        
        while (resultSet.next()) {
            Flight flight = new Flight();
            flight.setFlightID(resultSet.getInt("FlightID"));
            flight.setAirlineName(resultSet.getString("AirlineName")); // Cần cập nhật Flight class để có thuộc tính này
            flight.setFromAirportName(resultSet.getString("FromAirportName")); // Cần cập nhật Flight class để có thuộc tính này
            flight.setToAirportName(resultSet.getString("ToAirportName")); // Cần cập nhật Flight class để có thuộc tính này
            flight.setDepartureTime(resultSet.getTimestamp("DepartureTime"));
            flight.setArrivalTime(resultSet.getTimestamp("ArrivalTime"));
            flight.setGate(resultSet.getString("Gate"));
            flights.add(flight);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>

<table>
    <tr>
        <th>Flight ID</th>
        <th>Airline Name</th>
        <th>From Airport Name</th>
        <th>To Airport Name</th>
        <th>Departure Time</th>
        <th>Arrival Time</th>
        <th>Gate</th>
        <th>Actions</th>
    </tr>
    <%
        for (Flight flight : flights) {
    %>
    <tr>
        <td><%= flight.getFlightID() %></td>
        <td><%= flight.getAirlineName() %></td> <!-- Hiển thị tên hãng hàng không -->
        <td><%= flight.getFromAirportName() %></td> <!-- Hiển thị tên sân bay đi -->
        <td><%= flight.getToAirportName() %></td> <!-- Hiển thị tên sân bay đến -->
        <td><%= flight.getDepartureTime() %></td>
        <td><%= flight.getArrivalTime() %></td>
        <td><%= flight.getGate() %></td>
        <td>
            <a href="flights?action=edit&flightId=<%= flight.getFlightID() %>">Edit</a>
            <a href="flights?action=delete&flightId=<%= flight.getFlightID() %>">Delete</a>
        </td>
    </tr>
            <%
                }
            %>
        </table>
            <jsp:include page="airline.jsp"></jsp:include>
    </body>
</html>
