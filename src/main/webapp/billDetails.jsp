<%@ page import="java.sql.*,pahana.edu.persistance.dbconnection.DBConnection" %>
<%@ page import="pahana.edu.persistance.dbconnection.DBConnection" %>
<%
    int billId = Integer.parseInt(request.getParameter("billId"));
    Connection con = DBConnection.getConnection();

    PreparedStatement psBill = con.prepareStatement(
            "SELECT b.bill_no, b.bill_date, b.cashier_name, b.total_amount, b.payment_method, c.account_number, c.customer_name, c.telephone " +
                    "FROM bills b JOIN customers c ON b.customer_id = c.id WHERE b.id = ?");
    psBill.setInt(1, billId);
    ResultSet rsBill = psBill.executeQuery();

    String billNo="", billDate="", cashier="", payment="", accNo="", custName="", tel="";
    double total=0;
    if (rsBill.next()) {
        billNo = rsBill.getString("bill_no");
        billDate = rsBill.getString("bill_date");
        cashier = rsBill.getString("cashier_name");
        payment = rsBill.getString("payment_method");
        accNo = rsBill.getString("account_number");
        custName = rsBill.getString("customer_name");
        tel = rsBill.getString("telephone");
        total = rsBill.getDouble("total_amount");
    }

    PreparedStatement psItems = con.prepareStatement(
            "SELECT i.title, bi.quantity, bi.price, bi.subtotal " +
                    "FROM bill_items bi JOIN items i ON bi.item_id = i.id WHERE bi.bill_id = ?");
    psItems.setInt(1, billId);
    ResultSet rsItems = psItems.executeQuery();
%>
<html>
<head><title>Bill Details</title></head>
<body>
<h2>Bill #<%= billNo %></h2>
<p>Date: <%= billDate %></p>
<p>Cashier: <%= cashier %></p>
<p>Payment Method: <%= payment %></p>

<h3>Customer</h3>
<p>Account No: <%= accNo %></p>
<p>Name: <%= custName %></p>
<p>Telephone: <%= tel %></p>

<h3>Items</h3>
<table border="1" cellpadding="5">
    <tr><th>Title</th><th>Qty</th><th>Price</th><th>Subtotal</th></tr>
    <% while (rsItems.next()) { %>
    <tr>
        <td><%= rsItems.getString("title") %></td>
        <td><%= rsItems.getInt("quantity") %></td>
        <td><%= rsItems.getDouble("price") %></td>
        <td><%= rsItems.getDouble("subtotal") %></td>
    </tr>
    <% } %>
</table>

<h3>Total: Rs. <%= total %></h3>
</body>
</html>
