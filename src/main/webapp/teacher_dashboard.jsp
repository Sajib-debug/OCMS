<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.*" %>

<%
    Object email = session.getAttribute("teacherEmail");
    if(email == null){
        response.sendRedirect("teacher_login.jsp");
        return;
    }
    int teacherId = (Integer)session.getAttribute("teacherId");
    String teacherName = (String)session.getAttribute("teacherName");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Teacher Dashboard | OCMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            background: #f2f4f7;
            font-family: 'Segoe UI', sans-serif;
        }

        .course-card {
            background: #ffffff;
            border-radius: 18px;
            padding: 22px;
            box-shadow: 0 8px 22px rgba(0,0,0,0.08);
            transition: 0.3s;
            height: 100%;
        }

        .course-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 14px 30px rgba(0,0,0,0.12);
        }

        .course-icon {
            width: 55px;
            height: 55px;
            border-radius: 50%;
            background: #16a34a;
            color: #fff;
            font-size: 22px;
            font-weight: bold;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 12px;
        }

        .navbar {
            background-color: #1f2937;
        }
        .navbar a, .navbar span {
            color: #f9fafb !important;
            font-weight: 600;
        }

        textarea { resize: none; }

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
        <span class="navbar-brand">Teacher Dashboard</span>
        <div class="d-flex align-items-center">
            <span class="me-3 fw-bold">Welcome, <%= teacherName %></span>
            <a href="index.jsp" class="btn btn-danger btn-sm">
                <i class="bi bi-box-arrow-left"></i> Logout
            </a>
        </div>
    </div>
</nav>

<div class="container mt-4">

    <!-- Add New Course -->
    <div class="card shadow-sm mb-4" style="border-radius:18px;">
        <div class="card-body">
            <h4 class="mb-3">Add New Course</h4>

            <form method="post" action="teacher_add_course.jsp">
                <div class="row g-3">
                    <div class="col-md-4">
                        <input type="text" name="title" class="form-control" placeholder="Course Title" required>
                    </div>
                    <div class="col-md-5">
                        <textarea name="description" class="form-control" placeholder="Course Description" required></textarea>
                    </div>
                    <div class="col-md-3 d-grid">
                        <button class="btn btn-success">
                            <i class="bi bi-plus-circle me-1"></i> Add Course
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <!-- My Courses -->
    <h4 class="mb-3">My Courses</h4>
    <div class="row g-4">

    <%
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/OCMS","root","SKR@133957"
            );

            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM courses WHERE instructor_id=? ORDER BY id DESC"
            );
            ps.setInt(1, teacherId);
            ResultSet rs = ps.executeQuery();

            boolean hasCourse = false;
            while(rs.next()){
                hasCourse = true;
    %>
        <div class="col-md-4 col-lg-3">
            <div class="course-card text-center">
                <div class="course-icon">
                    <%= rs.getString("title").substring(0,1).toUpperCase() %>
                </div>

                <h5 class="fw-bold"><%= rs.getString("title") %></h5>
                <p class="text-muted small mb-3">
                    <%= rs.getString("description") %>
                </p>

                <a href="teacher_delete_course.jsp?id=<%= rs.getInt("id") %>"
                   class="btn btn-danger btn-sm w-100"
                   onclick="return confirm('Are you sure you want to delete this course?');">
                    Delete Course
                </a>
            </div>
        </div>
    <%
            }
            if(!hasCourse){
    %>
        <div class="col-12 text-center text-muted">
            You have not created any course yet.
        </div>
    <%
            }
            con.close();
        } catch(Exception e){
            out.println("<div class='col-12 text-danger'>Error: "+e.getMessage()+"</div>");
        }
    %>

    </div>
</div>

</body>
</html>
