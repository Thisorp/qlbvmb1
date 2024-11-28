<%@page import="java.util.ArrayList"%>
<%@ page import="com.seat" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.Database" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Seat Manager</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #fce4ec;
            text-align: center;
            margin: 0;
            padding: 0;
        }
        table {
            width: 80%;
            margin: 50px auto;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        th, td {
            padding: 10px;
            text-align: center;
            border: 1px solid #ddd;
        }
        th {
            background-color: #f06292;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f8bbd0;
        }
        tr:hover {
            background-color: #f48fb1;
        }
        a {
            color: #d81b60;
            text-decoration: none;
            margin: 0 10px;
        }
        a:hover {
            text-decoration: underline;
        }
        h1 {
            color: #d81b60;
            margin-top: 20px;
        }
        .form-container {
            margin: 30px auto;
            width: 50%;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>

<%
    String flightId = request.getParameter("flightId");
    List<seat> seats = new ArrayList<>();

    if (flightId != null) {
        // Get seats from the database for the given flightId
        try (Connection con = Database.getConnection()) {
            String sql = "SELECT * FROM seat WHERE FlightID = ?";
            PreparedStatement statement = con.prepareStatement(sql);
            statement.setInt(1, Integer.parseInt(flightId));
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                seat seat = new seat(
                    resultSet.getInt("SeatID"),
                    resultSet.getString("SeatNumber"),
                    resultSet.getBoolean("IsAvailable"),
                    resultSet.getBigDecimal("Price")
                );
                seats.add(seat);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    request.setAttribute("seats", seats);
%>

<h1>Seat Management for Flight ID: <%= flightId %></h1>

<!-- Displaying seats -->
<table>
    <tr>
       
        <th>Seat Number</th>
        <th>Availability</th>
        <th>Price</th>
        <th>Actions</th>
    </tr>
    <%
        for (seat seat : seats) {
    %>
    <tr>
       
        <td><%= seat.getSeatNumber() %></td>
        <td><%= seat.isAvailable() ? "Available" : "Not Available" %></td>
        <td><%= seat.getPrice() %></td>
        <td>
            <a href="SeatManagerServlet?flightId=<%= flightId %>&action=edit&seatId=<%= seat.getSeatID() %>">Edit</a>
            <a href="SeatManagerServlet?flightId=<%= flightId %>&action=delete&seatId=<%= seat.getSeatID() %>">Delete</a>
        </td>
    </tr>
    <%
        }
    %>
</table>

<!-- Add New Seat Form -->
<div class="form-container">
    <h2>Add New Seat</h2>
    <form action="SeatManagerServlet" method="post">
        <input type="hidden" name="action" value="add">
        <input type="hidden" name="flightId" value="<%= flightId %>">
        
        <label for="seatNumber">Seat Number:</label>
        <input type="text" name="seatNumber" required><br><br>

        <label for="isAvailable">Available:</label>
        <input type="checkbox" name="isAvailable"><br><br>

        <label for="price">Price:</label>
        <input type="number" name="price" step="0.01" required><br><br>

        <input type="submit" value="Add Seat">
    </form>
</div>

<% 
    // If editing, show the edit form
    String action = request.getParameter("action");
    if ("edit".equals(action)) {
        String seatId = request.getParameter("seatId");
        seat seatToEdit = null;

        if (seatId != null) {
            try (Connection con = Database.getConnection()) {
                String sql = "SELECT * FROM seat WHERE SeatID = ?";
                PreparedStatement statement = con.prepareStatement(sql);
                statement.setInt(1, Integer.parseInt(seatId));
                ResultSet resultSet = statement.executeQuery();

                if (resultSet.next()) {
                    seatToEdit = new seat(
                        resultSet.getInt("SeatID"),
                        resultSet.getString("SeatNumber"),
                        resultSet.getBoolean("IsAvailable"),
                        resultSet.getBigDecimal("Price")
                    );
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
%>

<div class="form-container">
    <h2>Edit Seat Details</h2>
<form action="SeatManagerServlet" method="post">
    <input type="hidden" name="action" value="update">
    <input type="hidden" name="seatId" value="<%= seatToEdit.getSeatID() %>">
    <input type="hidden" name="flightId" value="<%= flightId %>"> <!-- Corrected name for flightId -->
    
    <label for="seatNumber">Seat Number:</label>
    <input type="text" name="seatNumber" value="<%= seatToEdit.getSeatNumber() %>" required><br><br>

    <label for="isAvailable">Available:</label>
    <input type="checkbox" name="isAvailable" <%= seatToEdit.isAvailable() ? "checked" : "" %>><br><br>

    <label for="price">Price:</label>
    <input type="number" name="price" value="<%= seatToEdit.getPrice() %>" step="0.01" required><br><br>

    <input type="submit" value="Update Seat">
</form>
</div>

<%
    }
%>

</body>
</html>