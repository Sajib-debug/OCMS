<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Teacher Registration | OCMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(135deg, #f59e0b, #ef4444);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Georgia', serif;
        }

        .register-card {
            background: #ffffff;
            padding: 35px 30px;
            border-radius: 20px;
            max-width: 450px;
            width: 100%;
            box-shadow: 0 15px 40px rgba(0,0,0,0.2);
            text-align: center;
        }

        .register-card h3 {
            color: #ef4444;
            font-weight: 700;
            margin-bottom: 25px;
        }

        .form-control {
            border-radius: 12px;
            padding: 12px;
        }

        .btn-register {
            border-radius: 12px;
            font-weight: 600;
            padding: 10px;
        }

        .login-link, .home-link {
            display: block;
            margin-top: 15px;
            text-decoration: none;
            font-weight: 600;
            transition: 0.3s;
        }

        .login-link {
            color: #10b981;
        }
        .login-link:hover {
            text-decoration: underline;
            color: #065f46;
        }

        .home-link {
            color: #3b82f6;
        }
        .home-link:hover {
            text-decoration: underline;
            color: #1e40af;
        }

        .alert {
            border-radius: 12px;
            font-weight: 600;
        }
    </style>
</head>
<body>

<div class="register-card shadow">
    <h3><i class="bi bi-pencil-square me-2"></i>Teacher Registration</h3>

    <%
        String msg = "";
        if(request.getMethod().equalsIgnoreCase("POST")){
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            try{
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/OCMS","root","SKR@133957"
                );

                PreparedStatement check = con.prepareStatement(
                    "SELECT * FROM teachers WHERE email=?"
                );
                check.setString(1,email);
                ResultSet rs = check.executeQuery();
                if(rs.next()){
                    msg = "Email already registered!";
                } else {
                    PreparedStatement ps = con.prepareStatement(
                        "INSERT INTO teachers(name,email,password) VALUES(?,?,?)"
                    );
                    ps.setString(1,name);
                    ps.setString(2,email);
                    ps.setString(3,password);
                    ps.executeUpdate();
                    msg = "Registration successful! <a href='teacher_login.jsp'>Login here</a>";
                }

                con.close();
            }catch(Exception e){
                msg = "Error: "+e.getMessage();
            }
        }
    %>

    <% if(!msg.isEmpty()){ %>
        <div class="alert alert-info mt-3 text-center"><%= msg %></div>
    <% } %>

    <form method="post">
        <input type="text" name="name" class="form-control mb-3" placeholder="Full Name" required>
        <input type="email" name="email" class="form-control mb-3" placeholder="Email" required>
        <input type="password" name="password" class="form-control mb-3" placeholder="Password" required>
        <button class="btn btn-danger w-100 btn-register">Register</button>
    </form>

    <a href="teacher_login.jsp" class="login-link"><i class="bi bi-box-arrow-in-right me-1"></i>Already have an account? Login</a>
    <a href="index.jsp" class="home-link"><i class="bi bi-house-door-fill me-1"></i>Back to Home</a>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
