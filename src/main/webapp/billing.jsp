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
        <input type="text" name="accountNumber" placeholder="Enter Account Number">
        <br><br>
        <label>Telephone:</label>
        <input type="text" name="telephone" placeholder="Enter Telephone">
        <br><br>
        <input type="submit" value="Search Customer">
    </form>
    <p>If customer not found, <a href="addcustomer.jsp">Register New Customer</a></p>
</div>

<!-- Item Search -->
<div class="section">
    <h3>Add Item</h3>
    <form action="BillingServlet" method="post">
        <label>Book ID / Title:</label>
        <input type="text" name="bookSearch" placeholder="Enter Book ID or Title">
        <label>Quantity:</label>
        <input type="number" name="quantity" value="1" min="1">
        <input type="submit" name="action" value="Add Item">
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
            // Example placeholder data until you fetch from session or DB
            String[][] items = {
                    {"Java Basics", "John Doe", "1500.00", "1", "1500.00"},
                    {"Spring Boot Guide", "Jane Smith", "2500.00", "2", "5000.00"}
            };
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
        <label>Payment Method:</label>
        <select name="paymentMethod">
            <option value="Cash">Cash</option>
            <option value="Card">Card</option>
            <option value="Online">Online</option>
        </select>
        <br><br>
        <input type="submit" name="action" value="Generate Bill">
    </form>
</div>

</body>
</html>
