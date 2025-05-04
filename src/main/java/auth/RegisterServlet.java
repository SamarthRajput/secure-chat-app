package auth;

import db.MongoDBUtil;
import org.mindrot.jbcrypt.BCrypt;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        String hashed = BCrypt.hashpw(password, BCrypt.gensalt());
        boolean success = MongoDBUtil.registerUser(username, hashed);

        if (success) {
            response.sendRedirect("login.jsp");
        } else {
            response.getWriter().write("User already exists.");
        }
    }
}