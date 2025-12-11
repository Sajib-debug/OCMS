<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>

<%
    // Admin session check
    if(session == null || session.getAttribute("adminEmail") == null){
        response.sendRedirect("admin_login.jsp");
        return;
    }
    String adminName = (String) session.getAttribute("adminName");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Courses | OCMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body { 
            background: #eaeaea;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .card-box { 
            border-radius: 18px; 
            transition: all 0.3s ease; 
            padding: 25px; 
            margin-bottom: 25px; 
            background: #ffffff;
        }
        .card-box:hover { 
            transform: translateY(-5px); 
            box-shadow: 0 12px 28px rgba(0,0,0,0.12); 
        }
        textarea { resize: none; }
        .table th, .table td { 
            vertical-align: middle; 
        }
        .table thead { 
            background-color: #343a40; 
            color: #fff; 
        }
        .table tbody tr:hover { 
            background-color: #f1f3f5; 
        }
        .btn-primary { background-color: #4f46e5; border: none; }
        .btn-primary:hover { background-color: #4338ca; }
        .btn-danger { background-color: #dc2626; border: none; }
        .btn-danger:hover { background-color: #b91c1c; }
        .navbar { background-color: #1f2937; }
        .navbar a, .navbar span { color: #f9fafb !important; font-weight: 600; }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark shadow-sm">
    <div class="container">
        <a class="navbar-brand" href="admin_dashboard.jsp">← Back to Dashboard</a>
        <span class="fw-bold"><%= adminName %></span>
        <a href="logout_admin.jsp" class="btn btn-danger ms-3">Logout</a>
    </div>
</nav>

<div class="container mt-4">

    <!-- Add Course Form -->
    <div class="card-box shadow-sm">
        <h4 class="mb-3">Add New Course</h4>
        <form action="courses_add.jsp" method="post">
            <div class="row g-3">
                <div class="col-md-4">
                    <input type="text" name="title" class="form-control" placeholder="Course Title" required>
                </div>
                <div class="col-md-4">
                    <select name="instructor_id" class="form-control" required>
                        <option value="">-- Select Instructor --</option>
                        <%
                            try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                Connection con2 = DriverManager.getConnection(
                                    "jdbc:mysql://localhost:3306/OCMS", "root", "SKR@133957"
                                );
                                PreparedStatement ps2 = con2.prepareStatement("SELECT id, name FROM teachers ORDER BY name ASC");
                                ResultSet rs2 = ps2.executeQuery();
                                while(rs2.next()) {
                        %>
                            <option value="<%= rs2.getInt("id") %>"><%= rs2.getString("name") %></option>
                        <%
                                }
                                con2.close();
                            } catch(Exception e2){
                                out.println("<option disabled>Error loading teachers</option>");
                            }
                        %>
                    </select>
                </div>
                <div class="col-md-4">
                    <textarea name="description" class="form-control" placeholder="Course Description" required></textarea>
                </div>
            </div>
            <button class="btn btn-primary mt-3">Add Course</button>
        </form>
    </div>

    <!-- Course List -->
    <div class="card-box shadow-sm">
        <h4 class="mb-3">All Courses</h4>
        <table class="table table-bordered table-hover">
            <thead>
                <tr>
                    <th>ID</th>
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
                        "jdbc:mysql://localhost:3306/OCMS", "root", "SKR@133957"
                    );

                    PreparedStatement ps = con.prepareStatement(
                        "SELECT c.id, c.title, c.description, t.name AS instructor " +
                        "FROM courses c LEFT JOIN teachers t ON c.instructor_id = t.id ORDER BY c.id DESC"
                    );
                    ResultSet rs = ps.executeQuery();

                    while(rs.next()){
            %>
                <tr>
                    <td><%= rs.getInt("id") %></td>
                    <td><%= rs.getString("title") %></td>
                    <td><%= rs.getString("description") %></td>
                    <td><%= rs.getString("instructor") %></td>
                    <td>
                        <a href="courses_delete.jsp?id=<%= rs.getInt("id") %>" 
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
                    out.println("<tr><td colspan='5'>Error: "+e.getMessage()+"</td></tr>");
                }
            %>
            </tbody>
        </table>
    </div>

</div>

</body>
</html>
