/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import com.Database;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Huy pc
 */
@WebServlet(urlPatterns = {"/FlightServlet"})
public class FlightServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet FlightServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet FlightServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
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

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            String flightid=request.getParameter("flightid");
            String airlineId = request.getParameter("airlineId");
            String fromAirportId = request.getParameter("fromAirportId");
            String toAirportId = request.getParameter("toAirportId");
            String departureTime = request.getParameter("departureTime");
            String arrivalTime = request.getParameter("arrivalTime");
            String gate = request.getParameter("gate");
            try {
            Connection con = Database.getConnection();
            String sql = "INSERT INTO flight (FlightID, AirlineID, FromAirportID, ToAirportID, DepartureTime, ArrivalTime, Gate) VALUES (?, ?, ?, ?, ?, ?,?)";
            PreparedStatement statement = con.prepareStatement(sql);
            statement.setInt(1, Integer.parseInt(flightid));
            statement.setInt(2, Integer.parseInt(airlineId));
            statement.setInt(3, Integer.parseInt(fromAirportId));
            statement.setInt(4, Integer.parseInt(toAirportId));
            statement.setString(5, departureTime);
            statement.setString(6, arrivalTime);
            statement.setString(7, gate);
            statement.executeUpdate();
            
            } catch (Exception e) {
                e.printStackTrace();
            }
            response.sendRedirect("FlightServlet");
            
           
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
    private void listFlights(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Logic to list flights from the database and set it in the request
        // Use a JSP page to display the list
    }

    
    private void editFlight(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Logic to fetch flight details for editing
    }

    private void updateFlight(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Logic to update flight details in the database
    }

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

        response.sendRedirect("FlightServlet");
    }
}
