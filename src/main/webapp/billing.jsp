<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Billing - Pahana Edu Bookshop</title>
    <style>


        html, body {
            margin: 0;
            padding: 0;
            height: 100%;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f9fafb;
            color: #333;
            line-height: 1.6;
        }


        .billing-container {
            max-width: 1000px;
            margin: 20px auto 40px auto;
            padding: 20px 40px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #2c3e50;
            font-weight: 700;
            font-size: 2.2rem;
        }

        .section {
            padding: 25px 30px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgb(0 0 0 / 0.1);
            margin-bottom: 30px;
        }

        h3 {
            border-bottom: 2px solid #2F4156;
            padding-bottom: 8px;
            margin-bottom: 20px;
            color: #2F4156;
            font-weight: 600;
            font-size: 1.4rem;
        }

        form label {
            display: inline-block;
            width: 140px;
            font-weight: 600;
            color: #2F4156;
        }

        input[type="text"],
        input[type="number"],
        select {
            width: 250px;
            padding: 8px 10px;
            margin: 8px 0 15px 0;
            border: 1.8px solid #bdc3c7;
            border-radius: 5px;
            font-size: 1rem;
            transition: border-color 0.3s ease;
        }

        input[type="text"]:focus,
        input[type="number"]:focus,
        select:focus {
            border-color: #2F4156;
            outline: none;
        }

        input[type="submit"] {
            background-color: #2F4156;
            color: white;
            padding: 10px 24px;
            font-size: 1rem;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 600;
            transition: background-color 0.3s ease;
            margin-top: 10px;
        }

        input[type="submit"]:hover {
            background-color: #1e2b3d;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 12px;
        }

        th, td {
            padding: 12px 15px;
            border: 1px solid #ddd;
            text-align: left;
            font-size: 1rem;
        }

        th {
            background-color: #2F4156;
            color: #fff;
            font-weight: 700;
        }

        tbody tr:nth-child(even) {
            background-color: #f4f6f7;
        }

        .total {
            margin-top: 15px;
            text-align: right;
            font-size: 1.4rem;
            font-weight: 700;
            color: #2F4156;
        }

        a {
            color: #2F4156;
            text-decoration: none;
            font-weight: 600;
        }

        a:hover {
            text-decoration: underline;
        }

        @media (max-width: 600px) {
            .billing-container {
                padding: 15px 20px;
                margin: 10px auto 30px auto;
            }

            form label {

                margin-bottom: 6px;
                width: 100%;
            }

            input[type="text"],
            input[type="number"],
            select {
                width: 100%;
            }
        }
    </style>
</head>
<body>
<jsp:include page="navbar.jsp" />
<div class="billing-container">

    <h2>Billing</h2>

    <div class="section">
        <h3>Customer Details</h3>
        <form action="BillingServlet" method="get" autocomplete="off">
            <label for="accountNumber">Account Number:</label>
            <input id="accountNumber" type="text" name="accountNumber" placeholder="Enter Account Number" value="<%= request.getParameter("accountNumber") != null ? request.getParameter("accountNumber") : "" %>">
            <br>
            <label for="telephone">Telephone:</label>
            <input id="telephone" type="text" name="telephone" placeholder="Enter Telephone" value="<%= request.getParameter("telephone") != null ? request.getParameter("telephone") : "" %>">
            <br>
            <input type="submit" value="Search Customer">
        </form>
        <p>If customer not found, <a href="addcustomer.jsp">Register New Customer</a></p>

        <%
            Map<String, String> customer = (Map<String, String>) session.getAttribute("customer");
            if (customer != null) {
        %>
        <p><strong>Name:</strong> <%= customer.get("customer_name") %></p>
        <p><strong>Address:</strong> <%= customer.get("address") %></p>
        <p><strong>Telephone:</strong> <%= customer.get("telephone") %></p>
        <p><strong>Account Number:</strong> <%= customer.get("account_number") %></p>
        <% } %>
    </div>

    <div class="section">
        <h3>Add Item</h3>
        <form action="BillingServlet" method="post" autocomplete="off">
            <input type="hidden" name="action" value="Add Item">
            <label for="bookSearch">Book ID / Title:</label>
            <input id="bookSearch" type="text" name="bookSearch" placeholder="Enter Book ID or Title" required>
            <label for="quantity">Quantity:</label>
            <input id="quantity" type="number" name="quantity" value="1" min="1" required>
            <br>
            <input type="submit" value="Add Item">
        </form>
    </div>

    <div class="section">
        <h3>Bill Items</h3>
        <table>
            <thead>
            <tr>
                <th>Item Title</th>
                <th>Author</th>
                <th>Price (Rs.)</th>
                <th>Qty</th>
                <th>Subtotal (Rs.)</th>
            </tr>
            </thead>
            <tbody>
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
                <td><%= String.format("%.2f", Double.parseDouble(item[2])) %></td>
                <td><%= item[3] %></td>
                <td><%= String.format("%.2f", Double.parseDouble(item[4])) %></td>
            </tr>
            <% } %>
            </tbody>
        </table>
        <p class="total">Total: Rs. <%= String.format("%.2f", total) %></p>
    </div>

    <!-- Payment Section -->
    <div class="section">
        <h3>Payment</h3>
        <form action="BillingServlet" method="post" autocomplete="off">
            <input type="hidden" name="action" value="Generate Bill">
            <label for="cashierName">Cashier Name:</label>
            <input id="cashierName" type="text" name="cashierName" required>
            <br>
            <label for="paymentMethod">Payment Method:</label>
            <select id="paymentMethod" name="paymentMethod">
                <option value="Cash">Cash</option>
                <option value="Card">Card</option>
                <option value="Online">Online</option>
            </select>
            <br>
            <input type="submit" value="Generate Bill">
        </form>
    </div>

</div>
<script>
    window.addEventListener('beforeunload', function() {
        sessionStorage.setItem('scrollPos', window.scrollY);
    });

    window.addEventListener('load', function() {
        const scrollPos = sessionStorage.getItem('scrollPos');
        if (scrollPos) {
            window.scrollTo(0, scrollPos);
            sessionStorage.removeItem('scrollPos');
        }
    });
</script>

</body>
</html>
