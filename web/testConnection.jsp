<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="com.Database" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Kiểm tra kết nối cơ sở dữ liệu</title>
</head>
<body>
    <h1>Kiểm tra kết nối cơ sở dữ liệu</h1>
    <%
        // Kiểm tra kết nối bằng lớp Database
        boolean isConnected = false;
        String message = "";
        try {
            isConnected = Database.testConnection();
            if (isConnected) {
                message = "Kết nối thành công!";
            } else {
                message = "Kết nối thất bại!";
            }
        } catch (Exception e) {
            message = "Lỗi: " + e.getMessage();
        }
    %>
    <p><strong>Trạng thái:</strong> <%= message %></p>
</body>
</html>
