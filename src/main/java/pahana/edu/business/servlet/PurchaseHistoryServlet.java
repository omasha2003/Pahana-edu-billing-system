package pahana.edu.business.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import pahana.edu.business.billing.dto.BillDTO;
import pahana.edu.business.billing.service.BillService;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/purchaseHistory")
public class PurchaseHistoryServlet extends HttpServlet {

    private final BillService billService = new BillService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String customerIdStr = request.getParameter("customerId");
        if (customerIdStr == null || customerIdStr.isEmpty()) {
            response.sendRedirect("customers");
            return;
        }

        int customerId;
        try {
            customerId = Integer.parseInt(customerIdStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("customers");
            return;
        }

        try {
            List<BillDTO> bills = billService.getBillsWithItemsByCustomerId(customerId);
            request.setAttribute("bills", bills);
            request.getRequestDispatcher("purchaseHistory.jsp").forward(request, response);
        } catch (ClassNotFoundException e) {
            throw new ServletException("Failed to load purchase history", e);
        }

    }
}
