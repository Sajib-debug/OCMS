<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.*" %>

<%
    HttpSession teacherSession = request.getSession(false);
    if(teacherSession == null || teacherSession.getAttribute("teacherId") == null){
        response.sendRedirect("teacher_login.jsp");
        return;
    }

    String courseIdStr = request.getParameter("courseId");
    String studentIdStr = request.getParameter("studentId");

    if(courseIdStr == null || studentIdStr == null){
        response.sendRedirect("teacher_dashboard.jsp");
        return;
    }

    int courseId = Integer.parseInt(courseIdStr);
    int studentId = Integer.parseInt(studentIdStr);

    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/OCMS","root","SKR@133957"
        );

        PreparedStatement ps = con.prepareStatement(
            "DELETE FROM student_courses WHERE student_id=? AND course_id=?"
        );
        ps.setInt(1, studentId);
        ps.setInt(2, courseId);
        ps.executeUpdate();
        con.close();

        response.sendRedirect("teacher_manage_students.jsp?courseId="+courseId);
    }catch(Exception e){
        out.println("Error: "+e.getMessage());
    }
%>
