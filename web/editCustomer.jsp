<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Customer Information</title>
    <style>
        /* Thiết lập kiểu chữ và màu nền cho trang */
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
            text-align: center;
        }

        /* Định dạng cho tiêu đề chính */
        h1 {
            color: #2c3e50;
            margin-top: 50px;
            font-size: 30px;
            font-weight: bold;
        }

        /* Form chỉnh sửa */
        form {
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            max-width: 500px;
            margin: 30px auto;
            padding: 20px;
        }

        /* Định dạng cho nhãn và các ô nhập liệu */
        label {
            display: block;
            font-size: 16px;
            color: #333;
            margin: 10px 0 5px;
            text-align: left;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
            margin-bottom: 20px;
            box-sizing: border-box;
        }

        input[type="submit"] {
            background-color: #3498db;
            color: white;
            padding: 12px 20px;
            font-size: 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
        }

        input[type="submit"]:hover {
            background-color: #2980b9;
        }

        /* Định dạng cho liên kết Cancel */
        a {
            text-decoration: none;
            color: #e74c3c;
            font-size: 16px;
            margin-top: 20px;
            display: inline-block;
        }

        a:hover {
            text-decoration: underline;
        }

        /* Hiển thị thông tin từ session */
        p {
            font-size: 16px;
            color: #333;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <!-- Form chỉnh sửa -->
    <br><!-- comment -->
    <h1>Edit Your Information</h1>
    <form action="CustomerServlet" method="post">
        <label for="name">Name:</label>
        <input type="text" name="name" value="${customer.name}" /><br>

        <label for="email">Email:</label>
        <input type="text" name="email" value="${customer.email}" /><br>

        <label for="phone">Phone:</label>
        <input type="text" name="phone" value="${customer.phone}" /><br>

        <label for="password">Password:</label>
        <input type="password" name="password" value="${customer.password}" /><br>

        <input type="submit" value="Update" />
    </form>
    
    <a href="home.jsp">Cancel</a>
    
    <p>Phone (from session): ${phone}</p>
</body>
</html>
