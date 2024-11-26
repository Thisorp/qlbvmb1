import com.Database;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"/FlightServlet"})
public class FlightServlet extends HttpServlet {

    // Method to handle GET requests
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("list".equals(action)) {
            listFlights(request, response);
        } else if ("edit".equals(action)) {
            editFlight(request, response);
        } else if ("delete".equals(action)) {
            deleteFlight(request, response);
        } else {
            response.sendRedirect("managerFlight.jsp");
        }
    }

    // Method to handle POST requests (used for creating or updating flights)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String flightid = request.getParameter("flightid");
        String airlineId = request.getParameter("airlineId");
        String fromAirportId = request.getParameter("fromAirportId");
        String toAirportId = request.getParameter("toAirportId");
        String departureTime = request.getParameter("departureTime");
        String arrivalTime = request.getParameter("arrivalTime");
        String gate = request.getParameter("gate");

        String action = request.getParameter("action");

        try (Connection con = Database.getConnection()) {
            if ("edit".equals(action)) {
                // Update flight details
                String sql = "UPDATE flight SET AirlineID = ?, FromAirportID = ?, ToAirportID = ?, DepartureTime = ?, ArrivalTime = ?, Gate = ? WHERE FlightID = ?";
                PreparedStatement statement = con.prepareStatement(sql);
                statement.setInt(1, Integer.parseInt(airlineId));
                statement.setInt(2, Integer.parseInt(fromAirportId));
                statement.setInt(3, Integer.parseInt(toAirportId));
                statement.setString(4, departureTime);
                statement.setString(5, arrivalTime);
                statement.setString(6, gate);
                statement.setInt(7, Integer.parseInt(flightid));
                statement.executeUpdate();
                response.sendRedirect("FlightServlet?action=list");
            } else {
                // Insert new flight
                String sql = "INSERT INTO flight (FlightID, AirlineID, FromAirportID, ToAirportID, DepartureTime, ArrivalTime, Gate) VALUES (?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement statement = con.prepareStatement(sql);
                statement.setInt(1, Integer.parseInt(flightid));
                statement.setInt(2, Integer.parseInt(airlineId));
                statement.setInt(3, Integer.parseInt(fromAirportId));
                statement.setInt(4, Integer.parseInt(toAirportId));
                statement.setString(5, departureTime);
                statement.setString(6, arrivalTime);
                statement.setString(7, gate);
                statement.executeUpdate();
                response.sendRedirect("FlightServlet?action=list");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to list all flights
    private void listFlights(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (Connection con = Database.getConnection()) {
            String sql = "SELECT * FROM flight";
            PreparedStatement statement = con.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();

            request.setAttribute("flights", rs);
            request.getRequestDispatcher("/managerFlight.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to show flight details for editing
    private void editFlight(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String flightId = request.getParameter("flightId");

        try (Connection con = Database.getConnection()) {
            String sql = "SELECT * FROM flight WHERE FlightID = ?";
            PreparedStatement statement = con.prepareStatement(sql);
            statement.setInt(1, Integer.parseInt(flightId));
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                // Set flight details as request attributes
                request.setAttribute("flight", rs);
                request.getRequestDispatcher("/editFlight.jsp").forward(request, response); // Forward to editFlight.jsp
            } else {
                response.sendRedirect("managerFlight.jsp"); // Flight not found, redirect
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to delete a flight
    private void deleteFlight(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String flightId = request.getParameter("flightId");

        try (Connection con = Database.getConnection()) {
            String sql = "DELETE FROM flight WHERE FlightID = ?";
            PreparedStatement statement = con.prepareStatement(sql);
            statement.setInt(1, Integer.parseInt(flightId));
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect("FlightServlet?action=list"); // Redirect after deletion
    }
}
