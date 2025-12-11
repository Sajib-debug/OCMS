<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.*" %>

<%
    // Admin session check
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
            background-color: #f2f4f7;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .card-box {
            background: #ffffff;
            border-radius: 18px;
            padding: 30px;
            margin-bottom: 25px;
            transition: all 0.3s ease;
        }
        .card-box:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 28px rgba(0,0,0,0.12);
        }
        .table thead {
            background-color: #343a40;
            color: #fff;
        }
        .table tbody tr:hover {
            background-color: #e9ecef;
        }
        .btn-danger {
            background-color: #dc2626;
            border: none;
        }
        .btn-danger:hover {
            background-color: #b91c1c;
        }
        .navbar {
            background-color: #1f2937;
        }
        .navbar a, .navbar span {
            color: #f9fafb !important;
            font-weight: 600;
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
    <div class="card-box shadow-sm">
        <h3 class="mb-4 text-center">All Teachers</h3>

        <table class="table table-bordered table-hover">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
            <%
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/OCMS", "root", "SKR@133957"
                    );
                    PreparedStatement ps = con.prepareStatement("SELECT * FROM teachers ORDER BY id DESC");
                    ResultSet rs = ps.executeQuery();

                    while(rs.next()) {
            %>
                <tr>
                    <td><%= rs.getInt("id") %></td>
                    <td><%= rs.getString("name") %></td>
                    <td><%= rs.getString("email") %></td>
                    <td>
                        <a href="admin_delete_teacher.jsp?id=<%= rs.getInt("id") %>"
                           class="btn btn-danger btn-sm"
                           onclick="return confirm('Are you sure you want to delete this teacher?');">
                           Delete
                        </a>
                    </td>
                </tr>
            <%
                    }
                    con.close();
                } catch(Exception e) {
                    out.println("<tr><td colspan='4'>Error: " + e.getMessage() + "</td></tr>");
                }
            %>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>
