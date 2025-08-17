<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="pahana.edu.business.user.dto.UserDTO" %>

<%
    UserDTO user = (UserDTO) request.getAttribute("user");
%>

<html>
<head>
    <title>Edit User</title>
    <style>
        .edit-container {
            max-width: 400px;
            margin: 50px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .edit-container h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        .edit-container form {
            display: flex;
            flex-direction: column;
        }
        .edit-container label {
            margin: 10px 0 5px;
        }
        .edit-container input, .edit-container select {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            margin-bottom: 15px;
        }
        .edit-container button {
            background-color: #2F4156;
            color: #fff;
            border: none;
            padding: 10px;
            border-radius: 4px;
            cursor: pointer;
        }
        .edit-container button:hover {
            background-color: #444;
        }
        .edit-container .cancel-btn {
            background-color: #888;
            margin-top: 10px;
        }
        .password-toggle {
            margin-bottom: 15px;
            display: flex;
            align-items: center;
        }
        .password-toggle input[type="checkbox"] {
            margin-left: 5px;
        }
    </style>
    <script>
        function togglePassword() {
            var passwordInput = document.getElementById("password");
            var toggleCheckbox = document.getElementById("showPassword");
            if (toggleCheckbox.checked) {
                passwordInput.type = "text";
            } else {
                passwordInput.type = "password";
            }
        }
    </script>
</head>
<body>
<div class="edit-container">
    <h2>Edit User</h2>
    <form action="manage-users" method="post">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="id" value="<%= user.getId() %>">

        <label for="username">Username:</label>
        <input type="text" name="username" value="<%= user.getUsername() %>" required>

        <label for="email">Email:</label>
        <input type="email" name="email" value="<%= user.getEmail() %>" required>

        <label for="password">Password:</label>
        <input type="password" id="password" name="password" value="<%= user.getPassword() %>" required>

        <div class="password-toggle">
            <input type="checkbox" id="showPassword" onclick="togglePassword()">
            <label for="showPassword">Show Password</label>
        </div>

        <label for="role">Role:</label>
        <select name="role" required>
            <option value="user" <%= "user".equals(user.getRole()) ? "selected" : "" %>>User</option>
            <option value="admin" <%= "admin".equals(user.getRole()) ? "selected" : "" %>>Admin</option>
        </select>

        <button type="submit">Update</button>
        <button type="button" class="cancel-btn" onclick="window.location.href='manage-users'">Cancel</button>
    </form>
</div>
</body>
</html>
