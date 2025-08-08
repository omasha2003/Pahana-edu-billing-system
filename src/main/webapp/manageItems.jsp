<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="pahana.edu.business.item.dto.ItemDTO" %>

<html>
<head>
    <title>Manage Items</title>
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

        .add-item-button .add-item-icon {
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
            box-shadow: 2px 3px 4px rgba(0, 0, 0, 0.3), 4px 7px 15px rgba(0, 0, 0, 0.3), 9px 15px 25px rgba(0, 0, 0, 0.2);
            transition: transform 0.2s ease-in-out;
        }

        .add-item-button {
            position: fixed;
            bottom: 50px;
            right: 50px;
            z-index: 999;
            text-align: center;
        }

        .add-item-button .add-item-icon:hover {
            background-color: #858585;
            transform: scale(1.1);
        }

        .add-item-button .add-item-icon p {
            margin: 5px 0 0;
            font-size: 16px;
            color: white;
            line-height: 1;
        }
    </style>
</head>
<body>

<jsp:include page="navbar.jsp" />

<h2>Items List</h2>


<div class="search-container">
    <form method="get" action="items">
        <input type="text" name="search" placeholder="Search by title or author" value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>"/>
        <button type="submit">Search</button>
    </form>
</div>


<table>
    <tr>
        <th>ID</th>
        <th>Title</th>
        <th>Author</th>
        <th>Price</th>
        <th>Qty</th>
        <th>Category</th>
        <th>Language</th>
        <th>Added By</th>
        <th>Added Date</th>
        <th>Action</th>
    </tr>
    <%
        List<ItemDTO> items = (List<ItemDTO>) request.getAttribute("items");
        if (items != null && !items.isEmpty()) {
            for (ItemDTO item : items) {
    %>
    <tr>
        <td><%= item.getId() %></td>
        <td><%= item.getTitle() %></td>
        <td><%= item.getAuthor() %></td>
        <td><%= item.getPrice() %></td>
        <td><%= item.getQuantity() %></td>
        <td><%= item.getCategory() %></td>
        <td><%= item.getLanguage() %></td>
        <td><%= item.getAddedBy() %></td>
        <td><%= item.getAddedDate() %></td>
        <td>
            <form action="manageItems.jsp" method="get" style="display:inline;">
                <input type="hidden" name="action" value="edit">
                <input type="hidden" name="id" value="<%= item.getId() %>">
                <button class="btn edit-btn">Edit</button>
            </form>
            <form action="items" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this item?');">
                <input type="hidden" name="action" value="delete">
                <input type="hidden" name="id" value="<%= item.getId() %>">
                <button class="btn delete-btn">Delete</button>
            </form>
        </td>
    </tr>
    <%
        }
    } else {
    %>
    <tr>
        <td colspan="10">No items found.</td>
    </tr>
    <%
        }
    %>
</table>

<div class="add-item-button">
    <a href="addNewItems.jsp" class="add-item-icon">
        +
        <p>Add New Item</p>
    </a>
</div>
</body>
</html>
