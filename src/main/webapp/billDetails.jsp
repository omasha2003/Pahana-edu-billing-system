<%@ page import="java.sql.*, pahana.edu.persistance.dbconnection.DBConnection" %>
<%@ page buffer="none" %>
<%
    java.io.PrintWriter writer = response.getWriter();

    int billId = 0;
    try {
        billId = Integer.parseInt(request.getParameter("billId"));
    } catch (Exception e) {
        writer.println("Invalid bill ID");
        return;
    }

    Connection con = null;
    PreparedStatement psBill = null;
    PreparedStatement psItems = null;
    ResultSet rsBill = null;
    ResultSet rsItems = null;

    try {
        con = DBConnection.getConnection();

        psBill = con.prepareStatement(
                "SELECT b.bill_no, b.bill_date, b.cashier_name, b.total_amount, b.payment_method, " +
                        "c.account_number, c.customer_name, c.telephone " +
                        "FROM bills b JOIN customers c ON b.customer_id = c.id WHERE b.id = ?");
        psBill.setInt(1, billId);
        rsBill = psBill.executeQuery();

        if (!rsBill.next()) {
            writer.println("Bill not found!");
            return;
        }

        String billNo = rsBill.getString("bill_no");
        Timestamp billDate = rsBill.getTimestamp("bill_date");
        String cashier = rsBill.getString("cashier_name");
        String payment = rsBill.getString("payment_method");
        String accNo = rsBill.getString("account_number");
        String custName = rsBill.getString("customer_name");
        String tel = rsBill.getString("telephone");
        double total = rsBill.getDouble("total_amount");

        psItems = con.prepareStatement(
                "SELECT i.title, bi.quantity, bi.price, bi.subtotal " +
                        "FROM bill_items bi JOIN items i ON bi.item_id = i.id WHERE bi.bill_id = ?");
        psItems.setInt(1, billId);
        rsItems = psItems.executeQuery();
%>

<html>
<head>
    <title>Bill Details</title>
    <style>
        body {
            font-family: "Courier New", monospace;
            background: #f9f9f9;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .bill-container {
            background: #fff;
            color: #000;
            padding: 20px;
            line-height: 1.4;
            box-shadow: 0 0 10px rgba(0,0,0,0.2);
            border-radius: 6px;
            max-width: 350px;
            width: 100%;
        }
        h1 {
            text-align: center;
            font-size: 18px;
            margin: 0;
        }
        p {
            margin: 2px 0;
            font-size: 14px;
        }
        .center { text-align: center; }
        hr {
            border: none;
            border-top: 1px dashed #000;
            margin: 8px 0;
        }
        .items { margin-top: 10px; }
        .item-line {
            display: flex;
            justify-content: space-between;
            font-size: 14px;
            margin-top: 4px;
        }
        .item-title {
            font-weight: bold;
            max-width: 200px;
            word-wrap: break-word;
        }
        .item-sub {
            font-size: 13px;
            color: #555;
            display: flex;
            justify-content: space-between;
        }
        .total-line {
            border-top: 1px dashed #000;
            margin-top: 10px;
            padding-top: 5px;
            font-weight: bold;
            display: flex;
            justify-content: space-between;
            font-size: 15px;
        }
        .footer {
            text-align: center;
            font-size: 12px;
            margin-top: 12px;
            border-top: 1px dashed #000;
            padding-top: 5px;
        }
    </style>
</head>
<body>

<div class="bill-container">
    <h1>Pahana Edu Bookshop</h1>
    <p class="center">Main Road, Colombo</p>
    <p class="center">Contact: +94 11 234 5678</p>
    <hr>

    <p><strong>Bill No:</strong> <%= billNo %></p>
    <p><strong>Date:</strong> <%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(billDate) %></p>
    <p><strong>Time:</strong> <%= new java.text.SimpleDateFormat("HH:mm:ss").format(billDate) %></p>
    <p><strong>Cashier:</strong> <%= cashier %></p>
    <p><strong>Payment:</strong> <%= payment %></p>

    <hr>
    <p><strong>Customer:</strong> <%= custName %></p>
    <p><strong>Account No:</strong> <%= accNo %></p>
    <p><strong>Tel:</strong> <%= tel %></p>
    <hr>

    <div class="items">
        <p class="center"><strong>Items Purchased</strong></p>
        <%
            while (rsItems.next()) {
        %>
        <div class="item-line">
            <span class="item-title"><%= rsItems.getString("title") %></span>
            <span>Rs. <%= String.format("%.2f", rsItems.getDouble("subtotal")) %></span>
        </div>
        <div class="item-sub">
            <span><%= rsItems.getInt("quantity") %> x Rs. <%= String.format("%.2f", rsItems.getDouble("price")) %></span>
        </div>
        <% } %>
    </div>

    <div class="total-line">
        <span>Total</span>
        <span>Rs. <%= String.format("%.2f", total) %></span>
    </div>

    <div class="footer">
        Thank you for shopping with us!<br>
        Please visit again.
    </div>
</div>

</body>
</html>

<%
    } catch (Exception e) {
        writer.println("An error occurred while loading the bill details:<br/>");
        e.printStackTrace(new java.io.PrintWriter(writer));
    } finally {
        if (rsBill != null) try { rsBill.close(); } catch (Exception ignored) {}
        if (rsItems != null) try { rsItems.close(); } catch (Exception ignored) {}
        if (psBill != null) try { psBill.close(); } catch (Exception ignored) {}
        if (psItems != null) try { psItems.close(); } catch (Exception ignored) {}
        if (con != null) try { con.close(); } catch (Exception ignored) {}
    }
%>
