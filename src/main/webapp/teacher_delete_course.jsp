<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.*" %>

<%
    // Check teacher session
    if(session.getAttribute("teacherId") == null){
        response.sendRedirect("teacher_login.jsp");
        return;
    }

    int teacherId = (Integer)session.getAttribute("teacherId");
    String courseIdStr = request.getParameter("id");

    if(courseIdStr != null){
        int courseId = Integer.parseInt(courseIdStr);

        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/OCMS","root","SKR@133957"
            );

            // Only allow teacher to delete their own courses
            PreparedStatement ps = con.prepareStatement(
                "DELETE FROM courses WHERE id=? AND instructor_id=?"
            );
            ps.setInt(1, courseId);
            ps.setInt(2, teacherId);

            int rows = ps.executeUpdate();
            con.close();

            if(rows > 0){
                response.sendRedirect("teacher_dashboard.jsp");
            } else {
                out.println("<p class='text-danger'>You cannot delete this course!</p>");
            }

        }catch(Exception e){
            out.println("<p class='text-danger'>Error: "+e.getMessage()+"</p>");
        }
    } else {
        response.sendRedirect("teacher_dashboard.jsp");
    }
%>
