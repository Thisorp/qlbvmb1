<%-- 
    Document   : viewSeats
    Created on : Nov 22, 2024, 6:38:09 PM
    Author     : Huy pc
--%>

<%@page import="com.seat"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Available Seats</title>
</head>
<body>
    <h1>Available Seats for Flight ID: <%= request.getParameter("flightId") %></h1>
   
    <table border="1">
        <tr>
            <th>Seat ID</th>
            <th>Seat Number</th>
            <th>Price</th>
            <th>Customerid</th>
        </tr>
        <%
            
            int flightId = Integer.parseInt(request.getParameter("flightId"));
            List<seat> seats = (List<seat>) request.getAttribute("seats");
            for (seat seat : seats) {
                if (seat.isAvailable()) {
        %>
        <tr>
            <td><%= seat.getSeatID() %></td>
            <td><%= seat.getSeatNumber() %></td>
            <td><%= seat.getPrice() %></td>
            <td>
                <form action="bookSeat" method="post">
                    <input type="hidden" name="flightId" value="<%= flightId %>">
                    <input type="hidden" name="seatId" value="<%= seat.getSeatID() %>">
                    <input type="text" id="customerId" name="customerId" required>
                    <input type="submit" value="Book Seat">
                </form>
            </td>
        </tr>
        <%
                }
            }
        %>
    </table>
</html>
