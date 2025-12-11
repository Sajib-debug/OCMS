<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*,jakarta.servlet.http.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student Login | OCMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(135deg, #10b981, #3b82f6);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Georgia', serif;
        }

        .login-card {
            background: #ffffff;
            padding: 35px 30px;
            border-radius: 20px;
            max-width: 400px;
            width: 100%;
            box-shadow: 0 15px 40px rgba(0,0,0,0.2);
            text-align: center;
        }

        .login-card h3 {
            color: #10b981;
            font-weight: 700;
            margin-bottom: 25px;
        }

        .form-control {
            border-radius: 12px;
            padding: 12px;
        }

        .btn-login {
            border-radius: 12px;
            font-weight: 600;
            padding: 10px;
        }

        .register-link, .home-link {
            display: block;
            margin-top: 15px;
            text-decoration: none;
            font-weight: 600;
            transition: 0.3s;
        }

        .register-link {
            color: #3b82f6;
        }
        .register-link:hover {
            text-decoration: underline;
            color: #1e40af;
        }

        .home-link {
            color: #10b981;
        }
        .home-link:hover {
            text-decoration: underline;
            color: #065f46;
        }

        .alert {
            border-radius: 12px;
            font-weight: 600;
        }
    </style>
</head>
<body>

<div class="login-card shadow">
    <h3><i class="bi bi-person-circle me-2"></i>Student Login</h3>

    <form method="post">
        <input type="email" name="email" class="form-control mb-3" placeholder="Email" required>
        <input type="password" name="password" class="form-control mb-3" placeholder="Password" required>
        <button type="submit" class="btn btn-success w-100 btn-login">Login</button>
    </form>

    <a href="student_register.jsp" class="register-link"><i class="bi bi-pencil-square me-1"></i>New student? Register here</a>
    <a href="index.jsp" class="home-link"><i class="bi bi-house-door-fill me-1"></i>Back to Home</a>

    <%
        if(request.getMethod().equalsIgnoreCase("POST")) {
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/OCMS", "root", "SKR@133957"
                );
                PreparedStatement ps = con.prepareStatement(
                    "SELECT * FROM students WHERE email=? AND password=?"
                );
                ps.setString(1, email);
                ps.setString(2, password);
                ResultSet rs = ps.executeQuery();

                if(rs.next()) {
                    session.setAttribute("studentId", rs.getInt("id"));
                    session.setAttribute("studentName", rs.getString("name"));
                    session.setAttribute("studentEmail", rs.getString("email"));
                    response.sendRedirect("student_dashboard.jsp");
                } else {
                    out.println("<div class='alert alert-danger mt-3 text-center'>Invalid email or password</div>");
                }

                con.close();
            } catch(Exception e) {
                out.println("<div class='alert alert-danger mt-3 text-center'>Error: " + e.getMessage() + "</div>");
            }
        }
    %>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
