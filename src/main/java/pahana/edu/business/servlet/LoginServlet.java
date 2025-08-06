package pahana.edu.business.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import pahana.edu.business.user.dto.UserDTO;
import pahana.edu.business.user.service.UserService;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        UserDTO user = userService.login(username, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            if ("admin".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect("admindashboard.jsp");
            } else if ("user".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect("userDashboard.jsp");
            } else {
                response.sendRedirect("login.jsp?error=role");
            }
        } else {
            response.sendRedirect("login.jsp?error=invalid");
        }
        HttpSession session = request.getSession();
        session.setAttribute("username", user.getUsername());
    }
}
