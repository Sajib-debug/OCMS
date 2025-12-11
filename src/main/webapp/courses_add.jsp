<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    if(session == null || session.getAttribute("adminEmail") == null){
        response.sendRedirect("admin_login.jsp");
        return;
    }

    String title = request.getParameter("title");
    String description = request.getParameter("description");
    String instructorIdStr = request.getParameter("instructor_id");

    if(title != null && description != null && instructorIdStr != null){
        try {
            int instructorId = Integer.parseInt(instructorIdStr);

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/OCMS", "root", "SKR@133957"
            );

            // get instructor name
            PreparedStatement psName = con.prepareStatement("SELECT name FROM teachers WHERE id=?");
            psName.setInt(1, instructorId);
            ResultSet rsName = psName.executeQuery();
            String instructorName = "";
            if(rsName.next()){
                instructorName = rsName.getString("name");
            }

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO courses(title, description, instructor, instructor_id) VALUES(?,?,?,?)"
            );
            ps.setString(1, title);
            ps.setString(2, description);
            ps.setString(3, instructorName);
            ps.setInt(4, instructorId);

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
