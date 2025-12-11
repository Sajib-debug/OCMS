<%@ page import="java.sql.*" %>
<%
    if(session.getAttribute("adminEmail") == null) {
        response.sendRedirect("admin_login.jsp");
        return;
    }

    int id = Integer.parseInt(request.getParameter("id"));
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/OCMS", "root", "SKR@133957"
        );
        PreparedStatement ps = con.prepareStatement("DELETE FROM students WHERE id=?");
        ps.setInt(1, id);
        ps.executeUpdate();
        con.close();
        response.sendRedirect("admin_students.jsp");
    } catch(Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
