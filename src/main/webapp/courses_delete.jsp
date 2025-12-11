<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    if(session == null || session.getAttribute("adminEmail") == null){
        response.sendRedirect("admin_login.jsp");
        return;
    }

    String idStr = request.getParameter("id");
    if(idStr != null){
        try {
            int id = Integer.parseInt(idStr);
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/OCMS", "root", "SKR@133957"
            );

            PreparedStatement ps = con.prepareStatement("DELETE FROM courses WHERE id=?");
            ps.setInt(1, id);
            ps.executeUpdate();
            con.close();

            response.sendRedirect("courses.jsp");
        } catch(Exception e){
            out.println("Error: "+e.getMessage());
        }
    } else {
        response.sendRedirect("courses.jsp");
    }
%>
