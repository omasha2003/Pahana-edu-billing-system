<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%
    HttpSession sessionObj = request.getSession(false);
    String loggedUser = "unknown";

    if (sessionObj != null && sessionObj.getAttribute("username") != null) {
        loggedUser = (String) sessionObj.getAttribute("username");
    }
%>
<html>
<head>
    <title>Add New Item</title>
    <style>
        .item-container {
            max-width: 450px;
            margin: 50px auto;
            background-color: #fff;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .item-container h2 {
            font-weight: 600;
            margin-bottom: 20px;
            text-align: center;
        }

        .item-container form {
            display: flex;
            flex-direction: column;
        }

        .item-container label {
            margin-bottom: 10px;
        }

        .item-container input,
        .item-container select {
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 3px;
            font-size: 16px;
        }

        .item-container input[readonly] {
            background-color: #f5f5f5;
        }

        .item-container button {
            background-color: #2F4156;
            color: #fff;
            border: none;
            padding: 10px;
            cursor: pointer;
            border-radius: 3px;
            font-size: 16px;
        }

        .item-container button:hover {
            background-color: #555;
        }

        .item-container .cancel-btn {
            background-color: #888;
            margin-top: 10px;
        }

        .item-container .cancel-btn:hover {
            background-color: #666;
        }
    </style>
</head>
<body>

<div class="item-container">
    <h2>Add New Book Item</h2>

    <form action="items" method="post">
        <label for="title">Title:</label>
        <input type="text" name="title" id="title" required>

        <label for="author">Author:</label>
        <input type="text" name="author" id="author">

        <label for="price">Price:</label>
        <input type="number" step="0.01" name="price" id="price" required>

        <label for="quantity">Quantity:</label>
        <input type="number" name="quantity" id="quantity" required>

        <label for="category">Category:</label>
        <select name="category" id="category" required>
            <option value="Fiction">Fiction</option>
            <option value="Science">Science</option>
            <option value="Children">Children</option>
            <option value="Exam Guides">Exam Guides</option>
            <option value="Maths">Maths</option>
            <option value="Fantasy">Fantasy</option>
            <option value="Education">Education</option>
            <option value="Finance">Finance</option>
        </select>

        <label for="language">Language:</label>
        <select name="language" id="language" required>
            <option value="Sinhala">Sinhala</option>
            <option value="English">English</option>
            <option value="Tamil">Tamil</option>
        </select>

        <label for="addedBy">Added By:</label>
        <input type="text" name="addedBy" id="addedBy" value="<%= loggedUser %>" readonly>

        <button type="submit">Add Item</button>
        <button type="button" class="cancel-btn" onclick="window.location.href='items'">Cancel</button>
    </form>
</div>

</body>
</html>
