<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Online Course Management System</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body { 
            background-color: #f3f4f6;
            font-family: 'Georgia', serif;
            color: #1f2937;
        }

        /* Hero Section */
        .hero {
            background: linear-gradient(135deg, #0f172a, #1e293b);
            color: #f8fafc;
            padding: 70px 0;
            border-radius: 0 0 25px 25px;
            text-align: center;
        }
        .hero h1 { font-size: 2.8rem; font-weight: 700; }
        .hero p { font-size: 1.2rem; margin-top: 10px; }

        /* Cards */
        .card {
            border-radius: 15px;
            padding: 30px;
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .card:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.15);
        }
        .card i {
            font-size: 4rem;
        }

        /* Buttons */
        .btn-outline-primary, .btn-outline-success {
            border-width: 2px;
        }

        /* Navbar */
        .navbar-brand { font-weight: 700; font-size: 1.5rem; color: #ffffff; }
        .navbar-nav .nav-link { font-weight: 600; color: #ffffff !important; }

        /* About Section */
        #about {
            background-color: #ffffff;
            padding: 60px 0;
        }
        #about h2 { font-weight: 700; font-size: 2rem; }
        #about p { color: #4b5563; font-size: 1rem; }

        /* Contact Card */
        .contact-card {
            background: #6366f1;
            border-radius: 12px;
            padding: 25px;
            margin-top: 30px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.2);
        }
        .contact-card i { margin-right: 8px; color: #ffffff; }
        .contact-card p { color: #ffffff; font-size: 1.2rem; font-weight: 500; margin-bottom: 8px; }

        /* Footer */
        footer {
            background: #0f172a;
            color: #d1d5db;
            padding: 25px 0;
        }
        footer a { color: #f8fafc; text-decoration: none; }
        footer a:hover { text-decoration: underline; }
    </style>
</head>
<body>

<%@ page import="jakarta.servlet.http.HttpSession" %>
<%
    String logoutMessage = (String) session.getAttribute("logoutMessage");
    if (logoutMessage != null) {
%>
    <div class="alert alert-success text-center m-0" role="alert">
        <%= logoutMessage %>
    </div>
<%
        session.removeAttribute("logoutMessage");
    }
%>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">
            <i class="bi bi-mortarboard"></i> OnlineCourse
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="#about">About</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<div class="hero">
    <div class="container">
        <h1>Welcome to the Online Course Management System</h1>
        <p>Select your role to login or register and start managing courses.</p>
    </div>
</div>

<!-- Role Cards -->
<div class="container py-5">
    <div class="row g-4">

        <div class="col-md-4">
            <div class="card text-center shadow-sm">
                <i class="bi bi-person-fill text-primary"></i>
                <h3 class="mt-3">Student</h3>
                <p class="text-muted px-3">Browse courses, register, and track your learning progress.</p>
                <div class="mt-3">
                    <a href="student_login.jsp" class="btn btn-outline-primary me-2">Login</a>
                    <a href="student_register.jsp" class="btn btn-primary">Register</a>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card text-center shadow-sm">
                <i class="bi bi-person-workspace text-success"></i>
                <h3 class="mt-3">Teacher</h3>
                <p class="text-muted px-3">Create courses, manage students, and track performance.</p>
                <div class="mt-3">
                    <a href="teacher_login.jsp" class="btn btn-outline-success me-2">Login</a>
                    <a href="teacher_register.jsp" class="btn btn-success">Register</a>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card text-center shadow-sm">
                <i class="bi bi-shield-lock-fill text-danger"></i>
                <h3 class="mt-3">Admin</h3>
                <p class="text-muted px-3">Manage users, courses, and system settings.</p>
                <div class="mt-3">
                    <a href="admin_login.jsp" class="btn btn-danger px-4">Login</a>
                </div>
            </div>
        </div>

    </div>
</div>

<!-- About Section -->
<section id="about">
    <div class="container text-center">
        <h2>About</h2>
        <p class="mt-3">This system provides a clean interface for Students, Teachers, and Admins to manage online courses efficiently. Register or login to get started.</p>

        <!-- Contact Card -->
        <div class="contact-card">
            <h5 class="fw-bold mb-3">Contact Us</h5>
            <p style="color:#ffffff;"><i class="bi bi-telephone-fill"></i> 017########</p>
            <p style="color:#ffffff;"><i class="bi bi-envelope-fill"></i> sajib@gmail.com / rokun@gmail.com</p>
        </div>
    </div>
</section>

<!-- Footer -->
<footer class="text-center">
    <div class="container">
        <p>© <%= java.time.Year.now() %> OnlineCourse. All rights reserved.</p>
        <p><a href="#">Privacy Policy</a> | <a href="#">Terms</a></p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
