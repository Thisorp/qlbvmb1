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
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f5f5f5; /* Nền sáng nhẹ */
                color: #333; /* Màu chữ tối cho dễ đọc */
                margin: 0;
                padding: 0;
            }

            h1 {
                text-align: center;
                color: #FF69B4; /* Màu hồng chủ đạo */
                padding: 20px;
            }

            table {
                width: 80%;
                margin: 20px auto;
                border-collapse: collapse;
                background-color: #ffffff; /* Nền trắng cho bảng */
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            th, td {
                padding: 12px 15px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }

            th {
                background-color: #FF69B4; /* Màu hồng cho tiêu đề cột */
                color: white;
                font-weight: bold;
            }

            tr:hover {
                background-color: #f2f2f2; /* Màu nền khi hover */
            }

            a {
                text-decoration: none;
                color: #FF69B4; /* Màu hồng cho liên kết */
                font-weight: bold;
            }

            a:hover {
                color: #ff1493; /* Màu hồng đậm khi hover */
            }

            .actions {
                text-align: center;
            }
        </style>
    </head>
    <body>
        <h1>Flight List</h1>

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
                    flight.setAirlineName(resultSet.getString("AirlineName"));
                    flight.setFromAirportName(resultSet.getString("FromAirportName"));
                    flight.setToAirportName(resultSet.getString("ToAirportName"));
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
                <td><%= flight.getAirlineName() %></td>
                <td><%= flight.getFromAirportName() %></td>
                <td><%= flight.getToAirportName() %></td>
                <td><%= flight.getDepartureTime() %></td>
                <td><%= flight.getArrivalTime() %></td>
                <td><%= flight.getGate() %></td>
                <td class="actions">
                    <a href="SeatServlet?flightId=<%= flight.getFlightID() %>">Booking</a>
                </td>
            </tr>
            <%
                }
            %>
        </table>
    </body>
</html>
