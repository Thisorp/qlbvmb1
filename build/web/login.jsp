<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
            color: white;
            background-image: url('image/background.jpg'); /* Sử dụng background.jpg làm hình nền */
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-position: center;
        }
        .login-container {
            background-color: rgba(0, 0, 0, 0.6);
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            text-align: center;
            width: 300px;
        }
        h2 {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 10px;
        }
        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: none;
            border-radius: 4px;
            box-sizing: border-box;
        }
        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            width: 100%;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
        p {
            font-size: 14px;
            color: #ff4d4d;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <!-- Nội dung trang login -->
    <div class="login-container">
        <h2>Login</h2>
        <form action="LoginServlet" method="POST">
            <label for="username">Email:</label>
            <input type="text" id="username" name="username" required><br>

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required><br>

            <input type="submit" value="Login">
        </form>

        <!-- Hiển thị lỗi đăng nhập nếu có -->
        <p><%= request.getParameter("error") != null ? request.getParameter("error") : "" %></p>
    </div>
</body>
</html>
