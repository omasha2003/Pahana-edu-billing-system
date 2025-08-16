package pahana.edu.business.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import pahana.edu.business.user.dto.UserDTO;
import pahana.edu.business.user.service.UserService;

import java.io.IOException;
import java.util.List;

@WebServlet("/manage-users")
public class ManageUsersServlet extends HttpServlet {
    private final UserService userService = new UserService();


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            UserDTO user = userService.getUserById(id);
            request.setAttribute("user", user);
            request.getRequestDispatcher("editUser.jsp").forward(request, response);
        } else {
            List<UserDTO> users = userService.getAllUsers();
            request.setAttribute("users", users);
            request.getRequestDispatcher("manageUsers.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            userService.deleteUser(id);
            response.sendRedirect("manage-users");

        } else if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String role = request.getParameter("role");

            UserDTO user = new UserDTO();
            user.setId(id);
            user.setUsername(username);
            user.setEmail(email);
            user.setPassword(password);
            user.setRole(role);

            userService.updateUser(user);
            response.sendRedirect("manage-users");
        }
    }
}