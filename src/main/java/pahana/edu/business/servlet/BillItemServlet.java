package pahana.edu.business.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import pahana.edu.business.item.model.Item;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/billItem")
public class BillItemServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve parameters from form
        String itemName = request.getParameter("itemName");
        String priceStr = request.getParameter("price");
        String qtyStr = request.getParameter("quantity");

        double price = Double.parseDouble(priceStr);
        int quantity = Integer.parseInt(qtyStr);

        // Create an Item object (you can use your DTO/model here)
        Item item = new Item();
        item.setName(itemName);
        item.setPrice(price);
        item.setQuantity(quantity);

        // Calculate total for this item
        double total = price * quantity;
        item.setTotal(total); // Add this field in your model if you don’t have it

        // Get or create cart in session
        HttpSession session = request.getSession();
        List<Item> cart = (List<Item>) session.getAttribute("cart");

        if (cart == null) {
            cart = new ArrayList<>();
        }

        cart.add(item);
        session.setAttribute("cart", cart);

        // Redirect back to billing page
        response.sendRedirect("billing.jsp");
    }
}
