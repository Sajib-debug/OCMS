<%@ page contentType="text/html;charset=UTF-8" %>

<%
    String msg = "";
    if (request.getMethod().equalsIgnoreCase("POST")) {

        String email = request.getParameter("email");
        String pass = request.getParameter("password");

        if ((email.equals("sajib@gmail.com") && pass.equals("sajib")) ||
            (email.equals("rokun@gmail.com") && pass.equals("rokun"))) {

            session.setAttribute("adminEmail", email);

            String name = email.equals("sajib@gmail.com") ? "Sajib" : "Rokun";
            session.setAttribute("adminName", name);

            response.sendRedirect("admin_dashboard.jsp");
            return;
        } else {
            msg = "❌ Invalid Email or Password!";
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Login | OCMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(135deg, #4f46e5, #6366f1);
            font-family: 'Georgia', serif;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            color: #1f2937;
        }

        .login-box {
            width: 400px;
            background: #ffffff;
            padding: 35px 30px;
            border-radius: 20px;
            box-shadow: 0 15px 40px rgba(0,0,0,0.2);
            text-align: center;
        }

        .login-box h3 {
            font-weight: 700;
            margin-bottom: 25px;
            color: #4f46e5;
        }

        .form-control {
            border-radius: 12px;
            padding: 12px;
        }

        .btn-login {
            border-radius: 12px;
            padding: 10px;
            font-weight: 600;
        }

        .back-index {
            display: block;
            margin-top: 20px;
            text-decoration: none;
            font-weight: 600;
            color: #6366f1;
            transition: 0.3s;
        }
        .back-index:hover {
            text-decoration: underline;
            color: #4f46e5;
        }

        .alert {
            border-radius: 12px;
            font-weight: 600;
        }
    </style>
</head>
<body>

<div class="login-box shadow">
    <h3><i class="bi bi-shield-lock-fill me-2"></i>Admin Login</h3>

    <% if (!msg.equals("")) { %>
        <div class="alert alert-danger"><%= msg %></div>
    <% } %>

    <form method="post">
        <div class="mb-3 text-start">
            <label class="fw-semibold">Email</label>
            <input type="email" name="email" class="form-control" placeholder="Enter your email" required>
        </div>

        <div class="mb-3 text-start">
            <label class="fw-semibold">Password</label>
            <input type="password" name="password" class="form-control" placeholder="Enter your password" required>
        </div>

        <button type="submit" class="btn btn-primary w-100 btn-login mt-2">Login</button>
    </form>

    <a href="index.jsp" class="back-index"><i class="bi bi-house-fill me-1"></i>Back to Home</a>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
