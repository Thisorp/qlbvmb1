<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Flights</title>
</head>
<body>
    <h1>Manage Flights</h1>

    <!-- Hiển thị danh sách chuyến bay -->
    <table border="1">
        <thead>
            <tr>
                <th>Flight ID</th>
                <th>Airline Name</th>
                <th>From Airport</th>
                <th>To Airport</th>
                <th>Departure Time</th>
                <th>Arrival Time</th>
                <th>Gate</th>
            </tr>
        </thead>
        <tbody>
            <!-- Duyệt qua danh sách chuyến bay và hiển thị -->
            <c:forEach var="flight" items="${flights}">
                <tr>
                    <td>${flight.flightID}</td>
                    <td>${flight.airlineName}</td>
                    <td>${flight.fromAirportName}</td>
                    <td>${flight.toAirportName}</td>
                    <td>${flight.departureTime}</td>
                    <td>${flight.arrivalTime}</td>
                    <td>${flight.gate}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>
