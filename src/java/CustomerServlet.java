import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.Database;
import com.Customer;

@WebServlet("/CustomerServlet")
public class CustomerServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Lấy thông tin CustomerID và phone từ session
        HttpSession session = request.getSession(false);
        Integer customerId = (Integer) session.getAttribute("CustomerID");  // Lấy CustomerID từ session
        String phone = (String) session.getAttribute("phone");  // Lấy phone từ session

        if (customerId == null) {
            response.sendRedirect("login.jsp");  // Nếu không có CustomerID trong session, chuyển hướng đến trang login
            return;
        }

        try (Connection con = Database.getConnection()) {
            // Truy vấn lấy thông tin customer từ cơ sở dữ liệu dựa trên CustomerID
            PreparedStatement ps = con.prepareStatement("SELECT * FROM customer WHERE CustomerID = ?");
            ps.setInt(1, customerId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Tạo đối tượng customer và gán giá trị từ ResultSet
                Customer customer = new Customer();
                customer.setId(rs.getInt("CustomerID"));
                customer.setName(rs.getString("Name"));
                customer.setEmail(rs.getString("Email"));
                customer.setPhone(rs.getString("Phone"));  // Đảm bảo lấy được số điện thoại
                customer.setPassword(rs.getString("Password"));

                // Đặt đối tượng customer vào request để hiển thị trên trang JSP
                request.setAttribute("customer", customer);
                request.setAttribute("phone", phone);  // Truyền thêm số điện thoại từ session vào request
                request.getRequestDispatcher("editCustomer.jsp").forward(request, response);
            } else {
                response.sendRedirect("error.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

}
