<%-- 
    Document   : statistics
    Created on : Nov 28, 2024, 2:59:28 PM
    Author     : thy
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Flight Statistics</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            text-align: center;
            padding: 20px;
        }

        h1 {
            color: #333;
        }

        table {
            margin: 20px auto;
            width: 80%;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 12px;
            text-align: left;
        }

        th {
            background-color: #007BFF;
            color: white;
        }

        td {
            background-color: #f9f9f9;
        }

        tr:nth-child(even) td {
            background-color: #f1f1f1;
        }

        tr:hover td {
            background-color: #f2f2f2;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
        }
    </style>
</head>
<body>

    <div class="container">
        <h1>Flight Statistics</h1>

        <!-- Bảng thống kê chuyến bay -->
        <table>
            <thead>
                <tr>
                    <th>Flight ID</th>
                    <th>Airline ID</th>
                    <th>Total Seats Booked</th>
                    <th>Available Seats</th>
                </tr>
            </thead>
            <tbody>
                <!-- Lặp qua danh sách các chuyến bay từ cơ sở dữ liệu -->
                <c:forEach var="stat" items="${flightStatistics}">
                    <tr>
                        <td>${stat.FlightID}</td>
                        <td>${stat.AirlineID}</td>
                        <td>${stat.TotalSeatsBooked}</td>
                        <td>${stat.AvailableSeats}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

</body>
</html>
