<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="pahana.edu.business.user.dto.UserDTO" %>
<%
    UserDTO user = (UserDTO) session.getAttribute("user");
    if (user == null || !"user".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect("login.jsp?error=unauthorized");
        return;
    }

%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Lato:wght@100;300;400;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        body {
            margin: 0;
            font-family: "Lato", sans-serif;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .navbar {
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #2F4156;
            height: 150px;
            width: 100%;
        }

        .navbar-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 100%;
            padding: 0 30px;
        }

        .admin-portal {
            text-align: left;
            padding-left: 30px;
            flex: 1;
            font-size: 33px;
            font-family: "Museo Sans Rounded", sans-serif;
            font-weight: 400;
            color: #fffcda;
        }

        .logo {
            height: 100px;
            width: auto;
        }

        .user-profile {
            display: flex;
            align-items: center;
            margin-right: 20px;
        }

        .user-profile img {
            height: 50px;
            width: 50px;
            border-radius: 50%;
            object-fit: cover;
            margin-right: 10px;
        }

        .username {
            font-size: 18px;
            margin-right: 20px;
            color: #fffcda;
        }

        .secondary-navbar {
            display: flex;
            justify-content: center;
            align-items: center;
            background: linear-gradient(135deg, #C8D9E6 0%, #2F4156 100%);
            height: 50px;
            width: 100%;
        }

        .secondary-nav-links {
            list-style: none;
            padding: 0;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .secondary-nav-links li {
            display: inline;
        }

        .secondary-nav-links a {
            color: #fffcda;
            text-decoration: none;
            font-size: 18px;
            padding: 5px 10px;
            font-family: "Museo Sans Rounded", sans-serif;
            font-weight: 400;
            letter-spacing: 1px;
            border-radius: 5px;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .secondary-nav-links a:hover {
            background-color: #2F4156;
            color: #fffcda;
        }

        .logout a {
            color: #F5EFEB;
            font-size: 16px;
            text-decoration: none;
        }

        .logout a:hover {
            color: #fffcda;
            text-decoration: underline;
        }

        .dashboard-content {
            align-content: center;
            padding: 20px;
            font-family: "Lato", sans-serif;
        }
    </style>
</head>

<body>
<section>
    <nav class="navbar">
        <div class="navbar-content">
            <a href="userDashboard.jsp">
                <img src="images/logo3.png" alt="Logo" class="logo">
            </a>
            <div class="admin-portal">USER DASHBOARD</div>
            <div class="user-profile">
                <div class="username"><%= user.getUsername() %></div>
                <div class="logout"><a href="logout.jsp">Logout</a></div>
            </div>
        </div>
    </nav>

    <nav class="secondary-navbar">
        <ul class="secondary-nav-links">
            <li><a href="userDashboard.jsp">Dashboard</a></li>
            <li><a href="manageCustomers.jsp">Manage Customers</a></li>
            <li><a href="items">Manage Items</a></li>
            <li><a href="billing.jsp">Billing</a></li>
            <li><a href="help.jsp">Help & Support</a></li>
        </ul>
    </nav>
</section>

<section class="dashboard-content">
    <h2>Welcome to the User Dashboard</h2>

</section>
</body>

</html>
