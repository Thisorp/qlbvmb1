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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    HttpSession session = request.getSession(false);
    Integer customerId = (Integer) session.getAttribute("CustomerID");

    if (customerId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    try (Connection con = Database.getConnection()) {
        PreparedStatement ps = con.prepareStatement("SELECT * FROM customer WHERE CustomerID = ?");
        ps.setInt(1, customerId);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            Customer customer = new Customer();
            customer.setId(rs.getInt("CustomerID"));
            customer.setName(rs.getString("Name"));
            customer.setEmail(rs.getString("Email"));
            customer.setPhone(rs.getString("Phone"));
            customer.setPassword(rs.getString("Password"));

            request.setAttribute("customer", customer);
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
