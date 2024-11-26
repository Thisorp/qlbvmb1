<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Airport Management</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    
    <h1>Airport Management</h1>

    <!-- Thêm Sân Bay -->
    <h3>Add New Airport</h3>
    <form action="AirportServlet" method="POST">
        <input type="hidden" name="action" value="add">
        Name: <input type="text" name="name" required><br>
        Location: <input type="text" name="location" required><br>
        Contact Info: <input type="text" name="contactInfo" required><br>
        <input type="submit" value="Add Airport">
    </form>

    <!-- Tìm kiếm -->
    <h3>Search Airport</h3>
    <form action="AirportServlet" method="GET">
        Name: <input type="text" name="search" value="${param.search}"><br>
        <input type="submit" value="Search">
    </form>

    <!-- Danh sách sân bay -->
    <h3>Airport List</h3>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Location</th>
            <th>Contact Info</th>
            <th>Actions</th>
        </tr>
        <c:forEach var="airport" items="${airports}">
            <tr>
                 <td>${airport.id}</td>
                 <td>${airport.name}</td>
                 <td>${airport.location}</td>
                 <td>${airport.contactInfo}</td>
                <td>
                    <!-- Sửa -->
                    <form action="AirportServlet" method="POST" style="display:inline;">
                        <input type="hidden" name="action" value="edit">
                        <input type="hidden" name="id" value="${airport.id}">
                        Name: <input type="text" name="name" value="${airport.name}">
                        Location: <input type="text" name="location" value="${airport.location}">
                        Contact Info: <input type="text" name="contactInfo" value="${airport.contactInfo}">
                        <input type="submit" value="Update">
                    </form>
                    <!-- Xóa -->
                    <a href="AirportServlet?action=delete&id=${airport.id}">Delete</a>
                </td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
