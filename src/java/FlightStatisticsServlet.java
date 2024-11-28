import com.Database;  // Nhập lớp Database
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/statistics")
public class FlightStatisticsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Kết nối với cơ sở dữ liệu và truy vấn bảng flight_statistics
        List<FlightStatistics> flightStatistics = new ArrayList<>();
        
        String query = "SELECT FlightID, AirlineID, TotalSeatsBooked, AvailableSeats FROM flight_statistics";
        
        try (Connection conn = Database.getConnection(); // Sử dụng phương thức từ lớp Database
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
             
            while (rs.next()) {
                FlightStatistics stat = new FlightStatistics(
                        rs.getInt("FlightID"),
                        rs.getInt("AirlineID"),
                        rs.getInt("TotalSeatsBooked"),
                        rs.getInt("AvailableSeats")
                );
                flightStatistics.add(stat);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        // Đặt danh sách flightStatistics vào request scope
        request.setAttribute("flightStatistics", flightStatistics);
        
        // Chuyển đến trang JSP
        RequestDispatcher dispatcher = request.getRequestDispatcher("statistics.jsp");
        dispatcher.forward(request, response);
    }
}
