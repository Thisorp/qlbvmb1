/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import com.Database;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Huy pc
 */
@WebServlet(urlPatterns = {"/bookSeat"})
public class bookSeat extends HttpServlet {

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
            out.println("<title>Servlet bookSeat</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet bookSeat at " + request.getContextPath() + "</h1>");
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
         request.getRequestDispatcher("/flights.jsp").forward(request, response);
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
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        int flightId = Integer.parseInt(request.getParameter("flightId"));
        int seatId = Integer.parseInt(request.getParameter("seatId"));

        try (Connection con = Database.getConnection()) {
            String sql = "INSERT INTO booking (CustomerID, FlightID, SeatID, BookingDate, Status) VALUES (?, ?, ?, NOW(), TRUE)";
            PreparedStatement statement = con.prepareStatement(sql);
            statement.setInt(1, customerId);
            statement.setInt(2, flightId);
            statement.setInt(3, seatId);
            statement.executeUpdate();

            // Update seat availability
            String updateSeatSql = "UPDATE seat SET IsAvailable = FALSE WHERE SeatID = ?";
            PreparedStatement updateStatement = con.prepareStatement(updateSeatSql);
            updateStatement.setInt(1, seatId);
            updateStatement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        HttpSession session=request.getSession();
        session.setAttribute("customerId", customerId);
        
        response.sendRedirect("infoBooking");
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
