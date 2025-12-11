<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.*" %>

<%
    HttpSession teacherSession = request.getSession(false);
    if(teacherSession == null || teacherSession.getAttribute("teacherId") == null){
        response.sendRedirect("teacher_login.jsp");
        return;
    }

    int teacherId = (Integer) teacherSession.getAttribute("teacherId");
    String teacherName = (String) teacherSession.getAttribute("teacherName");

    String courseIdStr = request.getParameter("courseId");
    if(courseIdStr == null){
        response.sendRedirect("teacher_dashboard.jsp");
        return;
    }
    int courseId = Integer.parseInt(courseIdStr);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Students | OCMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<nav class="navbar navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="teacher_dashboard.jsp">← Back to Dashboard</a>
        <span class="text-white fw-bold">Welcome, <%= teacherName %></span>
        <a href="logout_teacher.jsp" class="btn btn-danger ms-3">Logout</a>
    </div>
</nav>

<div class="container mt-4">

    <!-- Enrolled Students -->
    <div class="card shadow-sm p-4 mb-4">
        <h4 class="mb-3">Enrolled Students</h4>
        <table class="table table-bordered table-hover">
            <thead class="table-dark">
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
                        "jdbc:mysql://localhost:3306/OCMS","root","SKR@133957"
                    );

                    PreparedStatement ps = con.prepareStatement(
                        "SELECT s.id, s.name, s.email FROM students s " +
                        "JOIN student_courses sc ON s.id=sc.student_id " +
                        "WHERE sc.course_id=? ORDER BY s.id DESC"
                    );
                    ps.setInt(1, courseId);
                    ResultSet rs = ps.executeQuery();
                    while(rs.next()){
            %>
                <tr>
                    <td><%= rs.getInt("id") %></td>
                    <td><%= rs.getString("name") %></td>
                    <td><%= rs.getString("email") %></td>
                    <td>
                        <a href="teacher_remove_student.jsp?courseId=<%= courseId %>&studentId=<%= rs.getInt("id") %>" 
                           class="btn btn-danger btn-sm"
                           onclick="return confirm('Remove this student?');">Remove</a>
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
