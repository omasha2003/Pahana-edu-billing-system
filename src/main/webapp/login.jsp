<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pahana Edu Bookshop - Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .login-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .login-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            max-width: 900px;
            width: 100%;
        }
        .brand-section {
            background: linear-gradient(135deg, #4e54c8 0%, #8f94fb 100%);
            color: white;
            padding: 4rem 2rem;
            text-align: center;
        }
        .brand-icon {
            font-size: 4rem;
            margin-bottom: 1rem;
            opacity: 0.9;
        }
        .form-section {
            padding: 4rem 3rem;
        }
        .form-control {
            border-radius: 10px;
            border: 2px solid #e1e5e9;
            padding: 12px 15px;
            transition: all 0.3s ease;
        }
        .form-control:focus {
            border-color: #4e54c8;
            box-shadow: 0 0 0 0.2rem rgba(78, 84, 200, 0.25);
        }
        .btn-login {
            background: linear-gradient(135deg, #4e54c8 0%, #8f94fb 100%);
            border: none;
            border-radius: 10px;
            padding: 12px 30px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.3s ease;
        }
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(78, 84, 200, 0.3);
        }
        .input-group-text {
            background: #f8f9fa;
            border: 2px solid #e1e5e9;
            border-right: none;
            border-radius: 10px 0 0 10px;
        }
        .toggle-password {
            background: #f8f9fa;
            border: 2px solid #e1e5e9;
            border-left: none;
            border-radius: 0 10px 10px 0;
        }
    </style>
</head>
<body>
<div class="login-container">
    <div class="login-card">
        <div class="row g-0">
            <!-- Brand Section -->
            <div class="col-md-5 brand-section">
                <div class="h-100 d-flex flex-column justify-content-center">
                    <i class="fas fa-book-open brand-icon"></i>
                    <h1 class="mb-3 fw-bold">Pahana Edu</h1>
                    <h3 class="mb-4">Bookshop</h3>
                    <p class="lead opacity-75">Your Premier Book Management System</p>
                    <div class="mt-4">
                        <i class="fas fa-users me-3"></i>
                        <i class="fas fa-chart-line me-3"></i>
                        <i class="fas fa-cogs"></i>
                    </div>
                </div>
            </div>

            <!-- Form Section -->
            <div class="col-md-7 form-section">
                <div class="text-center mb-4">
                    <h2 class="fw-bold text-dark">Welcome Back!</h2>
                    <p class="text-muted">Please sign in to your account</p>

                    <%-- Error Message Display --%>
                    <%
                        String error = request.getParameter("error");
                        if ("invalid".equals(error)) {
                    %>
                    <div class="alert alert-danger mt-3" role="alert">
                        Invalid username or password. Please try again.
                    </div>
                    <%
                    } else if ("role".equals(error)) {
                    %>
                    <div class="alert alert-warning mt-3" role="alert">
                        Unrecognized user role. Please contact the administrator.
                    </div>
                    <%
                        }
                    %>
                </div>

                <form action="login" method="post" id="loginForm">
                    <div class="mb-3">
                        <label for="username" class="form-label fw-semibold">Username</label>
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="fas fa-user text-muted"></i>
                            </span>
                            <input type="text" class="form-control" id="username" name="username"
                                   required placeholder="Enter your username"
                                   value="<%= request.getParameter("username") != null ? request.getParameter("username") : "" %>">
                        </div>
                    </div>

                    <div class="mb-4">
                        <label for="password" class="form-label fw-semibold">Password</label>
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="fas fa-lock text-muted"></i>
                            </span>
                            <input type="password" class="form-control" id="password" name="password"
                                   required placeholder="Enter your password">
                            <button class="btn toggle-password" type="button" id="togglePassword">
                                <i class="fas fa-eye text-muted"></i>
                            </button>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-primary btn-login w-100 mb-3">
                        <i class="fas fa-sign-in-alt me-2"></i>Sign In
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Toggle password visibility
    document.getElementById('togglePassword').addEventListener('click', function () {
        const password = document.getElementById('password');
        const icon = this.querySelector('i');

        if (password.type === 'password') {
            password.type = 'text';
            icon.classList.remove('fa-eye');
            icon.classList.add('fa-eye-slash');
        } else {
            password.type = 'password';
            icon.classList.remove('fa-eye-slash');
            icon.classList.add('fa-eye');
        }
    });

    // Form validation and loading state
    document.getElementById('loginForm').addEventListener('submit', function (e) {
        const username = document.getElementById('username').value.trim();
        const password = document.getElementById('password').value;
        const submitBtn = this.querySelector('button[type="submit"]');

        if (!username || !password) {
            e.preventDefault();
            alert('Please enter both username and password');
            return;
        }

        // Show loading state
        submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Signing In...';
        submitBtn.disabled = true;
    });
</script>
</body>
</html>
