import com.Database;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AirlineServlet")
public class AirlineServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            deleteAirline(id);
        } else if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            // Chuyển hướng tới trang edit.jsp hoặc xử lý sửa trực tiếp
            response.sendRedirect("edit.jsp?id=" + id);
        }
        
        response.sendRedirect("airline.jsp"); // Sau khi thực hiện hành động, quay lại trang airline.jsp
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            String name = request.getParameter("name");
            String contactInfo = request.getParameter("contactInfo");
            addAirline(name, contactInfo);
        }

        response.sendRedirect("airline.jsp"); // Sau khi thực hiện hành động, quay lại trang airline.jsp
    }

    private void addAirline(String name, String contactInfo) {
        try (Connection con = Database.getConnection();
             PreparedStatement ps = con.prepareStatement("INSERT INTO airline (Name, ContactInfo) VALUES (?, ?)")) {
            ps.setString(1, name);
            ps.setString(2, contactInfo);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void deleteAirline(int id) {
        try (Connection con = Database.getConnection();
             PreparedStatement ps = con.prepareStatement("DELETE FROM airline WHERE AirlineID = ?")) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void editAirline(int id, String name, String contactInfo) {
        try (Connection con = Database.getConnection();
             PreparedStatement ps = con.prepareStatement("UPDATE airline SET Name = ?, ContactInfo = ? WHERE AirlineID = ?")) {
            ps.setString(1, name);
            ps.setString(2, contactInfo);
            ps.setInt(3, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
