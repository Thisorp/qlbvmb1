<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Customer Information</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <!-- Header -->
    <jsp:include page="header.jsp" />

    <!-- Form chỉnh sửa -->
    <h1>Edit Your Information</h1>
    <form action="CustomerServlet" method="POST">
        <label for="name">Name:</label><br>
        <input type="text" id="name" name="name" value="${customer.name}" required><br><br>

        <label for="email">Email:</label><br>
        <input type="email" id="email" name="email" value="${customer.email}" required><br><br>

        <label for="phone">Phone:</label><br>
        <input type="text" id="phone" name="phone" value="${customer.phone}" required><br><br>

        <label for="password">Password:</label><br>
        <input type="password" id="password" name="password" value="${customer.password}" required><br><br>

        <button type="submit">Update</button>
    </form>
    <a href="profile.jsp">Cancel</a>
</body>
</html>
