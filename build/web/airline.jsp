<%@ page import="java.sql.*, com.Database" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Airline Management</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        /* Reset default margin and padding */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f7f6;
            padding: 40px;
            color: #333;
        }

        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
            font-size: 2em;
        }

        h3 {
            color: #555;
            margin-bottom: 15px;
            font-size: 1.5em;
        }

        form {
            margin-bottom: 40px;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
        }

        form input[type="text"] {
            width: 100%;
            padding: 12px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }

        form input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 12px 20px;
            font-size: 16px;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        form input[type="submit"]:hover {
            background-color: #45a049;
        }

        table {
            width: 100%;
            margin-top: 30px;
            border-collapse: collapse;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 15px;
            text-align: center;
            border: 1px solid #ddd;
        }

        th {
            background-color: #ec407a;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #fce4ec;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        .actions a {
            text-decoration: none;
            color: #ec407a;
            margin: 0 10px;
        }

        .actions a:hover {
            color: #c2185b;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            background-color: #fff;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 10px 15px rgba(0, 0, 0, 0.1);
        }

        .form-container {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }
    </style>
</head>
<body>

    <div class="container">
        <h1>Airline Management</h1>

        <!-- Form Add Airline -->
        <div class="form-container">
            <h3>Add New Airline</h3>
            <form action="AirlineServlet" method="POST">
                <input type="hidden" name="action" value="add">
                Airline Name: <input type="text" name="name" required><br>
                Contact Info: <input type="text" name="contactInfo" required><br>
                <input type="submit" value="Add Airline">
            </form>
        </div>

        <!-- Search Form -->
        <div class="form-container">
            <h3>Search Airline</h3>
            <form action="airline.jsp" method="GET">
                Airline Name: <input type="text" name="search" placeholder="Search by name" value="<%= request.getParameter("search") %>"><br>
                <input type="submit" value="Search">
            </form>
        </div>

        <!-- Display Airlines -->
        <h3>All Airlines</h3>
<table>
    <thead>
        <tr>
            <th>Airline ID</th>
            <th>Name</th>
            <th>Contact Info</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        <%
            String search = request.getParameter("search");
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            try {
                con = Database.getConnection();
                String query = "SELECT * FROM airline";
                if (search != null && !search.isEmpty()) {
                    query += " WHERE Name LIKE ?";
                }

                ps = con.prepareStatement(query);
                if (search != null && !search.isEmpty()) {
                    ps.setString(1, "%" + search + "%");
                }

                rs = ps.executeQuery();

                while (rs.next()) {
        %>
            <tr>
                <td><%= rs.getInt("AirlineID") %></td>
                <td>
                    <form action="AirlineServlet" method="POST" style="display:inline;">
                        <input type="hidden" name="action" value="text">
                        <input type="hidden" name="id" value="<%= rs.getInt("AirlineID") %>">
                        <input type="text" name="name" value="<%= rs.getString("Name") %>" required>
                    </form>
                </td>
                <td>
                    <form action="AirlineServlet" method="POST" style="display:inline;">
                        <input type="hidden" name="action" value="text">
                        <input type="hidden" name="id" value="<%= rs.getInt("AirlineID") %>">
                        <input type="text" name="contactInfo" value="<%= rs.getString("ContactInfo") %>" required>
                    </form>
                </td>
                <td class="actions">
                    <form action="AirlineServlet" method="POST" style="display:inline;">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="id" value="<%= rs.getInt("AirlineID") %>">
                        <input type="text" name="name" value="<%= rs.getString("Name") %>" required>
                        <input type="text" name="contactInfo" value="<%= rs.getString("ContactInfo") %>" required>
                        <input type="submit" value="Update">
                    </form>
                    <a href="AirlineServlet?action=delete&id=<%= rs.getInt("AirlineID") %>" onclick="return confirm('Are you sure you want to delete this airline?');">Delete</a>
                </td>
            </tr>
        <%
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (ps != null) ps.close();
                    if (con != null) con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>
    </tbody>
</table>

    </div>

</body>
</html>
