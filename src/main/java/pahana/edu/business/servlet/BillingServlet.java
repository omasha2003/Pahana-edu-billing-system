package pahana.edu.business.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.security.SecureRandom;
import java.util.*;

import pahana.edu.persistance.customer.dao.CustomerDAO;
import pahana.edu.persistance.item.dao.ItemDAO;
import pahana.edu.business.billing.dto.BillDTO;
import pahana.edu.business.billing.dto.BillItemDTO;
import pahana.edu.business.billing.service.BillService;

@WebServlet("/BillingServlet")
public class BillingServlet extends HttpServlet {

    private final CustomerDAO customerDAO = new CustomerDAO();
    private final ItemDAO itemDAO = new ItemDAO();
    private final BillService billService = new BillService();


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accountNumber = request.getParameter("accountNumber");
        String telephone = request.getParameter("telephone");

        if ((accountNumber != null && !accountNumber.isEmpty()) || (telephone != null && !telephone.isEmpty())) {
            Map<String, String> customer = customerDAO.findCustomer(accountNumber, telephone);
            if (customer != null) {
                request.getSession().setAttribute("customer", customer);
            } else {
                request.getSession().removeAttribute("customer");
            }
        }

        request.getRequestDispatcher("billing.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String action = request.getParameter("action");

        if ("Add Item".equals(action)) {
            String bookSearch = request.getParameter("bookSearch");
            int qty = 1;
            try {
                qty = Integer.parseInt(request.getParameter("quantity"));
            } catch (NumberFormatException e) {
                qty = 1;
            }

            List<String[]> billItems = (List<String[]>) session.getAttribute("billItems");
            if (billItems == null) billItems = new ArrayList<>();

            Map<String, String> item = itemDAO.findItem(bookSearch);
            if (item != null) {
                double price = Double.parseDouble(item.get("price"));
                double subtotal = price * qty;
                billItems.add(new String[]{
                        item.get("title"),
                        item.get("author"),
                        String.valueOf(price),
                        String.valueOf(qty),
                        String.valueOf(subtotal),
                        item.get("id")
                });
            }

            session.setAttribute("billItems", billItems);

            response.sendRedirect("billing.jsp");

        } else if ("Generate Bill".equals(action)) {
            String cashierName = request.getParameter("cashierName");
            String paymentMethod = request.getParameter("paymentMethod");

            Map<String, String> customer = (Map<String, String>) session.getAttribute("customer");
            if (customer == null) {
                response.getWriter().println("No customer selected!");
                return;
            }

            int customerId = Integer.parseInt(customer.get("id"));
            List<String[]> billItemsList = (List<String[]>) session.getAttribute("billItems");

            if (billItemsList != null && !billItemsList.isEmpty()) {
                BillDTO bill = new BillDTO();

                bill.setBillNo(generateBillNo());

                bill.setCustomerId(customerId);
                bill.setCashierName(cashierName);
                bill.setPaymentMethod(paymentMethod);

                double total = 0;
                List<BillItemDTO> billItemDTOs = new ArrayList<>();
                for (String[] bi : billItemsList) {
                    BillItemDTO itemDTO = new BillItemDTO();
                    itemDTO.setItemId(Integer.parseInt(bi[5]));
                    itemDTO.setQuantity(Integer.parseInt(bi[3]));
                    itemDTO.setPrice(Double.parseDouble(bi[2]));
                    itemDTO.setSubtotal(Double.parseDouble(bi[4]));
                    total += itemDTO.getSubtotal();
                    billItemDTOs.add(itemDTO);
                }
                bill.setTotalAmount(total);
                bill.setItems(billItemDTOs);

                try {
                    int billId = billService.createBill(bill);

                    customerDAO.incrementUnitsConsumed(customerId);

                    session.removeAttribute("billItems");
                    session.removeAttribute("customer");

                    response.sendRedirect("billDetails.jsp?billId=" + billId);
                } catch (Exception e) {
                    e.printStackTrace();
                    response.getWriter().println("Error generating bill: " + e.getMessage());
                }
            } else {
                response.getWriter().println("No items in bill!");
            }
        }
    }
    private String generateBillNo() {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        SecureRandom random = new SecureRandom();
        StringBuilder sb = new StringBuilder("BILL-");
        for (int i = 0; i < 7; i++) {
            sb.append(chars.charAt(random.nextInt(chars.length())));
        }
        return sb.toString();
    }
}
