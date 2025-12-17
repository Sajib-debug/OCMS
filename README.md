🎓 Online Course Management System (OCMS):
An Online Course Management System built using Java (JSP & Servlet), JDBC, MySQL, and Bootstrap, designed for managing students, teachers, courses, and enrollments with role-based dashboards.

🚀 Features:
👨‍🎓 Student Module:
Student Registration & Login
View enrolled courses
Enroll in new courses
Remove enrolled courses
Modern card-based dashboard UI

👨‍🏫 Teacher Module:
Teacher Registration & Login
Add new courses
View own courses
Delete courses
Clean and responsive dashboard

🛠️ Admin Module:
Admin Login
Manage Students
Manage Teachers
Manage Courses
View which student enrolled in which courses
Cascade delete support (data consistency)


🧱 Tech Stack:
Frontend:	JSP, HTML, CSS, Bootstrap 5
Backend:	Java, JSP
Database:	MySQL
Connectivity:	JDBC
Server:	Apache Tomcat
Tools:	Eclipse / IntelliJ IDEA, MySQL Workbench

🗄️ Database Schema:
Tables used:
admin
students
teachers
courses
student_courses

Relationships:
One Teacher → Many Courses
Many Students ↔ Many Courses (via student_courses)
Foreign key constraints with ON DELETE CASCADE to maintain data integrity.
