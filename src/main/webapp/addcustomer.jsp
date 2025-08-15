<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.UUID" %>
<html>
<head>
  <title>Add Customer</title>
  <style>
    body {
      background-color: #f0f2f5;
      font-family: Arial, sans-serif;
    }

    .register-container {
      max-width: 500px;
      margin: 50px auto;
      background-color: #fff;
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
    }

    .register-container h2 {
      font-weight: 600;
      margin-bottom: 25px;
      text-align: center;
      color: #2F4156;
    }

    .register-container form {
      display: flex;
      flex-direction: column;
    }

    .register-container label {
      margin-bottom: 8px;
      font-weight: bold;
    }

    .register-container input {
      padding: 10px;
      margin-bottom: 20px;
      border: 1px solid #ccc;
      border-radius: 5px;
      font-size: 15px;
    }

    .register-container button {
      background-color: #2F4156;
      color: #fff;
      border: none;
      padding: 12px;
      cursor: pointer;
      border-radius: 5px;
      font-size: 16px;
      transition: background-color 0.3s ease;
    }

    .register-container button:hover {
      background-color: #1f2e3a;
    }

    .cancel-btn {
      background-color: #888;
      margin-top: 10px;
    }

    .cancel-btn:hover {
      background-color: #666;
    }

    .error-msg {
      color: red;
      text-align: center;
      margin-bottom: 10px;
    }
  </style>
</head>
<body>

<%
  String generatedAccountNumber = "ACC-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
  String error = request.getParameter("error");
%>

<div class="register-container">
  <h2>Add Customer</h2>

  <% if (error != null) { %>
  <div class="error-msg"><%= error %></div>
  <% } %>

  <form action="customer" method="post">
    <input type="hidden" name="action" value="add">

    <label for="accountNumber">Account Number:</label>
    <input type="text" id="accountNumber" name="accountNumber" value="<%= generatedAccountNumber %>" readonly required>

    <label for="customerName">Customer Name:</label>
    <input type="text" id="customerName" name="customerName" required>

    <label for="address">Address:</label>
    <input type="text" id="address" name="address" required>

    <label for="telephone">Telephone:</label>
    <input type="text" id="telephone" name="telephone" required>

    <label for="unitsConsumed">Units Consumed:</label>
    <input type="number" id="unitsConsumed" name="unitsConsumed" min="0" value="0">

    <label for="createdBy">Created By:</label>
    <input type="text" id="createdBy" name="createdBy" required>

    <button type="submit">Add Customer</button>
    <button type="button" class="cancel-btn" onclick="window.location.href='manageCustomers.jsp'">Cancel</button>
  </form>
</div>

</body>
</html>