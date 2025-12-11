<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*,jakarta.servlet.http.*" %>

<%
    // Student session check
    HttpSession studentSession = request.getSession(false);
    if(studentSession == null || studentSession.getAttribute("studentId") == null) {
        response.sendRedirect("student_login.jsp");
        return;
    }

    int studentId = (Integer) studentSession.getAttribute("studentId");
    String studentName = (String) studentSession.getAttribute("studentName");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student Dashboard | OCMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        /* Body & Fonts */
        body { 
            font-family: 'Georgia', serif; 
            background: linear-gradient(to right, #e0eafc, #cfdef3); 
            min-height: 100vh;
        }

        /* Cards */
        .card-box {
            border-radius: 15px;
            transition: 0.3s;
            padding: 25px;
            margin-bottom: 25px;
            background: #ffffff;
        }
        .card-box:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 35px rgba(0,0,0,0.15);
        }

        /* Navbar */
        .navbar-brand { font-weight: 700; font-size: 1.4rem; }
        .navbar .btn { font-weight: 600; }

        table th, table td { vertical-align: middle; }

        /* Buttons & Forms */
        .form-select, .btn { border-radius: 12px; }
        .btn-primary { font-weight: 600; }

        /* Hero / welcome text */
        .hero-text { font-weight: 600; color: #1f2937; }

        /* Responsive max-width cards */
        .card-box table { background: #f9fafb; }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
    <div class="container">
        <a class="navbar-brand" href="#">Student Dashboard</a>
        <div class="d-flex align-items-center">
            <span class="text-white fw-bold me-3">Welcome, <%= studentName %></span>
            <a href="index.jsp" class="btn btn-danger"><i class="bi bi-box-arrow-left me-1"></i> Logout / Home</a>
        </div>
    </div>
</nav>

<div class="container mt-4">

    <!-- Enrolled Courses -->
    <div class="card shadow-sm card-box">
        <h4 class="mb-3">Your Enrolled Courses</h4>
        <table class="table table-bordered table-hover">
            <thead class="table-dark">
                <tr>
                    <th>Course ID</th>
                    <th>Title</th>
                    <th>Description</th>
                    <th>Instructor</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
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

                    while(rs.next()){
            %>
                <tr>
                    <td><%= rs.getInt("id") %></td>
                    <td><%= rs.getString("title") %></td>
                    <td><%= rs.getString("description") %></td>
                    <td><%= rs.getString("instructor") %></td>
                    <td>
                        <a href="student_remove_course.jsp?id=<%= rs.getInt("id") %>"
                           class="btn btn-danger btn-sm"
                           onclick="return confirm('Remove this course?');">
                           Remove
                        </a>
                    </td>
                </tr>
            <%
                    }
                    con.close();
                } catch(Exception e){
                    out.println("<tr><td colspan='5'>Error: "+e.getMessage()+"</td></tr>");
                }
            %>
            </tbody>
        </table>
    </div>

    <!-- Enroll in New Course -->
    <div class="card shadow-sm card-box">
        <h4 class="mb-3">Enroll in New Course</h4>

        <form action="student_add_course.jsp" method="post">
            <div class="row g-2">
                <div class="col-md-12">
                    <select name="courseId" class="form-select" required>
                        <option value="">Select Course</option>
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
                            <option value="<%= rs2.getInt("id") %>">
                                <%= rs2.getString("title") %> - <%= rs2.getString("instructor") %>
                            </option>
                        <%
                                }
                                con.close();
                            } catch(Exception e){
                                out.println("<option>Error loading courses</option>");
                            }
                        %>
                    </select>
                </div>
            </div>
            <button class="btn btn-primary mt-3 w-100">Enroll</button>
        </form>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
