<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="pahana.edu.business.user.dto.UserDTO" %>
<%@ page import="pahana.edu.business.billing.dto.BillDTO" %>
<%@ page import="pahana.edu.business.billing.dto.BillItemDTO" %>
<%@ page import="pahana.edu.persistance.bill.dao.BillDAO" %>

<%

    UserDTO user = (UserDTO) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp?error=unauthorized");
        return;
    }
    String role = user.getRole();


    BillDAO billDAO = new BillDAO();
    List<BillDTO> bills = billDAO.getAllBills();
%>

<html>
<head>
    <title>Manage Orders</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f6f8;
        }

        h2 {
            text-align: center;
            margin-top: 30px;
        }

        table {
            width: 90%;
            border-collapse: collapse;
            margin: 30px auto;
            background-color: white;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }

        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
            vertical-align: top;
        }

        th {
            background-color: #2F4156;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        ul {
            padding-left: 15px;
            margin: 0;
            list-style-type: square;
        }

        .btn {
            padding: 6px 12px;
            margin: 2px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            text-decoration: none;
        }

        .view-btn {
            background-color: #9c6f76;
            color: white;
        }

        .delete-btn {
            background-color: #3260ae;
            color: white;
        }

        .btn:hover {
            opacity: 0.85;
        }
    </style>
</head>
<body>
<jsp:include page="navbar.jsp" />

<h2>All Bills / Orders</h2>

<table>
    <tr>
        <th>Bill No</th>
        <th>Customer ID</th>
        <th>Cashier</th>
        <th>Date</th>
        <th>Total</th>
        <th>Payment</th>
        <th>Items</th>
        <th>Actions</th>
    </tr>
    <%
        if (bills != null && !bills.isEmpty()) {
            for (BillDTO bill : bills) {
    %>
    <tr>
        <td><%= bill.getBillNo() %></td>
        <td><%= bill.getCustomerId() %></td>
        <td><%= bill.getCashierName() %></td>
        <td><%= bill.getBillDate() %></td>
        <td><%= bill.getTotalAmount() %></td>
        <td><%= bill.getPaymentMethod() %></td>
        <td>
            <ul>
                <%
                    if (bill.getItems() != null) {
                        for (BillItemDTO item : bill.getItems()) {
                %>
                <li><%= item.getItemTitle() %> (x<%= item.getQuantity() %>) - <%= item.getSubtotal() %></li>
                <%
                        }
                    }
                %>
            </ul>
        </td>
        <td>
            <a class="btn view-btn" href="billDetails.jsp?billId=<%= bill.getId() %>">View</a>
            <% if ("admin".equalsIgnoreCase(role)) { %>
            <a class="btn delete-btn" href="deleteBill?id=<%= bill.getId() %>"
               onclick="return confirm('Delete this bill?')">Delete</a>
            <% } %>
        </td>
    </tr>
    <%
        }
    } else {
    %>
    <tr>
        <td colspan="8">No orders found.</td>
    </tr>
    <% } %>
</table>

<jsp:include page="footer.jsp" />
</body>
</html>
