<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="pahana.edu.business.item.dto.ItemDTO" %>

<%
    ItemDTO item = (ItemDTO) request.getAttribute("item");
    if (item == null) {
        response.sendRedirect("items");
        return;
    }
%>

<html>
<head>
    <title>Edit Item</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f6f8;
            align-items: center;
            padding: 20px;
        }
        .form-container {
            max-width: 450px;
            margin: 50px auto;
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 0 10px #ccc;
        }
        label {
            display: block;
            margin-top: 10px;
            font-weight: bold;
        }
        input, select {
            width: 100%;
            padding: 8px;
            margin-top: 4px;
            border-radius: 4px;
            border: 1px solid #ccc;
        }
        button {
            margin-top: 20px;
            background-color: #2F4156;
            color: white;
            border: none;
            padding: 10px;
            cursor: pointer;
            border-radius: 4px;
            width: 100%;
            font-size: 16px;
        }
        button:hover {
            background-color: #555;
        }
    </style>
</head>
<body>

<div class="form-container">
    <h2>Edit Item</h2>
    <form action="items" method="post">
        <input type="hidden" name="action" value="update" />
        <input type="hidden" name="id" value="<%= item.getId() %>" />

        <label for="title">Title:</label>
        <input type="text" id="title" name="title" value="<%= item.getTitle() %>" required />

        <label for="author">Author:</label>
        <input type="text" id="author" name="author" value="<%= item.getAuthor() %>" />

        <label for="price">Price:</label>
        <input type="number" id="price" name="price" step="0.01" value="<%= item.getPrice() %>" required />

        <label for="quantity">Quantity:</label>
        <input type="number" id="quantity" name="quantity" value="<%= item.getQuantity() %>" required />

        <label for="category">Category:</label>
        <select id="category" name="category" required>
            <option value="Fiction" <%= "Fiction".equals(item.getCategory()) ? "selected" : "" %>>Fiction</option>
            <option value="Science" <%= "Science".equals(item.getCategory()) ? "selected" : "" %>>Science</option>
            <option value="Children" <%= "Children".equals(item.getCategory()) ? "selected" : "" %>>Children</option>
            <option value="Exam Guides" <%= "Exam Guides".equals(item.getCategory()) ? "selected" : "" %>>Exam Guides</option>
            <option value="Maths" <%= "Maths".equals(item.getCategory()) ? "selected" : "" %>>Maths</option>
            <option value="Fantasy" <%= "Fantasy".equals(item.getCategory()) ? "selected" : "" %>>Fantasy</option>
            <option value="Education" <%= "Education".equals(item.getCategory()) ? "selected" : "" %>>Education</option>
            <option value="Finance" <%= "Finance".equals(item.getCategory()) ? "selected" : "" %>>Finance</option>
        </select>

        <label for="language">Language:</label>
        <select id="language" name="language" required>
            <option value="Sinhala" <%= "Sinhala".equals(item.getLanguage()) ? "selected" : "" %>>Sinhala</option>
            <option value="English" <%= "English".equals(item.getLanguage()) ? "selected" : "" %>>English</option>
            <option value="Tamil" <%= "Tamil".equals(item.getLanguage()) ? "selected" : "" %>>Tamil</option>
        </select>

        <button type="submit">Update Item</button>
    </form>
</div>

</body>
</html>
