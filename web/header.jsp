<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Header</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
    <style>
        nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #333;
            padding: 10px 20px;
        }

        nav ul {
            list-style-type: none;
            display: flex;
            padding: 0;
        }

        nav ul li {
            margin: 0 15px;
        }

        nav ul li a {
            color: white;
            text-decoration: none;
        }

        .user {
            color: white;
        }

        .user a {
            color: #ffcc00;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <nav>
        <ul>
            <li><a href="index.jsp">Home</a></li>
            <li><a href="flights.jsp">Flight</a></li>
            <li><a href="viewSeats.jsp">Booking</a></li>
            <li><a href="editCustomer.jsp">User Management</a></li>
        </ul>
        <div class="user">
            <c:choose>
                <c:when test="${not empty sessionScope.username}">
                    Welcome, ${sessionScope.username} | 
                    <a href="editCustomer.jsp">Edit Profile</a> | 
                    <a href="HeaderServlet?action=logout">Logout</a>
                </c:when>
                <c:otherwise>
                    <a href="login.jsp">Login</a>
                </c:otherwise>
            </c:choose>
        </div>
    </nav>
</body>
</html>
