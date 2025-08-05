<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="pahana.edu.business.user.dto.UserDTO" %>
<html>
<head>
    <title>Manage Users</title>
    <style>
        table {
            width: 80%;
            border-collapse: collapse;
            margin: 20px auto;
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
            padding: 5px 10px;
            margin: 2px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .manage-btn {
            background-color: #9c6f76;
            color: white;
        }

        .delete-btn {
            background-color: #3260ae;
            color: white;
        }

        .add-user-button .add-user-icon {
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

        .add-user-button {
            position: fixed;
            bottom: 50px;
            right: 50px;
            z-index: 999;
            text-align: center;
        }

        .add-user-button .add-user-icon:hover {
            background-color: #858585;
            transform: scale(1.1);
        }

        .add-user-button .add-user-icon p {
            margin: 5px 0 0;
            font-size: 16px;
            color: white;
            line-height: 1;
        }
    </style>
</head>
<body>

<jsp:include page="navbar.jsp" />

<h2 style="text-align:center;">Manage Users</h2>

<table>
    <tr>
        <th>ID</th>
        <th>Username</th>
        <th>Email</th>
        <th>Role</th>
        <th>Actions</th>
    </tr>
    <%
        List<UserDTO> users = (List<UserDTO>) request.getAttribute("users");
        if (users != null) {
            for (UserDTO user : users) {
    %>
    <tr>
        <td><%= user.getId() %></td>
        <td><%= user.getUsername() %></td>
        <td><%= user.getEmail() %></td>
        <td><%= user.getRole() %></td>
        <td>
            <form action="manageUser.jsp" method="get" style="display:inline;">
                <input type="hidden" name="id" value="<%= user.getId() %>">
                <button class="btn manage-btn" type="submit">Manage</button>
            </form>

            <form action="delete-user" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this user?');">
                <input type="hidden" name="id" value="<%= user.getId() %>">
                <button class="btn delete-btn" type="submit">Delete</button>
            </form>
        </td>
    </tr>
    <%
            }
        }
    %>
</table>

<!-- Add New User Floating Button -->
<div class="add-user-button">
    <a href="UserRegister.jsp" class="add-user-icon">
        +
        <p>Add New User</p>
    </a>
</div>

</body>
</html>
