<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*,jakarta.servlet.http.*" %>

<%
    HttpSession studentSession = request.getSession(false);
    if(studentSession == null || studentSession.getAttribute("studentId") == null) {
        response.sendRedirect("student_login.jsp");
        return;
    }

    int studentId = (Integer) studentSession.getAttribute("studentId");
    String studentName = (String) studentSession.getAttribute("studentName");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Dashboard | OCMS</title>
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
            background: #4f46e5;
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
        <a class="navbar-brand" href="#">Student Dashboard</a>
        <div class="d-flex align-items-center">
            <span class="me-3 fw-bold">Welcome, <%= studentName %></span>
            <a href="index.jsp" class="btn btn-danger btn-sm">
                <i class="bi bi-box-arrow-left"></i> Logout
            </a>
        </div>
    </div>
</nav>

<div class="container mt-4">

    <!-- Enrolled Courses -->
    <h4 class="mb-3">Your Enrolled Courses</h4>
    <div class="row g-4 mb-5">

    <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/OCMS","root","SKR@133957"
            );

            PreparedStatement ps = con.prepareStatement(
                "SELECT c.id, c.title, c.description, c.instructor " +
                "FROM courses c JOIN student_courses sc ON c.id=sc.course_id " +
                "WHERE sc.student_id=? ORDER BY c.id DESC"
            );
            ps.setInt(1, studentId);
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
                <p class="text-muted small mb-1">
                    <%= rs.getString("description") %>
                </p>
                <p class="fw-semibold text-primary mb-3">
                    <%= rs.getString("instructor") %>
                </p>

                <a href="student_remove_course.jsp?id=<%= rs.getInt("id") %>"
                   class="btn btn-danger btn-sm w-100"
                   onclick="return confirm('Remove this course?');">
                    Remove
                </a>
            </div>
        </div>
    <%
            }
            if(!hasCourse){
    %>
        <div class="col-12 text-muted text-center">
            You have not enrolled in any course yet.
        </div>
    <%
            }
            con.close();
        } catch(Exception e){
            out.println("<div class='col-12 text-danger'>Error: "+e.getMessage()+"</div>");
        }
    %>
    </div>

    <!-- Enroll New Course -->
    <h4 class="mb-3">Enroll in New Course</h4>
    <div class="row g-4">

    <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/OCMS","root","SKR@133957"
            );

            PreparedStatement ps2 = con.prepareStatement(
                "SELECT * FROM courses WHERE id NOT IN " +
                "(SELECT course_id FROM student_courses WHERE student_id=?)"
            );
            ps2.setInt(1, studentId);
            ResultSet rs2 = ps2.executeQuery();

            while(rs2.next()){
    %>
        <div class="col-md-4 col-lg-3">
            <div class="course-card text-center">
                <div class="course-icon bg-success">
                    <%= rs2.getString("title").substring(0,1).toUpperCase() %>
                </div>

                <h5 class="fw-bold"><%= rs2.getString("title") %></h5>
                <p class="text-muted small mb-2">
                    <%= rs2.getString("description") %>
                </p>
                <p class="fw-semibold text-success mb-3">
                    <%= rs2.getString("instructor") %>
                </p>

                <form action="student_add_course.jsp" method="post">
                    <input type="hidden" name="courseId" value="<%= rs2.getInt("id") %>">
                    <button class="btn btn-primary btn-sm w-100">
                        Enroll
                    </button>
                </form>
            </div>
        </div>
    <%
            }
            con.close();
        } catch(Exception e){
            out.println("<div class='col-12 text-danger'>Error loading courses</div>");
        }
    %>

    </div>
</div>

</body>
</html>
