<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.*" %>

<%
    // Teacher session check
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
    <style>
        body { background: #f5f6fa; }
        .card-box { border-radius: 15px; padding: 20px; margin-bottom: 20px; transition: .3s; }
        .card-box:hover { transform: translateY(-5px); box-shadow: 0 10px 25px rgba(0,0,0,0.15); }
        textarea { resize: none; }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-dark bg-dark">
    <div class="container">
        <span class="navbar-brand">OCMS Teacher Dashboard</span>
        <span class="text-white fw-bold">Welcome, <%= teacherName %></span>
        <a href="index.jsp" class="btn btn-danger ms-3">Logout</a>
    </div>
</nav>

<div class="container mt-4">

    <!-- Add New Course -->
    <div class="card shadow-sm card-box">
        <h4 class="mb-3">Add New Course</h4>
        <form method="post" action="teacher_add_course.jsp">
            <div class="row g-2">
                <div class="col-md-4">
                    <input type="text" name="title" class="form-control" placeholder="Course Title" required>
                </div>
                <div class="col-md-4">
                    <textarea name="description" class="form-control" placeholder="Course Description" required></textarea>
                </div>
                <div class="col-md-4">
                    <button class="btn btn-success w-100">Add Course</button>
                </div>
            </div>
        </form>
    </div>

    <!-- Teacher's Courses List -->
    <div class="card shadow-sm card-box">
        <h4 class="mb-3">My Courses</h4>
        <table class="table table-bordered table-hover">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Title</th>
                    <th>Description</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
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

                    while(rs.next()){
            %>
                <tr>
                    <td><%= rs.getInt("id") %></td>
                    <td><%= rs.getString("title") %></td>
                    <td><%= rs.getString("description") %></td>
                    <td>
                        <a href="teacher_delete_course.jsp?id=<%= rs.getInt("id") %>"
                           class="btn btn-danger btn-sm"
                           onclick="return confirm('Are you sure you want to delete this course?');">
                            Delete
                        </a>
                    </td>
                </tr>
            <%
                    }
                    con.close();
                } catch(Exception e){
                    out.println("<tr><td colspan='4'>Error: "+e.getMessage()+"</td></tr>");
                }
            %>
            </tbody>
        </table>
    </div>

</div>

</body>
</html>
