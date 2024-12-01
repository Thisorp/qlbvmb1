import com.Database;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/AirportServlet")
public class AirportServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String search = request.getParameter("search");
        List<Airport> airports = new ArrayList<>();
        try (Connection con = Database.getConnection()) {
            String query = "SELECT * FROM airport";
            if (search != null && !search.isEmpty()) {
                query += " WHERE Name LIKE ?";
            }
            PreparedStatement ps = con.prepareStatement(query);
            if (search != null && !search.isEmpty()) {
                ps.setString(1, "%" + search + "%");
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                airports.add(new Airport(
                        rs.getInt("AirportID"),
                        rs.getString("Name"),
                        rs.getString("Location"),
                        rs.getString("ContactInfo")
                ));
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        request.setAttribute("airports", airports);
        request.getRequestDispatcher("airport.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try (Connection con = Database.getConnection()) {
            if ("add".equals(action)) {
                String name = request.getParameter("name");
                String location = request.getParameter("location");
                String contactInfo = request.getParameter("contactInfo");
                String query = "INSERT INTO airport (Name, Location, ContactInfo) VALUES (?, ?, ?)";
                PreparedStatement ps = con.prepareStatement(query);
                ps.setString(1, name);
                ps.setString(2, location);
                ps.setString(3, contactInfo);
                ps.executeUpdate();
            } else if ("edit".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                String name = request.getParameter("name");
                String location = request.getParameter("location");
                String contactInfo = request.getParameter("contactInfo");
                String query = "UPDATE airport SET Name = ?, Location = ?, ContactInfo = ? WHERE AirportID = ?";
                PreparedStatement ps = con.prepareStatement(query);
                ps.setString(1, name);
                ps.setString(2, location);
                ps.setString(3, contactInfo);
                ps.setInt(4, id);
                ps.executeUpdate();
            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                String query = "DELETE FROM airport WHERE AirportID = ?";
                PreparedStatement ps = con.prepareStatement(query);
                ps.setInt(1, id);
                ps.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        response.sendRedirect("AirportServlet");
    }
}
