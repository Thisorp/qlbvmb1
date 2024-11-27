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
        <title>Booking Information</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #fce4ec; /* Nền hồng nhạt */
                text-align: center;
                margin: 0;
                padding: 0;
            }

            h1 {
                color: #d81b60; /* Màu hồng đậm */
                font-size: 36px;
                margin-top: 50px;
            }

            table {
                width: 80%;
                margin: 30px auto;
                border-collapse: collapse;
                background-color: #ffffff;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                border-radius: 8px;
            }

            th, td {
                padding: 12px;
                text-align: center;
                border: 1px solid #ddd;
            }

            th {
                background-color: #f06292; /* Hồng đậm cho tiêu đề */
                color: white;
            }

            tr:nth-child(even) {
                background-color: #f8bbd0; /* Màu hồng nhạt cho các dòng chẵn */
            }

            tr:hover {
                background-color: #f48fb1; /* Màu hồng khi hover vào dòng */
            }

            a {
                color: #d81b60; /* Màu hồng đậm cho liên kết */
                text-decoration: none;
                margin-top: 20px;
                display: inline-block;
            }

            a:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
        <h1>Booking Information</h1>
        <table>
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
