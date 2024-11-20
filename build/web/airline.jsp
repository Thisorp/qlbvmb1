<%@ page import="java.sql.*, com.Database" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Airline Management</title>
</head>
<body>
    <h1>Airline Management</h1>

    <!-- Form Thêm Hãng Hàng Không -->
    <h3>Add New Airline</h3>
    <form action="AirlineServlet" method="POST">
        <input type="hidden" name="action" value="add">
        Airline Name: <input type="text" name="name" required><br>
        Contact Info: <input type="text" name="contactInfo" required><br>
        <input type="submit" value="Add Airline">
    </form>

    <!-- Form Tìm Kiếm -->
    <h3>Search Airline</h3>
    <form action="airline.jsp" method="GET">
        Airline Name: <input type="text" name="search" placeholder="Search by name" value="<%= request.getParameter("search") %>"><br>
        <input type="submit" value="Search">
    </form>

    <!-- Hiển Thị Danh Sách Các Hãng Hàng Không -->
    <h3>All Airlines</h3>
    <table border="1">
        <tr>
            <th>Airline ID</th>
            <th>Name</th>
            <th>Contact Info</th>
            <th>Actions</th>
        </tr>
        <%
            String search = request.getParameter("search");
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            try {
                // Kết nối đến cơ sở dữ liệu thông qua lớp Database
                con = Database.getConnection(); // Đảm bảo bạn đã đưa lớp Database vào package đúng

                String query = "SELECT * FROM airline";
                if (search != null && !search.isEmpty()) {
                    query += " WHERE Name LIKE ?";
                }

                ps = con.prepareStatement(query);
                if (search != null && !search.isEmpty()) {
                    ps.setString(1, "%" + search + "%");
                }

                rs = ps.executeQuery();

                while (rs.next()) {
        %>
                    <tr>
                        <td><%= rs.getInt("AirlineID") %></td>
                        <td><%= rs.getString("Name") %></td>
                        <td><%= rs.getString("ContactInfo") %></td>
                        <td>
                            <!-- Các hành động Sửa và Xoá -->
                            <a href="AirlineServlet?action=edit&id=<%= rs.getInt("AirlineID") %>">Edit</a> | 
                            <a href="AirlineServlet?action=delete&id=<%= rs.getInt("AirlineID") %>">Delete</a>
                        </td>
                    </tr>
        <% 
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (ps != null) ps.close();
                    if (con != null) con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>
    </table>
</body>
</html>
