<%@page import="com.seat"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Available Seats</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f7f7f7;
            margin: 0;
            padding: 20px;
        }

        h1 {
            text-align: center;
            color: #d25c98; /* Màu hồng chủ đạo */
            margin-bottom: 30px;
        }

        table {
            width: 100%;
            margin: 0 auto;
            border-collapse: collapse;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 10px 20px;
            text-align: center;
            border: 1px solid #ddd;
        }

        th {
            background-color: #d25c98; /* Màu hồng cho header */
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        tr:hover {
            background-color: #f5b6d5; /* Màu hồng nhạt khi hover */
        }

        form {
            display: inline;
        }

        input[type="text"] {
            padding: 5px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        input[type="submit"] {
            background-color: #d25c98; /* Màu hồng cho nút */
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            font-size: 16px;
            border-radius: 5px;
        }

        input[type="submit"]:hover {
            background-color: #d16e9c; /* Màu hồng đậm khi hover */
        }
    </style>
</head>
<body>
    <h1>Available Seats for Flight ID: <%= request.getParameter("flightId") %></h1>
   
    <table>
        <tr>
            <th>Seat ID</th>
            <th>Seat Number</th>
            <th>Price</th>
            <th>Customer ID</th>
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
                    
                    <input type="submit" value="Book Seat">
                </form>
            </td>
        </tr>
        <%
                }
            }
        %>
    </table>
</body>
</html>
