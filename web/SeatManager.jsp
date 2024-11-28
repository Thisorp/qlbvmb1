/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import com.Database;
import com.seat;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import java.sql.*;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Huy pc
 */
@WebServlet(urlPatterns = {"/SeatManagerServlet"})
public class SeatManagerServlet extends HttpServlet {

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
            out.println("<title>Servlet SeatManagerServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SeatManagerServlet at " + request.getContextPath() + "</h1>");
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
        String flightId = request.getParameter("flightId");
        String action = request.getParameter("action");

        if (flightId == null || flightId.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Flight ID is required.");
            return;
        }

        if ("edit".equals(action)) {
            // Handle editing a seat
            editSeat(request, response);
        } else if ("delete".equals(action)) {
            // Handle deleting a seat
            deleteSeat(request, response);
        } else {
            // Show seat list
            listSeats(request, response, flightId);
        }
    }
    // Display all seats for a specific flight
    private void listSeats(HttpServletRequest request, HttpServletResponse response, String flightId) throws ServletException, IOException {
        if (flightId == null || flightId.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Flight ID is required.");
            return;
        }

        List<seat> seats = new ArrayList<>();
        try (Connection con = Database.getConnection()) {
            String sql = "SELECT * FROM seat WHERE FlightID = ?";
            PreparedStatement statement = con.prepareStatement(sql);
            statement.setInt(1, Integer.parseInt(flightId)); // Ensure that flightId is not null
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                seat seat = new seat(
                        resultSet.getInt("SeatID"),
                        resultSet.getString("SeatNumber"),
                        resultSet.getBoolean("IsAvailable"),
                        resultSet.getBigDecimal("Price")
                );
                seats.add(seat);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("seats", seats);
        RequestDispatcher dispatcher = request.getRequestDispatcher("SeatManager.jsp");
        dispatcher.forward(request, response);
    }

    // Handle seat editing
    private void editSeat(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String seatId = request.getParameter("seatId");
        seat seatToEdit = null;

        try (Connection con = Database.getConnection()) {
            String sql = "SELECT * FROM seat WHERE SeatID = ?";
            PreparedStatement statement = con.prepareStatement(sql);
            statement.setInt(1, Integer.parseInt(seatId));
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                seatToEdit = new seat(
                    resultSet.getInt("SeatID"),
                    resultSet.getString("SeatNumber"),
                    resultSet.getBoolean("IsAvailable"),
                    resultSet.getBigDecimal("Price")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("seat", seatToEdit);
        RequestDispatcher dispatcher = request.getRequestDispatcher("SeatManager.jsp");
        dispatcher.forward(request, response);
    }

    // Handle deleting a seat
    private void deleteSeat(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String seatId = request.getParameter("seatId");

        if (seatId != null) {
            try (Connection con = Database.getConnection()) {
                String sql = "DELETE FROM seat WHERE SeatID = ?";
                PreparedStatement statement = con.prepareStatement(sql);
                statement.setInt(1, Integer.parseInt(seatId));
                int rowsAffected = statement.executeUpdate();

                if (rowsAffected > 0) {
                    response.sendRedirect("SeatManagerServlet?flightId=" + request.getParameter("flightId"));
                } else {
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to delete seat");
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Seat ID is missing");
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
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            addSeat(request, response);
        } else if ("update".equals(action)) {
            updateSeat(request, response);
        }
    }
   // Method to add a new seat
   private void addSeat(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String seatNumber = request.getParameter("seatNumber");
    String isAvailable = request.getParameter("isAvailable");
    String price = request.getParameter("price");
    String flightId = request.getParameter("flightId");

    if (seatNumber != null && price != null && flightId != null) {
        try (Connection con = Database.getConnection()) {
            String sql = "INSERT INTO seat (FlightID, SeatNumber, IsAvailable, Price) VALUES (?, ?, ?, ?)";
            PreparedStatement statement = con.prepareStatement(sql);
            statement.setInt(1, Integer.parseInt(flightId));
            statement.setString(2, seatNumber);
            // Convert the checkbox value into a boolean
            statement.setBoolean(3, "on".equals(isAvailable)); 
            statement.setBigDecimal(4, new BigDecimal(price));

            int rowsAffected = statement.executeUpdate();
            if (rowsAffected > 0) {
                response.sendRedirect("SeatManagerServlet?flightId=" + flightId);
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to add seat");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    } else {
        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Seat details are incomplete");
    }
}


    // Method to update seat details
    private void updateSeat(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String seatId = request.getParameter("seatId"); // Retrieve seatId
    String seatNumber = request.getParameter("seatNumber");
    String isAvailable = request.getParameter("isAvailable");
    String price = request.getParameter("price");
    String flightId = request.getParameter("flightId"); // Retrieve flightId

    // Ensure seatId and flightId are not null or empty
    if (seatId != null && !seatId.isEmpty() && flightId != null && !flightId.isEmpty()) {
        try (Connection con = Database.getConnection()) {
            String sql = "UPDATE seat SET SeatNumber = ?, IsAvailable = ?, Price = ? WHERE SeatID = ?";
            PreparedStatement statement = con.prepareStatement(sql);
            statement.setString(1, seatNumber);
            statement.setBoolean(2, "on".equals(isAvailable)); // Convert checkbox to boolean
            statement.setBigDecimal(3, new BigDecimal(price));
            statement.setInt(4, Integer.parseInt(seatId)); // Use seatId from the form

            int rowsAffected = statement.executeUpdate();

            if (rowsAffected > 0) {
                response.sendRedirect("SeatManagerServlet?flightId=" + flightId); // Redirect with flightId
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to update seat");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    } else {
        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Seat ID or Flight ID is missing");
    }
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

}