import com.Database;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;

public class LoginServlet extends HttpServlet {
    // Đảm bảo bạn đã cấu hình file web.xml hoặc sử dụng annotations để khai báo servlet

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy thông tin đăng nhập từ form
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Biến lưu trữ role
        String role = null;

        try {
            // Kết nối với cơ sở dữ liệu
            Connection conn = Database.getConnection();
            String sql = "SELECT Role FROM admin WHERE Username = ? AND Password = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                role = rs.getString("Role"); // Lấy role từ cơ sở dữ liệu
            }

            // Kiểm tra role và điều hướng
            if (role != null) {
                if (role.equals("admin")) {
                    response.sendRedirect("admin.jsp");
                } else if (role.equals("airport")) {
                    response.sendRedirect("airport.jsp");
                } else if (role.equals("airline")) {
                    response.sendRedirect("airline.jsp");
                } else {
                    response.sendRedirect("login.jsp?error=Invalid Role");
                }
            } else {
                response.sendRedirect("login.jsp?error=Invalid Username or Password");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=Database Connection Error");
        }
    }
}
