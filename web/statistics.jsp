<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
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
                <% 
                    // Kết nối cơ sở dữ liệu và truy vấn
                    Connection conn = null;
                    Statement stmt = null;
                    ResultSet rs = null;

                    String url = "jdbc:mysql://localhost:3306/abc"; // Đổi đường dẫn và tên cơ sở dữ liệu của bạn
                    String user = "root"; // Thay thế username của bạn
                    String password = ""; // Thay thế password của bạn

                    try {
                        // Kết nối đến cơ sở dữ liệu
                        Class.forName("com.mysql.jdbc.Driver");
                        conn = DriverManager.getConnection(url, user, password);
                        
                        // Câu lệnh SQL
                        String query = "SELECT * FROM flight_statistics";
                        stmt = conn.createStatement();
                        rs = stmt.executeQuery(query);

                        // Hiển thị kết quả
                        while (rs.next()) {
                %>
                    <tr>
                        <td><%= rs.getInt("FlightID") %></td>
                        <td><%= rs.getInt("AirlineID") %></td>
                        <td><%= rs.getInt("TotalSeatsBooked") %></td>
                        <td><%= rs.getInt("AvailableSeats") %></td>
                    </tr>
                <% 
                        }
                    } catch (SQLException | ClassNotFoundException e) {
                        e.printStackTrace();
                    } finally {
                        try {
                            if (rs != null) rs.close();
                            if (stmt != null) stmt.close();
                            if (conn != null) conn.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                %>
            </tbody>
        </table>
    </div>

</body>
</html>
