<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.*" %>

<%
    // Session check
    HttpSession studentSession = request.getSession(false);
    if(studentSession == null || studentSession.getAttribute("studentId") == null){
        response.sendRedirect("student_login.jsp");
        return;
    }

    int studentId = (Integer) studentSession.getAttribute("studentId");
    String courseIdStr = request.getParameter("courseId");
    if(courseIdStr == null){
        response.sendRedirect("student_dashboard.jsp");
        return;
    }

    int courseId = Integer.parseInt(courseIdStr);

    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/OCMS","root","SKR@133957"
        );

        PreparedStatement ps = con.prepareStatement(
            "INSERT INTO student_courses(student_id, course_id) VALUES(?,?)"
        );
        ps.setInt(1, studentId);
        ps.setInt(2, courseId);
        ps.executeUpdate();
        con.close();

        response.sendRedirect("student_dashboard.jsp");
    }catch(Exception e){
        out.println("Error: "+e.getMessage());
    }
%>
