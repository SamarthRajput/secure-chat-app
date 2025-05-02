package auth;

import db.MongoDBUtil;
import org.mindrot.jbcrypt.BCrypt;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        String storedHash = MongoDBUtil.getPasswordHash(username);
        if (storedHash != null && BCrypt.checkpw(password, storedHash)) {
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            response.sendRedirect("chat.jsp");
        } else {
            response.getWriter().write("Invalid credentials");
        }
    }
}