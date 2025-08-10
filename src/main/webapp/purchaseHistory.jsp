<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="pahana.edu.business.billing.dto.BillDTO" %>

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

        table {
            width: 90%;
            border-collapse: collapse;
            margin: 30px auto;
            background-color: white;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            border-radius: 6px;
            overflow: hidden;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 10px;
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
%>
<table>
    <tr>
        <th>Bill No</th>
        <th>Total Amount</th>
        <th>Date</th>
    </tr>
    <%
        for (BillDTO bill : bills) {
    %>
    <tr>
        <td><%= bill.getBillNo() %></td>
        <td>Rs. <%= String.format("%.2f", bill.getTotalAmount()) %></td>
        <td><%= bill.getBillDate() %></td>
    </tr>
    <%
        }
    %>
</table>
<%
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
