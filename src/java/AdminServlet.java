import com.Database;    
import com.Admin;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/AdminServlet")
public class AdminServlet extends HttpServlet {

    @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String action = request.getParameter("action");

    if ("delete".equals(action)) {
        try (Connection con = Database.getConnection()) {
            deleteAdmin(request, con); // Gọi phương thức deleteAdmin nếu hành động là xóa
        } catch (SQLException e) {
            e.printStackTrace();
        }
        response.sendRedirect("AdminServlet");  // Sau khi xóa, chuyển hướng lại danh sách
        return;
    }

    // Tiếp tục xử lý cho các action khác nếu cần
    String search = request.getParameter("search");
    List<Admin> admins = new ArrayList<>();

    try (Connection con = Database.getConnection()) {
        String query = "SELECT * FROM admin";
        if (search != null && !search.trim().isEmpty()) {
            query += " WHERE Username LIKE ?";
        }
        PreparedStatement ps = con.prepareStatement(query);
        if (search != null && !search.trim().isEmpty()) {
            ps.setString(1, "%" + search + "%");
        }
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Admin admin = new Admin(
                    rs.getInt("Id"),
                    rs.getString("Username"),
                    rs.getString("Password"),
                    rs.getString("Email"),
                    rs.getString("Phone"),
                    rs.getString("Role")
            );
            admins.add(admin);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    request.setAttribute("admins", admins);
    request.getRequestDispatcher("admin.jsp").forward(request, response);
}


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try (Connection con = Database.getConnection()) {
            if ("add".equals(action)) {
                addAdmin(request, con);
            } else if ("edit".equals(action)) {
                editAdmin(request, con);
            } else if ("delete".equals(action)) {
                deleteAdmin(request, con);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect("AdminServlet");
    }

    private void addAdmin(HttpServletRequest request, Connection con) throws SQLException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String role = request.getParameter("role");

        String query = "INSERT INTO admin (Username, Password, Email, Phone, Role) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, email);
            ps.setString(4, phone);
            ps.setString(5, role);
            ps.executeUpdate();
        }
    }

    private void editAdmin(HttpServletRequest request, Connection con) throws SQLException {
        int id = Integer.parseInt(request.getParameter("id"));
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String role = request.getParameter("role");

        String query = "UPDATE admin SET Username = ?, Password = ?, Email = ?, Phone = ?, Role = ? WHERE Id = ?";
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, email);
            ps.setString(4, phone);
            ps.setString(5, role);
            ps.setInt(6, id);
            ps.executeUpdate();
        }
    }

    private void deleteAdmin(HttpServletRequest request, Connection con) throws SQLException {
    // Lấy id từ request
    int id = Integer.parseInt(request.getParameter("id"));

    // Câu lệnh SQL để xóa admin theo id
    String query = "DELETE FROM admin WHERE Id = ?";

    // Thực hiện câu lệnh xóa
    try (PreparedStatement ps = con.prepareStatement(query)) {
        ps.setInt(1, id);  // Đặt giá trị id vào câu lệnh
        int affectedRows = ps.executeUpdate();  // Thực thi câu lệnh và lấy số dòng bị ảnh hưởng

        // Kiểm tra nếu không có dòng nào bị ảnh hưởng, tức là không có admin nào được xóa
        if (affectedRows == 0) {
            throw new SQLException("No admin found with the given ID.");
        }
    }
}

}
