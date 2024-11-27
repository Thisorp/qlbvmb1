<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Flight Information</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f4f4f4;
            }

/*            nav {
                background-color: #333;
                overflow: hidden;
            }

            nav a {
                float: left;
                display: block;
                color: white;
                text-align: center;
                padding: 14px 20px;
                text-decoration: none;
            }

            nav a:hover {
                background-color: #ddd;
                color: black;
            }*/

            form {
                background-color: #fff;
                padding: 20px;
                margin: 20px;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                width: 400px;
                margin-left: auto;
                margin-right: auto;
            }

            label {
                display: block;
                margin-bottom: 10px;
                font-weight: bold;
            }

            input[type="text"], input[type="datetime-local"] {
                width: 100%;
                padding: 8px;
                margin-bottom: 20px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

            button {
                background-color: #4CAF50;
                color: white;
                border: none;
                padding: 10px 15px;
                border-radius: 4px;
                cursor: pointer;
            }

            button:hover {
                background-color: #45a049;
            }
        </style>
    </head>
    <body>
        <!-- Thanh điều hướng -->
        <nav>
            <br>
            <br>
            <a href="flights.jsp">Flights</a>
            <br>
            <a href="airline.jsp">Airlines</a>
        </nav>

        <!-- Form nhập thông tin chuyến bay -->
        <form action="FlightServlet" method="post">
            <input type="hidden" name="action" value="create">
            <label for="FlightId">Flight ID:</label>
            <input type="text" id="flightid" name="flightid" required>
            
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
        
        <!-- Các trang phụ -->
        <jsp:include page="flights.jsp"></jsp:include>
        <jsp:include page="airline.jsp"></jsp:include>
    </body>
</html>
