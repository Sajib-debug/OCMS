<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.*" %>

<%
    // Check if teacher is logged in
    if(session.getAttribute("teacherId") == null){
        response.sendRedirect("teacher_login.jsp");
        return;
    }

    int teacherId = (Integer)session.getAttribute("teacherId");
    String teacherName = (String)session.getAttribute("teacherName");

    String title = request.getParameter("title");
    String description = request.getParameter("description");

    if(title != null && description != null){
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/OCMS","root","SKR@133957"
            );

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO courses(title, description, instructor, instructor_id) VALUES(?,?,?,?)"
            );
            ps.setString(1, title);
            ps.setString(2, description);
            ps.setString(3, teacherName);
            ps.setInt(4, teacherId);

            ps.executeUpdate();
            con.close();

            response.sendRedirect("teacher_dashboard.jsp");
            return;
        }catch(Exception e){
            out.println("<p class='text-danger'>Error: "+e.getMessage()+"</p>");
        }
    }
%>
