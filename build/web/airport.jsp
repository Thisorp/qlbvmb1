<%@page import="com.Database"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.*" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.Connection" %>
<%@page import="com.Flight" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Flights</title>
        <style>
            /* Thiết lập kiểu chữ và nền của body */
            body {
                font-family: Arial, sans-serif;
                background-color: #fce4ec; /* Màu nền hồng nhạt */
                text-align: center;
                margin: 0;
                padding: 0;
            }

            /* Tiêu đề chính */
            h1 {
                color: #d81b60;
                margin-top: 30px;
                font-size: 36px;
            }

            /* Bảng hiển thị chuyến bay */
            table {
                width: 80%;
                margin: 50px auto;
                border-collapse: collapse;
                background-color: #fff;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                border-radius: 8px;
                overflow: hidden;
            }

            /* Định dạng cột tiêu đề */
            th, td {
                padding: 12px;
                text-align: center;
                border: 1px solid #ddd;
                font-size: 16px;
            }

            th {
                background-color: #f06292; /* Màu hồng đậm cho tiêu đề */
                color: white;
                font-size: 18px;
            }

            /* Màu nền của các dòng chẵn */
            tr:nth-child(even) {
                background-color: #f8bbd0; /* Màu hồng nhạt cho các dòng chẵn */
            }

            /* Hiệu ứng hover khi di chuột qua dòng */
            tr:hover {
                background-color: #f48fb1; /* Màu hồng khi hover vào dòng */
            }

            /* Màu sắc cho các liên kết */
            a {
                color: #d81b60; /* Màu hồng đậm cho liên kết */
                text-decoration: none;
                margin: 0 10px;
                padding: 6px 12px;
                border-radius: 5px;
                border: 1px solid #d81b60;
            }

            a:hover {
                text-decoration: underline;
                background-color: #d81b60;
                color: white;
            }

            /* Nút Action (Chỉnh sửa, Xóa) */
            td a {
                display: inline-block;
                margin: 5px 10px;
                padding: 8px 16px;
                background-color: #ff66b2;
                color: white;
                border-radius: 5px;
                text-align: center;
            }

            td a:hover {
                background-color: #ff3385;
                color: white;
            }

            /* Định dạng cho các phần không có dữ liệu */
            .no-data {
                color: #888;
                font-size: 18px;
                padding: 20px;
                text-align: center;
            }
        </style>
    </head>
    <body>
        <h1>Flight Information</h1>

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

        <%-- Kiểm tra nếu có chuyến bay để hiển thị --%>
        <c:if test="${not empty flights}">
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
                    <td>
                        <a href="FlightServlet?action=edit&flightId=<%= flight.getFlightID() %>">Edit</a>
                        <a href="FlightServlet?action=delete&flightId=<%= flight.getFlightID() %>">Delete</a>
                    </td>
                </tr>
                <%
                    }
                %>
            </table>
        </c:if>
        
        <%-- Hiển thị thông báo nếu không có dữ liệu --%>
        <c:if test="${empty flights}">
            <div class="no-data">No flights available at the moment.</div>
        </c:if>

    </body>
</html>
