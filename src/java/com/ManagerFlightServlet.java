package com;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// Servlet để quản lý chuyến bay
@WebServlet("/managerFlightServlet")
public class ManagerFlightServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Do GET để lấy danh sách chuyến bay từ database và chuyển dữ liệu tới JSP
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Flight> flights = new ArrayList<>();
        
        try {
            // Sử dụng Database.java để kết nối và lấy dữ liệu
            Connection conn = Database.getConnection();  // Kiểm tra phương thức này trong class Database
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT f.*, a1.AirlineName, a2.AirportName AS FromAirportName, a3.AirportName AS ToAirportName " +
                                            "FROM flight f " +
                                            "JOIN airline a1 ON f.AirlineID = a1.AirlineID " +
                                            "JOIN airport a2 ON f.FromAirportID = a2.AirportID " +
                                            "JOIN airport a3 ON f.ToAirportID = a3.AirportID");

            while (rs.next()) {
                Flight flight = new Flight();
                flight.setFlightID(rs.getInt("FlightID"));
                flight.setAirlineID(rs.getInt("AirlineID"));
                flight.setFromAirportID(rs.getInt("FromAirportID"));
                flight.setToAirportID(rs.getInt("ToAirportID"));
                flight.setDepartureTime(rs.getTimestamp("DepartureTime"));
                flight.setArrivalTime(rs.getTimestamp("ArrivalTime"));
                flight.setGate(rs.getString("Gate"));
                flight.setAirlineName(rs.getString("AirlineName"));
                flight.setFromAirportName(rs.getString("FromAirportName"));
                flight.setToAirportName(rs.getString("ToAirportName"));
                
                // Thêm chuyến bay vào danh sách
                flights.add(flight);
            }

            // Đóng kết nối
            rs.close();
            stmt.close();
            conn.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Chuyển danh sách chuyến bay tới JSP để hiển thị
        request.setAttribute("flights", flights);
        request.getRequestDispatcher("managerFlight.jsp").forward(request, response);
    }
}
