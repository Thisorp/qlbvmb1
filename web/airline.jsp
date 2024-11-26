<%@ page import="java.sql.*, com.Database" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
<head>
    <title>Airline Management</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <%@ include file="header.jsp" %>
    <h1>Airline Management</h1>

    <!-- Form to Add or Edit Airline -->
    <h3>Add / Edit Airline</h3>
    <form action="AirlineServlet" method="POST">
        <input type="hidden" name="action" value="<%= request.getParameter("edit") != null ? "update" : "add" %>">
        <input type="hidden" name="id" value="<%= request.getParameter("id") != null ? request.getParameter("id") : "" %>">
        Airline Name: <input type="text" name="name" required 
            value="<%= request.getParameter("name") != null ? request.getParameter("name") : "" %>"><br>
        Contact Info: <input type="text" name="contactInfo" required 
            value="<%= request.getParameter("contactInfo") != null ? request.getParameter("contactInfo") : "" %>"><br>
        <input type="submit" value="<%= request.getParameter("edit") != null ? "Update Airline" : "Add Airline" %>">
    </form>

    <!-- Airline List Table -->
    <h3>All Airlines</h3>
    <table border="1">
        <tr>
            <th>Airline ID</th>
            <th>Name</th>
            <th>Contact Info</th>
            <th>Actions</th>
        </tr>
        <%
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            try {
                con = Database.getConnection();
                ps = con.prepareStatement("SELECT * FROM airline");
                rs = ps.executeQuery();

                while (rs.next()) {
        %>
                    <tr>
                        <td><%= rs.getInt("AirlineID") %></td>
                        <td><%= rs.getString("Name") %></td>
                        <td><%= rs.getString("ContactInfo") %></td>
                        <td>
                            <!-- Actions: Edit, Delete -->
                            <a href="airline.jsp?edit=true&id=<%= rs.getInt("AirlineID") %>&name=<%= rs.getString("Name") %>&contactInfo=<%= rs.getString("ContactInfo") %>">Edit</a> | 
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
