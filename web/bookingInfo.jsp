<%-- 
    Document   : bookingInfo
    Created on : Nov 25, 2024, 10:19:59 PM
    Author     : Huy pc
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="com.booking"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Booking Information</h1>
    <table border="1">
        <tr>
            <th>Customer Name</th>
            <th>Airline Name</th>
            <th>From Airport</th>
            <th>To Airport</th>
            <th>Departure Time</th>
            <th>Arrival Time</th>
            <th>Gate</th>
            <th>Seat Number</th>
            <th>Booking Date</th>
        </tr>
        <%
            ArrayList<booking> bookingList = (ArrayList<booking>) request.getAttribute("bookingList");

            for (booking booking : bookingList) {
        %>
        <tr>
            <td><%= booking.getCustomerName() %></td>
            <td><%= booking.getAirlineName() %></td>
            <td><%= booking.getFromAirportName() %></td>
            <td><%= booking.getToAirportName() %></td>
            <td><%= booking.getDepartureTime() %></td>
            <td><%= booking.getArrivalTime() %></td>
            <td><%= booking.getGate() %></td>
            <td><%= booking.getSeatNumber() %></td>
            <td><%= booking.getBookingDate() %></td>
        </tr>
        <%
            }
        %>
    </table>
</body>
</html>
