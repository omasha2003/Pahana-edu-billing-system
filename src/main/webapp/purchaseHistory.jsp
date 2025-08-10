<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="pahana.edu.business.billing.dto.BillDTO" %>
<%@ page import="pahana.edu.business.billing.dto.BillItemDTO" %>

<html>
<head>
    <title>Purchase History</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f6f8;
        }

        h2 {
            text-align: center;
            margin-top: 30px;
        }

        .bill-container {
            width: 90%;
            background-color: white;
            margin: 30px auto;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        .bill-header {
            font-weight: 600;
            margin-bottom: 10px;
            font-size: 18px;
            color: #2F4156;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }

        th {
            background-color: #f2f2f2;
            font-weight: 600;
        }

        tr:hover {
            background-color: #f0f0f0;
        }

        a.back-link {
            display: block;
            text-align: center;
            margin: 20px auto;
            font-size: 16px;
            color: #2F4156;
            text-decoration: none;
            font-weight: 600;
            width: max-content;
            padding: 8px 16px;
            border: 1px solid #2F4156;
            border-radius: 4px;
            transition: background-color 0.2s ease, color 0.2s ease;
        }

        a.back-link:hover {
            background-color: #2F4156;
            color: white;
        }

        p.no-data {
            text-align: center;
            font-size: 18px;
            margin-top: 40px;
            color: #858585;
        }
    </style>
</head>
<body>

<jsp:include page="navbar.jsp" />

<h2>Purchase History</h2>

<%
    List<BillDTO> bills = (List<BillDTO>) request.getAttribute("bills");
    if (bills != null && !bills.isEmpty()) {
        for (BillDTO bill : bills) {
%>
<div class="bill-container">
    <div class="bill-header"> Bill No: <%= bill.getBillNo() %> | Date: <%= bill.getBillDate() %></div>
    <table>
        <tr>
            <th>Item Name</th>
            <th>Quantity</th>
            <th>Price (Rs.)</th>
            <th>Subtotal (Rs.)</th>
        </tr>
        <%
            List<BillItemDTO> items = bill.getItems();
            if (items != null && !items.isEmpty()) {
                for (BillItemDTO item : items) {
        %>
        <tr>
            <td><%= item.getItemTitle() %></td>
            <td><%= item.getQuantity() %></td>
            <td><%= String.format("%.2f", item.getPrice()) %></td>
            <td><%= String.format("%.2f", item.getSubtotal()) %></td>
        </tr>
        <%
            }
        } else {
        %>
        <tr><td colspan="4">No items found for this bill.</td></tr>
        <%
            }
        %>
    </table>
</div>
<%
    }
} else {
%>
<p class="no-data">No purchase history found.</p>
<%
    }
%>

<a href="customers" class="back-link">← Back to Customers</a>

<jsp:include page="footer.jsp" />

</body>
</html>
