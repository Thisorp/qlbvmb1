<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Kiểm tra cơ sở dữ liệu</title>
</head>
<body>
    <h1>Kiểm tra cơ sở dữ liệu - Dữ liệu từ bảng flight</h1>
    <%
        // Thông tin kết nối cơ sở dữ liệu
        String dbUrl = "jdbc:mysql://localhost:3306/abc"; // Thay 'abc' bằng tên database của bạn
        String dbUser = "root"; // Thay 'root' bằng username của bạn
        String dbPassword = ""; // Thay '' bằng mật khẩu của bạn
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        String message = "";

        try {
            // Kết nối cơ sở dữ liệu
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

            // Thực hiện câu lệnh SELECT
            String query = "SELECT * FROM flight";
            stmt = conn.createStatement();
            rs = stmt.executeQuery(query);

            message = "Kết nối và thực thi câu lệnh thành công!";
        } catch (Exception e) {
            message = "Lỗi: " + e.getMessage();
        }
    %>

    <!-- Hiển thị trạng thái kết nối -->
    <p><strong>Trạng thái:</strong> <%= message %></p>

    <!-- Hiển thị dữ liệu nếu có -->
    <table border="1" cellpadding="5" cellspacing="0">
        <thead>
            <tr>
                <th>FlightID</th>
                <th>AirlineID</th>
                <th>FromAirportID</th>
                <th>ToAirportID</th>
                <th>DepartureTime</th>
                <th>ArrivalTime</th>
                <th>Gate</th>
            </tr>
        </thead>
        <tbody>
            <%
                if (rs != null) {
                    while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getInt("FlightID") %></td>
                <td><%= rs.getInt("AirlineID") %></td>
                <td><%= rs.getInt("FromAirportID") %></td>
                <td><%= rs.getInt("ToAirportID") %></td>
                <td><%= rs.getString("DepartureTime") %></td>
                <td><%= rs.getString("ArrivalTime") %></td>
                <td><%= rs.getString("Gate") %></td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
                <td colspan="7">Không có dữ liệu</td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>

    <%
        // Đóng kết nối
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    %>
</body>
</html>
