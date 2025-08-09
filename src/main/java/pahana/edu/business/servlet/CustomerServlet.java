package pahana.edu.business.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import pahana.edu.business.customer.dto.CustomerDTO;
import pahana.edu.business.customer.service.CustomerService;

import java.io.IOException;
import java.util.List;

@WebServlet("/customers")
public class CustomerServlet extends HttpServlet {
    private final CustomerService customerService = new CustomerService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String search = request.getParameter("search");
        List<CustomerDTO> customers;

        if (search != null && !search.trim().isEmpty()) {
            customers = customerService.searchByAccountOrName(search.trim());
        } else {
            customers = customerService.getAllCustomers();
        }

        request.setAttribute("customers", customers);
        request.getRequestDispatcher("manageCustomers.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            customerService.deleteCustomer(id);
            response.sendRedirect("customers");
            return;
        }

        if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            CustomerDTO customer = customerService.getCustomerById(id);
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("editCustomer.jsp").forward(request, response);
            return;
        }

        if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String accountNumber = request.getParameter("accountNumber");
            String customerName = request.getParameter("customerName");
            String address = request.getParameter("address");
            String telephone = request.getParameter("telephone");
            int unitsConsumed = 0;

            try {
                unitsConsumed = Integer.parseInt(request.getParameter("unitsConsumed"));
            } catch (NumberFormatException e) {
                // handle if needed
            }

            HttpSession session = request.getSession(false);
            String createdBy = (session != null && session.getAttribute("username") != null)
                    ? (String) session.getAttribute("username") : "unknown";

            CustomerDTO customer = new CustomerDTO();
            customer.setId(id);
            customer.setAccountNumber(accountNumber);
            customer.setCustomerName(customerName);
            customer.setAddress(address);
            customer.setTelephone(telephone);
            customer.setUnitsConsumed(unitsConsumed);
            customer.setCreatedBy(createdBy);

            customerService.updateCustomer(customer);
            response.sendRedirect("customers");
            return;
        }



        String idStr = request.getParameter("id");
        String accountNumber = request.getParameter("accountNumber");
        String customerName = request.getParameter("customerName");
        String address = request.getParameter("address");
        String telephone = request.getParameter("telephone");

        int unitsConsumed = 0;
        try {
            unitsConsumed = Integer.parseInt(request.getParameter("unitsConsumed"));
        } catch (NumberFormatException e) {

        }

        HttpSession session = request.getSession(false);
        String createdBy = (session != null && session.getAttribute("username") != null)
                ? (String) session.getAttribute("username") : "unknown";

        CustomerDTO customer = new CustomerDTO();
        if (idStr != null && !idStr.trim().isEmpty()) {
            customer.setId(Integer.parseInt(idStr));
        }

        customer.setAccountNumber(accountNumber);
        customer.setCustomerName(customerName);
        customer.setAddress(address);
        customer.setTelephone(telephone);
        customer.setUnitsConsumed(unitsConsumed);
        customer.setCreatedBy(createdBy);


        if (idStr != null && !idStr.trim().isEmpty()) {
            customerService.updateCustomer(customer);
        } else {
            customerService.addCustomer(customer);
        }

        response.sendRedirect("customers");
    }
}
