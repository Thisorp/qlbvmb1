import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

public class HeaderServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("logout".equals(request.getParameter("action"))) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate(); // Hủy session
            }
            response.sendRedirect("index.jsp"); // Redirect về trang chủ sau khi logout
        }

    }
}
