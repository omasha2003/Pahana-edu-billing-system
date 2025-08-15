<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="pahana.edu.business.customer.dto.CustomerDTO" %>
<%
  CustomerDTO customer = (CustomerDTO) request.getAttribute("customer");
  if (customer == null) {
    response.sendRedirect("customers");
    return;
  }
%>
<html>
<head>
  <title>Edit Customer</title>
  <style>
    body {
      background-color: #f0f2f5;
      font-family: Arial, sans-serif;
    }

    .edit-container {
      max-width: 500px;
      margin: 50px auto;
      background-color: #fff;
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
    }

    .edit-container h2 {
      font-weight: 600;
      margin-bottom: 25px;
      text-align: center;
      color: #2F4156;
    }

    .edit-container form {
      display: flex;
      flex-direction: column;
    }

    .edit-container label {
      margin-bottom: 8px;
      font-weight: bold;
    }

    .edit-container input {
      padding: 10px;
      margin-bottom: 20px;
      border: 1px solid #ccc;
      border-radius: 5px;
      font-size: 15px;
    }

    .edit-container button {
      background-color: #2F4156;
      color: #fff;
      border: none;
      padding: 12px;
      cursor: pointer;
      border-radius: 5px;
      font-size: 16px;
      transition: background-color 0.3s ease;
    }

    .edit-container button:hover {
      background-color: #1f2e3a;
    }

    .cancel-btn {
      background-color: #888;
      margin-top: 10px;
    }

    .cancel-btn:hover {
      background-color: #666;
    }
  </style>
</head>
<body>
<div class="edit-container">
  <h2>Edit Customer</h2>

  <form action="customers" method="post">
    <input type="hidden" name="action" value="update" />
    <input type="hidden" name="id" value="<%= customer.getId() %>" />

    <label for="accountNumber">Account Number:</label>
    <input type="text" id="accountNumber" name="accountNumber" value="<%= customer.getAccountNumber() %>" readonly required />

    <label for="customerName">Customer Name:</label>
    <input type="text" id="customerName" name="customerName" value="<%= customer.getCustomerName() %>" required />

    <label for="address">Address:</label>
    <input type="text" id="address" name="address" value="<%= customer.getAddress() %>" required />

    <label for="telephone">Telephone:</label>
    <input type="text" id="telephone" name="telephone" value="<%= customer.getTelephone() %>" required />

    <label for="unitsConsumed">Units Consumed:</label>
    <input type="number" id="unitsConsumed" name="unitsConsumed" min="0" value="<%= customer.getUnitsConsumed() %>" />

    <button type="submit">Update Customer</button>
    <button type="button" class="cancel-btn" onclick="window.location.href='customers'">Cancel</button>
  </form>
</div>
</body>
</html>
