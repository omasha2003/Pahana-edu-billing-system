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

        List<UserDTO> users = userService.getAllUsers();

        // Debugging
        System.out.println("Fetched users: " + (users != null ? users.size() : "null"));

        request.setAttribute("users", users);
        request.getRequestDispatcher("manageUsers.jsp").forward(request, response);
    }
}
