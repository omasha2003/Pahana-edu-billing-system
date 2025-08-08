<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Billing</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .section { border: 1px solid #ccc; padding: 15px; margin-bottom: 20px; }
        table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        th, td { border: 1px solid #ccc; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        .total { font-weight: bold; font-size: 1.2em; text-align: right; }
    </style>
</head>
<body>

<h2>Billing</h2>

<!-- Customer Search -->
<div class="section">
    <h3>Customer Details</h3>
    <form action="BillingServlet" method="get">
        <label>Account Number:</label>
        <input type="text" name="accountNumber" placeholder="Enter Account Number" value="<%= request.getParameter("accountNumber") != null ? request.getParameter("accountNumber") : "" %>">
        <br><br>
        <label>Telephone:</label>
        <input type="text" name="telephone" placeholder="Enter Telephone" value="<%= request.getParameter("telephone") != null ? request.getParameter("telephone") : "" %>">
        <br><br>
        <input type="submit" value="Search Customer">
    </form>
    <p>If customer not found, <a href="addcustomer.jsp">Register New Customer</a></p>

    <%
        // Prefer session attribute because it persists across requests
        Map<String, String> customer = (Map<String, String>) session.getAttribute("customer");
        if (customer != null) {
    %>
    <p><strong>Name:</strong> <%= customer.get("customer_name") %></p>
    <p><strong>Address:</strong> <%= customer.get("address") %></p>
    <p><strong>Telephone:</strong> <%= customer.get("telephone") %></p>
    <p><strong>Account Number:</strong> <%= customer.get("account_number") %></p>
    <% } %>
</div>

<!-- Item Search -->
<div class="section">
    <h3>Add Item</h3>
    <form action="BillingServlet" method="post">
        <input type="hidden" name="action" value="Add Item">
        <label>Book ID / Title:</label>
        <input type="text" name="bookSearch" placeholder="Enter Book ID or Title" required>
        <label>Quantity:</label>
        <input type="number" name="quantity" value="1" min="1" required>
        <br><br>
        <input type="submit" value="Add Item">
    </form>
</div>

<!-- Current Bill Items -->
<div class="section">
    <h3>Bill Items</h3>
    <table>
        <tr>
            <th>Item Title</th>
            <th>Author</th>
            <th>Price</th>
            <th>Qty</th>
            <th>Subtotal</th>
        </tr>
        <%
            List<String[]> items = (List<String[]>) session.getAttribute("billItems");
            if (items == null) {
                items = new ArrayList<>();
            }

            double total = 0;
            for (String[] item : items) {
                total += Double.parseDouble(item[4]);
        %>
        <tr>
            <td><%= item[0] %></td>
            <td><%= item[1] %></td>
            <td><%= item[2] %></td>
            <td><%= item[3] %></td>
            <td><%= item[4] %></td>
        </tr>
        <% } %>
    </table>
    <p class="total">Total: Rs. <%= total %></p>
</div>

<!-- Payment Method & Generate Bill -->
<div class="section">
    <h3>Payment</h3>
    <form action="BillingServlet" method="post">
        <input type="hidden" name="action" value="Generate Bill">
        <label>Cashier Name:</label>
        <input type="text" name="cashierName" required>
        <br><br>
        <label>Payment Method:</label>
        <select name="paymentMethod">
            <option value="Cash">Cash</option>
            <option value="Card">Card</option>
            <option value="Online">Online</option>
        </select>
        <br><br>
        <input type="submit" value="Generate Bill">
    </form>
</div>

</body>
</html>
