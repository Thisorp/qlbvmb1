<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
</head>
<body>
    <h2>Login</h2>
    <form action="LoginServlet" method="POST">
        <label for="username">Email:</label>
        <input type="text" id="username" name="username" required><br><br>

        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required><br><br>

        <input type="submit" value="Login">
    </form>

    <c:if test="${param.error != null}">
        <p style="color:red;">${param.error}</p>
    </c:if>
</body>
</html>
