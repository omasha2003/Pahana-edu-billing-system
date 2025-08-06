<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User Registration</title>
    <style>
        .register-container {
            max-width: 400px;
            margin: 50px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .register-container h2 {
            font-weight: 600;
            margin-bottom: 20px;
            text-align: center;
        }

        .register-container form {
            display: flex;
            flex-direction: column;
        }

        .register-container label {
            margin-bottom: 10px;
            display: block;
        }

        .register-container input {
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 3px;
            font-size: 16px;
        }

        .register-container select {
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 3px;
            font-size: 16px;
            width: 100%;
        }

        .register-container button {
            background-color: #2F4156;
            color: #fff;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 3px;
            font-size: 16px;
            margin-top: 15px;
        }

        .register-container button:hover {
            background-color: #555;
        }

        .register-container .cancel-btn {
            background-color: #888;
            margin-top: 10px;
        }

        .register-container .cancel-btn:hover {
            background-color: #666;
        }

        .register-container p {
            text-align: center;
            margin-top: 10px;
        }

        .register-container p a {
            color: #2F4156;
            text-decoration: none;
        }

        .register-container p a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="register-container">
    <h2>User Registration</h2>

    <form action="register-user" method="post">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required>

        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required>

        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required>

        <label for="role">Role:</label>
        <select id="role" name="role" required>
            <option value="user">User</option>
            <option value="admin">Admin</option>
        </select>

        <button type="submit">Register</button>
        <button type="button" class="cancel-btn" onclick="window.location.href='manage-users'">Cancel</button>
    </form>
</div>

</body>
</html>
