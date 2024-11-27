<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Management</title>
    <style>
        body {
            text-align: center;
            font-family: Arial, sans-serif;
        }

        table {
            margin: 0 auto;
            border-collapse: collapse;
            width: 80%;
        }

        table, th, td {
            border: 1px solid black;
        }

        th, td {
            padding: 10px;
            text-align: left;
        }

        form {
            margin-bottom: 20px;
        }

        input[type="submit"], input[type="button"] {
            padding: 10px 20px;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <h1>Admin Management</h1>

    <!-- Form Thêm Tài Khoản -->
    <h3>Add New Admin</h3>
    <form action="AdminServlet" method="POST">
        <input type="hidden" name="action" value="add">
        Username: <input type="text" name="username" required><br>
        Password: <input type="password" name="password" required><br>
        Email: <input type="email" name="email" required><br>
        Phone: <input type="text" name="phone" required><br>
        Role:
        <select name="role" required>
            <option value="admin">admin</option>
            <option value="airline">airline</option>
            <option value="airport">airport</option>
        </select><br>
        <input type="submit" value="Add Admin">
    </form>

    <!-- Form Tìm Kiếm -->
    <h3>Search Admin</h3>
    <form action="AdminServlet" method="GET">
        Username: <input type="text" name="search" placeholder="Search by username" value="${param.search}"><br>
        <input type="submit" value="Search">
    </form>

    <!-- Hiển Thị Danh Sách Admin -->
    <h3>Admin Accounts</h3>
    <table>
        <tr>
            <th>ID</th>
            <th>Username</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Role</th>
            <th>Actions</th>
        </tr>
        <c:forEach var="admin" items="${admins}">
            <tr>
                <td>${admin.id}</td>
                <td>${admin.username}</td>
                <td>${admin.email}</td>
                <td>${admin.phone}</td>
                <td>${admin.role}</td>
                <td>
                    <!-- Sửa -->
                    <form action="AdminServlet" method="POST" style="display:inline;">
                        <input type="hidden" name="action" value="edit">
                        <input type="hidden" name="id" value="${admin.id}">
                        Username: <input type="text" name="username" value="${admin.username}" required>
                        Password: <input type="password" name="password" value="${admin.password}" required>
                        Email: <input type="email" name="email" value="${admin.email}" required>
                        Phone: <input type="text" name="phone" value="${admin.phone}" required>
                        Role:
                        <select name="role" required>
                            <option value="admin" ${admin.role == 'admin' ? 'selected' : ''}>admin</option>
                            <option value="airline" ${admin.role == 'airline' ? 'selected' : ''}>airline</option>
                            <option value="airport" ${admin.role == 'airport' ? 'selected' : ''}>airport</option>
                        </select>
                        <input type="submit" value="Update">
                    </form>
                    <!-- Xóa -->
                    <a href="AdminServlet?action=delete&id=${admin.id}">Delete</a>
                </td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
