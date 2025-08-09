<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="pahana.edu.business.user.dto.UserDTO" %>
<%@ page import="pahana.edu.persistance.Dashboard.DashboardDAO" %>
<%
    UserDTO user = (UserDTO) session.getAttribute("user");
    if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect("login.jsp?error=unauthorized");
        return;
    }

    DashboardDAO dao = new DashboardDAO();
    int totalCustomers = dao.getTotalCustomers();
    int totalItems = dao.getTotalItems();
    int totalUsers = dao.getTotalUsers();
    int totalBills = dao.getTotalBills();
    int todaysCustomers = dao.getTodaysCustomers();
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Lato:wght@300;400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        body {
            font-family: 'Lato', sans-serif;
            background-color: #f4f6f8;
            margin: 0;
            padding: 0;
        }
        .dashboard-content {
            padding: 20px;
        }
        .stats-container {
            display: grid;
            grid-template-columns: repeat(3, 1fr); /* 3 per row */
            gap: 20px;
            margin-top: 30px;
        }
        .stat-box {
            background-color: #fff;
            padding: 20px;
            text-align: center;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            transition: transform 0.2s ease;
        }
        .stat-box:hover {
            transform: translateY(-5px);
        }
        .stat-box i {
            font-size: 40px;
            color: #2F4156;
            margin-bottom: 10px;
        }
        .stat-title {
            font-size: 18px;
            font-weight: 600;
            color: #333;
        }
        .stat-value {
            font-size: 24px;
            font-weight: bold;
            color: #2F4156;
        }
        /* Responsive for smaller screens */
        @media (max-width: 900px) {
            .stats-container {
                grid-template-columns: repeat(2, 1fr);
            }
        }
        @media (max-width: 600px) {
            .stats-container {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>

<jsp:include page="navbar.jsp" />

<section class="dashboard-content">
    <h2>Welcome to the Admin Dashboard</h2>

    <div class="stats-container">
        <div class="stat-box">
            <i class="fas fa-users"></i>
            <div class="stat-title">Total Customers</div>
            <div class="stat-value"><%= totalCustomers %></div>
        </div>
        <div class="stat-box">
            <i class="fas fa-box"></i>
            <div class="stat-title">Total Items</div>
            <div class="stat-value"><%= totalItems %></div>
        </div>
        <div class="stat-box">
            <i class="fas fa-user-cog"></i>
            <div class="stat-title">Total Users</div>
            <div class="stat-value"><%= totalUsers %></div>
        </div>
        <div class="stat-box">
            <i class="fas fa-file-invoice-dollar"></i>
            <div class="stat-title">Total Bills</div>
            <div class="stat-value"><%= totalBills %></div>
        </div>
        <div class="stat-box">
            <i class="fas fa-calendar-day"></i>
            <div class="stat-title">Today's Customers</div>
            <div class="stat-value"><%= todaysCustomers %></div>
        </div>
    </div>
</section>

<jsp:include page="footer.jsp" />
</body>
</html>
