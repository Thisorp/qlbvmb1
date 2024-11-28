<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Airport Management</title>
    <style>
        /* Toàn bộ trang */
        body {
            font-family: Arial, sans-serif;
            background-color: #f7f7f7;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            height: 100vh;
            color: #333;
        }

        /* Nội dung chính */
        .container {
            background-color: #fff;
            border-radius: 8px;
            padding: 30px;
            width: 80%;
            max-width: 1000px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-top: 30px; /* Giúp không bị dính lên đầu màn hình */
        }

        h1 {
            color: #d32f2f; /* Màu hồng đỏ */
            text-align: center;
            margin-bottom: 20px;
        }

        h3 {
            color: #d32f2f;
        }

        /* Bảng danh sách sân bay */
        table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 12px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        /* Form */
        form input[type="text"], form input[type="email"], form input[type="password"] {
            padding: 8px;
            margin: 10px 0;
            width: 100%;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        form select {
            padding: 8px;
            margin: 10px 0;
            width: 100%;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        form input[type="submit"] {
            background-color: #d32f2f;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        form input[type="submit"]:hover {
            background-color: #c62828;
        }

        /* Định dạng các hành động sửa và xóa */
        a {
            color: #d32f2f;
            text-decoration: none;
            padding-left: 10px;
        }

        a:hover {
            text-decoration: underline;
        }

        .actions {
            display: flex;
            gap: 10px;
        }

        .actions form {
            display: inline;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            margin-bottom: 10px;
        }

        .form-group label {
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Airport Management</h1>

        <!-- Thêm Sân Bay -->
        <h3>Add New Airport</h3>
        <form action="AirportServlet" method="POST">
            <input type="hidden" name="action" value="add">
            <div class="form-group">
                <label for="name">Name</label>
                <input type="text" name="name" id="name" required>
            </div>
            <div class="form-group">
                <label for="location">Location</label>
                <input type="text" name="location" id="location" required>
            </div>
            <div class="form-group">
                <label for="contactInfo">Contact Info</label>
                <input type="text" name="contactInfo" id="contactInfo" required>
            </div>
            <input type="submit" value="Add Airport">
        </form>

        <!-- Tìm kiếm -->
        <h3>Search Airport</h3>
        <form action="AirportServlet" method="GET">
            <div class="form-group">
                <label for="search">Name</label>
                <input type="text" name="search" id="search" value="${param.search}">
            </div>
            <input type="submit" value="Search">
        </form>

        <!-- Danh sách sân bay -->
        <h3>Airport List</h3>
        <table>
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
                    <td class="actions">
                        <!-- Sửa -->
                        <form action="AirportServlet" method="POST" style="display:inline;">
                            <input type="hidden" name="action" value="edit">
                            <input type="hidden" name="id" value="${airport.id}">
                            <div class="form-group">
                                <label for="nameEdit-${airport.id}">Name</label>
                                <input type="text" name="name" id="nameEdit-${airport.id}" value="${airport.name}">
                            </div>
                            <div class="form-group">
                                <label for="locationEdit-${airport.id}">Location</label>
                                <input type="text" name="location" id="locationEdit-${airport.id}" value="${airport.location}">
                            </div>
                            <div class="form-group">
                                <label for="contactInfoEdit-${airport.id}">Contact Info</label>
                                <input type="text" name="contactInfo" id="contactInfoEdit-${airport.id}" value="${airport.contactInfo}">
                            </div>
                            <input type="submit" value="Update">
                        </form>
                        <!-- Xóa -->
                        <a href="AirportServlet?action=delete&id=${airport.id}">Delete</a>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
</body>
</html>
