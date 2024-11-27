<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Airport Management</title>
    <style>
        /* Reset các thuộc tính mặc định */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* Cấu trúc chung của body */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            color: #333;
            padding: 20px;
        }

        /* Tiêu đề chính */
        h1 {
            color: #ff66b2; /* Màu hồng chủ đạo */
            text-align: center;
            margin-bottom: 30px;
        }

        /* Phần tiêu đề nhỏ */
        h3 {
            color: #ff66b2;
            margin-top: 20px;
        }

        /* Form và các input */
        form {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
        }

        input[type="text"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
            font-size: 16px;
        }

        input[type="submit"] {
            background-color: #ff66b2;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }

        input[type="submit"]:hover {
            background-color: #ff3385;
        }

        /* Bảng danh sách sân bay */
        table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        table th, table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        table th {
            background-color: #ff66b2;
            color: white;
        }

        table td a {
            color: #ff66b2;
            text-decoration: none;
        }

        table td a:hover {
            color: #ff3385;
        }

        /* Button Update và Delete */
        .action-buttons input {
            background-color: #ff66b2;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            margin-right: 10px;
        }

        .action-buttons input:hover {
            background-color: #ff3385;
        }

        .action-buttons a {
            background-color: #ff66b2;
            color: white;
            padding: 8px 16px;
            border-radius: 5px;
            text-decoration: none;
            font-size: 14px;
        }

        .action-buttons a:hover {
            background-color: #ff3385;
        }
    </style>
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
                <td class="action-buttons">
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
