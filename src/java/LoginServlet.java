import com.Database;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;

public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy thông tin đăng nhập từ form
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Biến lưu trữ role và customerID
        String role = null;
        String nameA = null;
        String nameC = null;
        String phoneA = null;
        String phoneC = null;// Thêm biến phone
        int customerID = 0;  // Giữ nguyên kiểu dữ liệu là int cho customerID

        try (Connection conn = Database.getConnection()) { // Sử dụng try-with-resources để tự động đóng kết nối
            // Truy vấn kiểm tra tài khoản admin
            String adminQuery = "SELECT Role, Username FROM admin WHERE Email = ? AND Password = ?";
            try (PreparedStatement adminStmt = conn.prepareStatement(adminQuery)) {
                adminStmt.setString(1, username);
                adminStmt.setString(2, password);
                try (ResultSet adminRs = adminStmt.executeQuery()) {
                    if (adminRs.next()) {
                        role = adminRs.getString("Role");
                        nameA = adminRs.getString("Username");
                    }
                }
            }

            // Truy vấn kiểm tra tài khoản customer nếu không tìm thấy role
            if (role == null) {
                String customerQuery = "SELECT CustomerID, Name, Phone FROM customer WHERE Email = ? AND Password = ?";
                try (PreparedStatement customerStmt = conn.prepareStatement(customerQuery)) {
                    customerStmt.setString(1, username);
                    customerStmt.setString(2, password);
                    try (ResultSet customerRs = customerStmt.executeQuery()) {
                        if (customerRs.next()) {
                            customerID = customerRs.getInt("CustomerID");  // Sử dụng getInt cho kiểu dữ liệu CustomerID
                            nameC = customerRs.getString("Name");
                            phoneC = customerRs.getString("Phone");  // Lấy số điện thoại
                        }
                    }
                }
            }

            HttpSession session = request.getSession();

            // Điều hướng dựa trên kết quả
            if (role != null) {
                // Kiểm tra vai trò và lưu thông tin vào session
                session.setAttribute("name", nameA);
                session.setAttribute("role", role);
                switch (role) {
                    case "admin":
                        response.sendRedirect("HomeServlet");
                        break;
                    case "airport":
                        response.sendRedirect("HomeServlet");
                        break;
                    case "airline":
                        response.sendRedirect("HomeServlet");
                        break;
                    default:
                        response.sendRedirect("login.jsp?error=Invalid Role");
                        break;
                }
            } else if (customerID > 0) {  // Kiểm tra customerID
                // Lưu thông tin customer vào session
                session.setAttribute("name", nameC);
                session.setAttribute("phone", phoneC);  // Lưu số điện thoại
                session.setAttribute("role", "customer");
                session.setAttribute("CustomerID", customerID);  // Lưu ID khách hàng
                response.sendRedirect("HomeServlet");
            } else {
                response.sendRedirect("login.jsp?error=Invalid Email or Password");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=Database Connection Error");
        }
    }
}
