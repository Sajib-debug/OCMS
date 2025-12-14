<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.*" %>

<%
    if(session.getAttribute("adminEmail") == null) {
        response.sendRedirect("admin_login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin | Manage Teachers</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: #f2f4f7;
            font-family: 'Segoe UI', sans-serif;
        }

        .teacher-card {
            background: #ffffff;
            border-radius: 18px;
            padding: 22px;
            box-shadow: 0 8px 22px rgba(0,0,0,0.08);
            transition: 0.3s;
            height: 100%;
        }

        .teacher-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 14px 30px rgba(0,0,0,0.12);
        }

        .navbar {
            background-color: #1f2937;
        }
        .navbar a, .navbar span {
            color: #f9fafb !important;
            font-weight: 600;
        }

        .btn-danger {
            background-color: #dc2626;
            border: none;
        }
        .btn-danger:hover {
            background-color: #b91c1c;
        }

        .teacher-icon {
            width: 55px;
            height: 55px;
            border-radius: 50%;
            background: #4f46e5;
            color: #ffffff;
            font-weight: bold;
            font-size: 22px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark shadow-sm">
    <div class="container">
        <a class="navbar-brand" href="admin_dashboard.jsp">← Back to Dashboard</a>
        <span class="fw-bold">Admin Panel</span>
        <a href="logout_admin.jsp" class="btn btn-danger ms-3">Logout</a>
    </div>
</nav>

<div class="container mt-4">
    <h3 class="text-center mb-4">All Teachers</h3>

    <div class="row g-4">
    <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/OCMS", "root", "SKR@133957"
            );

            PreparedStatement ps =
                con.prepareStatement("SELECT * FROM teachers ORDER BY id DESC");
            ResultSet rs = ps.executeQuery();

            while(rs.next()) {
                String name = rs.getString("name");
    %>

        <div class="col-md-4 col-lg-3">
            <div class="teacher-card text-center">
                <div class="teacher-icon">
                    <%= name.substring(0,1).toUpperCase() %>
                </div>

                <h5 class="fw-bold mb-1"><%= name %></h5>
                <p class="text-muted mb-3"><%= rs.getString("email") %></p>

                <a href="admin_delete_teacher.jsp?id=<%= rs.getInt("id") %>"
                   class="btn btn-danger btn-sm w-100"
                   onclick="return confirm('Are you sure you want to delete this teacher?');">
                    Delete Teacher
                </a>
            </div>
        </div>

    <%
            }
            con.close();
        } catch(Exception e) {
            out.println("<div class='col-12 text-danger'>Error: " + e.getMessage() + "</div>");
        }
    %>
    </div>
</div>

</body>
</html>
