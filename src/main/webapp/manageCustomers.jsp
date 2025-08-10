<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="pahana.edu.business.customer.dto.CustomerDTO" %>

<html>
<head>
    <title>Manage Customers</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f6f8;
        }

        h2 {
            text-align: center;
            margin-top: 30px;
        }

        .search-container {
            text-align: center;
            margin: 20px;
        }

        .search-container input[type="text"] {
            padding: 10px;
            width: 300px;
            border-radius: 4px;
            border: 1px solid #ccc;
            font-size: 16px;
        }

        .search-container button {
            padding: 10px 16px;
            background-color: #2F4156;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            margin-left: 8px;
        }

        table {
            width: 90%;
            border-collapse: collapse;
            margin: 30px auto;
            background-color: white;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }

        th {
            background-color: #f2f2f2;
        }

        tr.clickable-row {
            cursor: pointer;
        }

        tr.clickable-row:hover {
            background-color: #f0f0f0;
        }

        .btn {
            padding: 6px 12px;
            margin: 2px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
        }

        .edit-btn {
            background-color: #9c6f76;
            color: white;
        }

        .delete-btn {
            background-color: #3260ae;
            color: white;
        }

        .add-customer-button .add-customer-icon {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            width: 95px;
            height: 95px;
            border-radius: 50%;
            background-color: #2F4156;
            color: #fff;
            border: none;
            cursor: pointer;
            text-decoration: none;
            box-shadow: 2px 3px 4px rgba(0, 0, 0, 0.3),
            4px 7px 15px rgba(0, 0, 0, 0.3),
            9px 15px 25px rgba(0, 0, 0, 0.2);
            transition: transform 0.2s ease-in-out;
        }

        .add-customer-button {
            position: fixed;
            bottom: 50px;
            right: 50px;
            z-index: 999;
            text-align: center;
        }

        .add-customer-button .add-customer-icon:hover {
            background-color: #858585;
            transform: scale(1.1);
        }

        .add-customer-button .add-customer-icon p {
            margin: 5px 0 0;
            font-size: 16px;
            color: white;
            line-height: 1;
        }
    </style>
</head>
<body>

<jsp:include page="navbar.jsp" />

<h2>Customers List</h2>

<div class="search-container">
    <form method="get" action="customers">
        <input type="text" name="search" placeholder="Search by account or name" value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>" />
        <button type="submit">Search</button>
    </form>
</div>

<table>
    <tr>
        <th>ID</th>
        <th>Account #</th>
        <th>Name</th>
        <th>Address</th>
        <th>Phone</th>
        <th>Units</th>
        <th>Registered</th>
        <th>Created By</th>
        <th>Action</th>
    </tr>
    <%
        List<CustomerDTO> customers = (List<CustomerDTO>) request.getAttribute("customers");
        if (customers != null && !customers.isEmpty()) {
            for (CustomerDTO customer : customers) {
    %>
    <tr class="clickable-row" data-id="<%= customer.getId() %>">
        <td><%= customer.getId() %></td>
        <td><%= customer.getAccountNumber() %></td>
        <td><%= customer.getCustomerName() %></td>
        <td><%= customer.getAddress() %></td>
        <td><%= customer.getTelephone() %></td>
        <td><%= customer.getUnitsConsumed() %></td>
        <td><%= customer.getRegistrationDate() %></td>
        <td><%= customer.getCreatedBy() %></td>
        <td>
            <form action="customers" method="post" style="display:inline;" onclick="event.stopPropagation();">
                <input type="hidden" name="action" value="edit" />
                <input type="hidden" name="id" value="<%= customer.getId() %>" />
                <button class="btn edit-btn" type="submit">Edit</button>
            </form>
            <form action="customers" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this customer?');" onclick="event.stopPropagation();">
                <input type="hidden" name="action" value="delete" />
                <input type="hidden" name="id" value="<%= customer.getId() %>" />
                <button class="btn delete-btn" type="submit">Delete</button>
            </form>
        </td>
    </tr>
    <%
        }
    } else {
    %>
    <tr>
        <td colspan="9">No customers found.</td>
    </tr>
    <%
        }
    %>
</table>

<div class="add-customer-button">
    <a href="addcustomer.jsp" class="add-customer-icon">
        +
        <p>Add New Customer</p>
    </a>
</div>

<script>
    document.querySelectorAll(".clickable-row").forEach(row => {
        row.addEventListener("click", () => {
            const customerId = row.getAttribute("data-id");
            window.location.href = "purchaseHistory?customerId=" + customerId;
        });
    });
</script>

<jsp:include page="footer.jsp" />
</body>
</html>
