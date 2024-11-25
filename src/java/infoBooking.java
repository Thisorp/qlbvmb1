/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import com.Database;
import com.booking;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
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
@WebServlet(urlPatterns = {"/infoBooking"})
public class infoBooking extends HttpServlet {

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
            out.println("<title>Servlet infoBooking</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet infoBooking at " + request.getContextPath() + "</h1>");
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
        
       // Get customerId from session
        Integer customerId = (Integer) request.getSession(false).getAttribute("customerId");
        
        ArrayList<booking> bookingList = new ArrayList<>();
        try (Connection con = Database.getConnection()) {
            String sql = "SELECT c.Name AS CustomerName, a.Name AS AirlineName, ap1.Name AS FromAirportName, ap2.Name AS ToAirportName, f.DepartureTime, f.ArrivalTime, f.Gate, s.SeatNumber, b.BookingDate FROM booking b JOIN customer c ON b.CustomerID = c.CustomerID JOIN flight f ON b.FlightID = f.FlightID JOIN airline a ON f.AirlineID = a.AirlineID JOIN airport ap1 ON f.FromAirportID = ap1.AirportID JOIN airport ap2 ON f.ToAirportID = ap2.AirportID JOIN seat s ON b.SeatID = s.SeatID WHERE c.CustomerID= ?";
             PreparedStatement statement = con.prepareStatement(sql);
            statement.setInt(1, customerId);
            ResultSet resultSet = statement.executeQuery();
             while (resultSet.next()) {
                booking booking = new booking(); // Make sure the class name starts with an uppercase letter
                booking.setCustomerName(resultSet.getString("CustomerName"));
                booking.setAirlineName(resultSet.getString("AirlineName"));
                booking.setFromAirportName(resultSet.getString("FromAirportName"));
                booking.setToAirportName(resultSet.getString("ToAirportName"));
                booking.setDepartureTime(resultSet.getDate("DepartureTime")); // Use getDate for java.sql.Date
                booking.setArrivalTime(resultSet.getDate("ArrivalTime")); // Use getDate for java.sql.Date
                booking.setGate(resultSet.getString("Gate"));
                booking.setSeatNumber(resultSet.getString("SeatNumber"));
                booking.setBookingDate(resultSet.getDate("BookingDate")); // Use getDate for java.sql.Date
                bookingList.add(booking);
            }
            request.setAttribute("bookingList", bookingList);
            request.getRequestDispatcher("bookingInfo.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
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
        processRequest(request, response);
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
