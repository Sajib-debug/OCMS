<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>

<%
    if(session == null || session.getAttribute("adminEmail") == null){
        response.sendRedirect("admin_login.jsp");
        return;
    }
    String adminName = (String) session.getAttribute("adminName");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Courses | OCMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: #eaeaea;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .card-box {
            border-radius: 18px;
            padding: 25px;
            background: #ffffff;
            margin-bottom: 25px;
        }
        .navbar {
            background-color: #1f2937;
        }
        .navbar a, .navbar span {
            color: #f9fafb !important;
            font-weight: 600;
        }

        /* Course card style */
        .course-card {
            border-radius: 16px;
            transition: 0.3s;
            height: 100%;
        }
        .course-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 12px 28px rgba(0,0,0,0.15);
        }
        .course-title {
            font-weight: 700;
            color: #4f46e5;
        }
        .course-instructor {
            font-weight: 600;
            color: #374151;
        }
        .course-desc {
            font-size: 14px;
            color: #6b7280;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark shadow-sm">
    <div class="container">
        <a class="navbar-brand" href="admin_dashboard.jsp">← Back to Dashboard</a>
        <span class="fw-bold"><%= adminName %></span>
        <a href="logout_admin.jsp" class="btn btn-danger ms-3">Logout</a>
    </div>
</nav>

<div class="container mt-4">

    <!-- Add Course -->
    <div class="card-box shadow-sm">
        <h4 class="mb-3">Add New Course</h4>
        <form action="courses_add.jsp" method="post">
            <div class="row g-3">
                <div class="col-md-4">
                    <input type="text" name="title" class="form-control" placeholder="Course Title" required>
                </div>
                <div class="col-md-4">
                    <select name="instructor_id" class="form-control" required>
                        <option value="">-- Select Instructor --</option>
                        <%
                            try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                Connection con2 = DriverManager.getConnection(
                                    "jdbc:mysql://localhost:3306/OCMS", "root", "SKR@133957"
                                );
                                PreparedStatement ps2 = con2.prepareStatement(
                                    "SELECT id, name FROM teachers ORDER BY name ASC"
                                );
                                ResultSet rs2 = ps2.executeQuery();
                                while(rs2.next()) {
                        %>
                            <option value="<%= rs2.getInt("id") %>"><%= rs2.getString("name") %></option>
                        <%
                                }
                                con2.close();
                            } catch(Exception e){}
                        %>
                    </select>
                </div>
                <div class="col-md-4">
                    <textarea name="description" class="form-control" placeholder="Course Description" required></textarea>
                </div>
            </div>
            <button class="btn btn-primary mt-3">Add Course</button>
        </form>
    </div>

    <!-- All Courses as Cards -->
    <div class="card-box shadow-sm">
        <h4 class="mb-4">All Courses</h4>

        <div class="row g-4">
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/OCMS", "root", "SKR@133957"
                );

                PreparedStatement ps = con.prepareStatement(
                    "SELECT c.id, c.title, c.description, t.name AS instructor " +
                    "FROM courses c LEFT JOIN teachers t ON c.instructor_id = t.id ORDER BY c.id DESC"
                );
                ResultSet rs = ps.executeQuery();

                while(rs.next()){
        %>
            <div class="col-lg-4 col-md-6">
                <div class="card course-card shadow-sm p-3">
                    <h5 class="course-title"><%= rs.getString("title") %></h5>
                    <p class="course-desc"><%= rs.getString("description") %></p>
                    <p class="course-instructor">
                        👨‍🏫 <%= rs.getString("instructor") %>
                    </p>
                    <a href="courses_delete.jsp?id=<%= rs.getInt("id") %>"
                       class="btn btn-danger btn-sm mt-2"
                       onclick="return confirm('Are you sure you want to delete this course?');">
                        Delete
                    </a>
                </div>
            </div>
        <%
                }
                con.close();
            } catch(Exception e){
                out.println("<p>Error loading courses</p>");
            }
        %>
        </div>
    </div>

</div>

</body>
</html>
