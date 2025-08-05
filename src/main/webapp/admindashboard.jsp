<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="pahana.edu.business.user.dto.UserDTO" %>
<%
    UserDTO user = (UserDTO) session.getAttribute("user");
    if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect("login.jsp?error=unauthorized");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Admin Dashboard</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f4f4f4; padding: 20px; }
        header { background: #333; color: white; padding: 10px; }
        main { margin-top: 20px; }
        a.logout { float: right; color: #fff; text-decoration: none; }
    </style>
</head>
<body>
<header>
    <h1>Welcome, <%= user.getUsername() %> (Admin)</h1>
    <a href="logout.jsp" class="logout">Logout</a>
</header>
<main>
    <h2>Admin Functions</h2>
    <ul>
        <li><a href="#">Manage Users</a></li>
        <li><a href="#">View Reports</a></li>
        <li><a href="#">System Settings</a></li>
    </ul>
</main>
</body>
</html>
