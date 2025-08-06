package pahana.edu.business.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import pahana.edu.business.item.dto.ItemDTO;
import pahana.edu.business.item.service.ItemService;

import java.io.IOException;
import java.util.List;

@WebServlet("/items")
public class ItemServlet extends HttpServlet {
    private final ItemService itemService = new ItemService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<ItemDTO> items = itemService.getAllItems();
        request.setAttribute("items", items);
        request.getRequestDispatcher("manageItems.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            itemService.deleteItem(id);
            response.sendRedirect("items");
            return;
        }

        if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            ItemDTO item = itemService.getItemById(id);
            request.setAttribute("item", item);
            request.getRequestDispatcher("editItem.jsp").forward(request, response);
            return;
        }

        // Default action - Add new item
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        double price = Double.parseDouble(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String category = request.getParameter("category");
        String language = request.getParameter("language");

        HttpSession session = request.getSession(false);
        String addedBy = (session != null && session.getAttribute("username") != null)
                ? (String) session.getAttribute("username") : "unknown";

        ItemDTO item = new ItemDTO();
        item.setTitle(title);
        item.setAuthor(author);
        item.setPrice(price);
        item.setQuantity(quantity);
        item.setCategory(category);
        item.setLanguage(language);
        item.setAddedBy(addedBy);

        itemService.addItem(item);
        response.sendRedirect("items");
    }
}
