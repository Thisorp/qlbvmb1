package com;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Database {
    // Thông tin kết nối cơ sở dữ liệu
    private static final String DB_URL = "jdbc:mysql://localhost:3306/qlbvmb1"; // Thay "your_database_name" bằng tên cơ sở dữ liệu của bạn
    private static final String DB_USER = "root"; // Thay đổi thông tin tài khoản và mật khẩu nếu cần
    private static final String DB_PASSWORD = ""; // Thay đổi mật khẩu của bạn

    // Phương thức để kết nối với cơ sở dữ liệu
    public static Connection getConnection() throws SQLException {
        Connection conn = null;
        try {
            // Tải Driver MySQL
            Class.forName("com.mysql.jdbc.Driver");  // Lưu ý sử dụng driver mới (com.mysql.cj.jdbc.Driver)
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        } catch (ClassNotFoundException e) {
            // Nếu không tìm thấy driver MySQL
            throw new SQLException("MySQL Driver not found", e);
        }
        return conn;
    }

    // Phương thức để đóng kết nối
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Phương thức để kiểm tra kết nối cơ sở dữ liệu (optional)
    public static boolean testConnection() {
        try (Connection conn = getConnection()) {
            return conn != null && !conn.isClosed();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
