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
    <title>Admin | Manage Students</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: #f2f4f7;
            font-family: 'Segoe UI', sans-serif;
        }

        .student-card {
            border-radius: 18px;
            padding: 20px;
            background: #ffffff;
            box-shadow: 0 8px 22px rgba(0,0,0,0.08);
            transition: 0.3s;
            height: 100%;
        }

        .student-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 14px 30px rgba(0,0,0,0.12);
        }

        .course-badge {
            background-color: #4f46e5;
            margin: 3px 3px 0 0;
            font-size: 12px;
        }

        .no-course {
            background-color: #9ca3af;
            font-size: 12px;
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
    <h3 class="text-center mb-4">All Students</h3>

    <div class="row g-4">
    <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/OCMS", "root", "SKR@133957"
            );

            String sql =
                "SELECT s.id, s.name, s.email, " +
                "GROUP_CONCAT(c.title SEPARATOR ', ') AS courses " +
                "FROM students s " +
                "LEFT JOIN student_courses sc ON s.id = sc.student_id " +
                "LEFT JOIN courses c ON sc.course_id = c.id " +
                "GROUP BY s.id, s.name, s.email " +
                "ORDER BY s.id DESC";

            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while(rs.next()) {
                String courseStr = rs.getString("courses");
    %>

        <div class="col-md-4 col-lg-3">
            <div class="student-card">
                <h5 class="fw-bold mb-1"><%= rs.getString("name") %></h5>
                <p class="text-muted mb-2"><%= rs.getString("email") %></p>

                <div class="mb-3">
                    <strong class="d-block mb-1">Courses</strong>
                    <%
                        if(courseStr != null){
                            String[] courses = courseStr.split(",");
                            for(String c : courses){
                    %>
                        <span class="badge rounded-pill course-badge">
                            <%= c.trim() %>
                        </span>
                    <%
                            }
                        } else {
                    %>
                        <span class="badge rounded-pill no-course">
                            No course enrolled
                        </span>
                    <%
                        }
                    %>
                </div>

                <a href="admin_delete_student.jsp?id=<%= rs.getInt("id") %>"
                   class="btn btn-danger btn-sm w-100"
                   onclick="return confirm('Are you sure you want to delete this student?');">
                    Delete Student
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
