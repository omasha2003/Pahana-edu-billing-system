<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Pahana Edu - Help & Support</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
            color: #333;
        }

        .container {
            max-width: 1200px;
            margin: auto;
            padding: 30px 20px;
        }

        .logo {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 40px;
            text-align: center;
        }

        .logo img {
            height: 60px;
            margin-right: 15px;
        }

        .main-card {
            background-color: #ffffff;
            border-left: 6px solid #3260ae;
            padding: 25px;
            margin-bottom: 40px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.06);
        }

        .main-card h2 {
            color: #3260ae;
            margin-top: 0;
            text-align: center;
        }

        .card-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: space-between;
        }

        .card {
            flex: 1 1 calc(33.333% - 20px);
            background-color: #ffffff;
            padding: 20px;
            box-shadow: 0 3px 6px rgba(0, 0, 0, 0.08);
            border-left: 4px solid #2F4156;
            min-width: 280px;
        }

        .card h3 {
            color: #2F4156;
            margin-top: 0;
        }

        .card h4 {
            margin-bottom: 5px;
            color: #444;
        }

        ul {
            padding-left: 20px;
            margin-top: 10px;
        }

        ul li {
            margin-bottom: 6px;
        }

        .footer-card {
            background: linear-gradient(135deg, #C8D9E6 0%, #2F4156 100%);
            color: #ffffff;
            margin-top: 40px;
            padding: 30px 20px;
            text-align: center;
        }

        .footer-card .footer-section {
            max-width: 600px;
            margin: 0 auto;
        }

        .footer-section h3 {
            color: #2F4156;
        }

        .footer-section p,
        .footer-section ul li {
            margin-bottom: 8px;
        }

        .footer-section ul {
            padding-left: 18px;
        }

        @media (max-width: 900px) {
            .card {
                flex: 1 1 100%;
            }

            .logo {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
<jsp:include page="navbar.jsp" />
<div class="container">
    <div class="logo">
        <img src="images/logo3.png" alt="Pahana Edu Logo"/>
        <h1>Pahana Edu - Help & Support</h1>
    </div>

    <div class="main-card">
        <h2>Getting Started</h2>
        <ul>
            <li><strong>Login:</strong> Enter your username and password to access the system securely.</li>
            <li><strong>Navigate:</strong> Use the main menu to access features like customer management, item management, or billing.</li>
            <li><strong>Manage:</strong> Add, edit, or delete customer accounts and item information as needed.</li>
            <li><strong>Process:</strong> Generate bills and manage transactions efficiently.</li>
        </ul>
    </div>

    <div class="card-grid">
        <div class="card">
            <h3>User Authentication</h3>
            <h4>How to login:</h4>
            <ul>
                <li>Enter your assigned username</li>
                <li>Enter your secure password</li>
                <li>Click "Login" to access the system</li>
                <li>Contact admin if you forgot your password</li>
            </ul>
            <h4>Security Tips:</h4>
            <ul>
                <li>Always logout when finished</li>
                <li>Don't share your login credentials</li>
                <li>Use a strong, unique password</li>
            </ul>
        </div>

        <div class="card">
            <h3>Customer Management</h3>
            <h4>Adding New Customers:</h4>
            <ul>
                <li>Click "Add New Customer" from the menu</li>
                <li>Fill in account number (unique)</li>
                <li>Enter customer name and address</li>
                <li>Add telephone number</li>
                <li>Save the customer information</li>
            </ul>
            <h4>Editing Customer Info:</h4>
            <ul>
                <li>Search by account number</li>
                <li>Click "Edit" next to customer</li>
                <li>Update info and save changes</li>
            </ul>
        </div>

        <div class="card">
            <h3>Item Management</h3>
            <ul>
                <li>Add books with title, author, price</li>
                <li>Set category and language</li>
                <li>Update quantity and pricing</li>
                <li>Delete discontinued items</li>
                <li>Track inventory levels</li>
            </ul>
            <h4>Search & Filter:</h4>
            <ul>
                <li>Search by title or author</li>
                <li>Filter by category or language</li>
                <li>Sort by price or availability</li>
            </ul>
        </div>

        <div class="card">
            <h3>Account Details</h3>
            <ul>
                <li>Use "Display Account Details"</li>
                <li>Enter account number to view profile</li>
                <li>Check purchase history</li>
                <li>Review account status</li>
            </ul>
            <h4>Search Options:</h4>
            <ul>
                <li>Search by account number</li>
                <li>Search by customer name</li>
                <li>Browse all customers</li>
            </ul>
        </div>

        <div class="card">
            <h3>Billing & Payments</h3>
            <h4>Generating Bills:</h4>
            <ul>
                <li>Select customer account</li>
                <li>Add items to bill</li>
                <li>System calculates total</li>
                <li>Apply discounts if needed</li>
                <li>Print or save bill</li>
            </ul>
            <h4>Payment Processing:</h4>
            <ul>
                <li>Record payment method</li>
                <li>Update account balance</li>
                <li>Generate payment receipt</li>
            </ul>
        </div>

        <div class="card">
            <h3>Quick Tips</h3>
            <ul>
                <li>Always save your work before navigating away</li>
                <li>Use search to quickly find customers or items</li>
                <li>Regular data backups are performed</li>
                <li>Updates are scheduled during off-peak hours</li>
                <li>Report bugs to the support team immediately</li>
            </ul>
        </div>
    </div>

    <div class="footer-card">
        <div class="footer-section">
            <h3>Need Additional Help?</h3>
            <p><strong>Address:</strong><br/>Pahana Edu Bookshop<br/>Main Street, Colombo City<br/>Sri Lanka</p>
            <p><strong>Phone:</strong><br/>+94 11 234 5678<br/>+94 77 123 4567</p>
            <p><strong>Email:</strong><br/>support@pahanaedu.lk<br/>info@pahanaedu.lk</p>
            <p><strong>Support Hours:</strong><br/>Monday - Friday: 9:00 AM - 6:00 PM<br/>Saturday: 9:00 AM - 4:00 PM</p>
        </div>
    </div>
</div>
</body>
</html>
