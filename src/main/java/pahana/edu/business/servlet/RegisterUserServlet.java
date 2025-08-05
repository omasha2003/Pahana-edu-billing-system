package pahana.edu.business.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import pahana.edu.business.user.model.User;
import pahana.edu.persistance.user.dao.UserDAO;

import java.io.IOException;


@WebServlet("/register-user")
public class RegisterUserServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        User user = new User();
        user.setUsername(username);
        user.setEmail(email);
        user.setPassword(password);
        user.setRole(role);

        boolean success = userDAO.insertUser(user);

        if (success) {
            // Redirect to user list or login page after success
            response.sendRedirect("manage-users");
        } else {
            // Could not insert user, show error or redirect back with error message
            request.setAttribute("errorMessage", "Registration failed. Please try again.");
            request.getRequestDispatcher("UserRegister.jsp").forward(request, response);
        }
    }
}
