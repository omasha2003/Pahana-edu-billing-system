<!DOCTYPE html>
<html>
<head>
    <title>Login - Pahana Edu</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="login-box">
    <h2>Login</h2>
    <form method="post" action="LoginServlet">
        <input type="email" name="email" placeholder="Email" required />
        <input type="password" name="password" placeholder="Password" required />
        <button type="submit">Login</button>
        <div class="error">${error}</div>
    </form>
</div>
</body>
</html>
