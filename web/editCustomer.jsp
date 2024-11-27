<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Customer Information</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    

    <!-- Form chỉnh sửa -->
    <h1>Edit Your Information</h1>
 <form action="CustomerServlet" method="post">
        <label for="name">Name:</label>
        <input type="text" name="name" value="${customer.name}" /><br><br>

        <label for="email">Email:</label>
        <input type="text" name="email" value="${customer.email}" /><br><br>

        <label for="phone">Phone:</label>
        <input type="text" name="phone" value="${customer.phone}" /><br><br>

        <label for="password">Password:</label>
        <input type="password" name="password" value="${customer.password}" /><br><br>

        <input type="submit" value="Update" />
    </form>
    <a href="home.jsp">Cancel</a>
    <br>
    <p>Phone (from session): ${phone}</p>
</body>
</html>
