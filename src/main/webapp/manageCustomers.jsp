<%@ page import="java.util.List" %>
<%@ page import="pahana.edu.business.customer.dto.CustomerDTO" %>

<html>
<head><title>Manage Customers</title></head>
<body>
<h2>Customer List</h2>
<a href="addcustomer.jsp">Add New Customer</a>
<table border="1">
    <tr>
        <th>ID</th><th>Account #</th><th>Name</th><th>Address</th><th>Phone</th><th>Units</th><th>Registered</th><th>Created By</th>
    </tr>
    <%
        List<CustomerDTO> customers = (List<CustomerDTO>) request.getAttribute("customers");
        if (customers != null && !customers.isEmpty()) {
            for (CustomerDTO customer : customers) {
    %>
    <tr>
        <td><%= customer.getId() %></td>
        <td><%= customer.getAccountNumber() %></td>
        <td><%= customer.getCustomerName() %></td>
        <td><%= customer.getAddress() %></td>
        <td><%= customer.getTelephone() %></td>
        <td><%= customer.getUnitsConsumed() %></td>
        <td><%= customer.getRegistrationDate() %></td>
        <td><%= customer.getCreatedBy() %></td>
    </tr>
    <%
        }
    } else {
    %>
    <tr><td colspan="8">No customers found.</td></tr>
    <%
        }
    %>
</table>
</body>
</html>
