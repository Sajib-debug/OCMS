<%@ page contentType="text/html;charset=UTF-8" %>
<%
    Object email = session.getAttribute("adminEmail");
    String adminName = (String) session.getAttribute("adminName");

    if (email == null) {
        response.sendRedirect("admin_login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard | OCMS</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body { 
            background: #f0f2f5;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .card-box { 
            padding: 30px; 
            border-radius: 20px; 
            transition: transform 0.3s, box-shadow 0.3s; 
        }
        .card-box:hover { 
            transform: translateY(-8px); 
            box-shadow: 0 15px 35px rgba(0,0,0,0.15); 
        }
        .card-box img { margin-bottom: 15px; }
        .card-box h4 { font-weight: 700; }
        .card-box p { color: #6b7280; }
        .btn { font-weight: 600; transition: all 0.3s; }
        .btn:hover { opacity: 0.9; transform: translateY(-2px); }

        /* Navbar */
        .navbar { padding: 15px 0; }
        .navbar-brand { font-weight: 700; font-size: 1.5rem; }
        .navbar span { margin-left: 20px; font-weight: 500; }

        /* Heading */
        h2 { font-weight: 700; font-size: 2rem; margin-bottom: 40px; }
    </style>
</head>
<body>

<nav class="navbar navbar-dark bg-dark navbar-expand-lg shadow-sm">
    <div class="container">
        <a class="navbar-brand">OCMS Admin</a>
        <span class="text-white">Welcome, <%= adminName %></span>
        <a href="logout_admin.jsp" class="btn btn-danger ms-3">Logout</a>
    </div>
</nav>

<div class="container py-5">
    <h2 class="text-center">Admin Dashboard</h2>

    <div class="row g-4">

        <!-- Courses -->
        <div class="col-md-4">
            <div class="bg-white card-box text-center shadow-sm">
                <img src="https://cdn-icons-png.flaticon.com/512/3135/3135755.png" width="70">
                <h4>Courses</h4>
                <p>Manage all courses</p>
                <a href="courses.jsp" class="btn btn-primary w-100">View</a>
            </div>
        </div>

        <!-- Students -->
        <div class="col-md-4">
            <div class="bg-white card-box text-center shadow-sm">
                <img src="https://cdn-icons-png.flaticon.com/512/3135/3135810.png" width="70">
                <h4>Students</h4>
                <p>View & manage students</p>
                <a href="admin_students.jsp" class="btn btn-success w-100">View</a>
            </div>
        </div>

        <!-- Teachers -->
        <div class="col-md-4">
            <div class="bg-white card-box text-center shadow-sm">
                <img src="https://cdn-icons-png.flaticon.com/512/1995/1995574.png" width="70">
                <h4>Teachers</h4>
                <p>View & manage teachers</p>
                <a href="admin_teachers.jsp" class="btn btn-warning w-100">View</a>
            </div>
        </div>

    </div>
</div>

</body>
</html>
