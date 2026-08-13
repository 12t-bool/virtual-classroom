<%@page import="java.util.List"%>
<%@page import="com.virtualclassroom.model.Course"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
String fullname = (String) session.getAttribute("fullname");
String role = (String) session.getAttribute("role");

if (fullname == null || role == null ||
    !"student".equalsIgnoreCase(role)) {

    response.sendRedirect(request.getContextPath() + "/login.jsp");
    return;
}

List<Course> courses =
        (List<Course>) request.getAttribute("courses");

String contextPath = request.getContextPath();

String error = request.getParameter("error");
String success = request.getParameter("success");
%>

<!DOCTYPE html>

<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>Browse Courses - Virtual Classroom</title>

<style>

/* =========================
   RESET
========================= */

* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}

/* =========================
   BODY
========================= */

body {
    font-family: Arial, sans-serif;
    background: #f5f7fb;
    color: #333;
}

/* =========================
   SIDEBAR
========================= */

.sidebar {
    position: fixed;
    left: 0;
    top: 0;

    width: 240px;
    height: 100vh;

    background: #4f46e5;
    color: white;

    padding: 25px 20px;

    overflow-y: auto;
}

.logo {
    font-size: 22px;
    font-weight: bold;

    margin-bottom: 40px;

    text-align: center;
}

.sidebar a {
    display: block;

    color: white;
    text-decoration: none;

    padding: 13px 15px;

    margin-bottom: 8px;

    border-radius: 8px;

    transition: 0.2s;
}

.sidebar a:hover {
    background: #4338ca;
}

.sidebar a.active {
    background: #4338ca;
}

/* =========================
   LOGOUT
========================= */

.logout {
    margin-top: 30px;
}

.logout a {
    background: #dc2626;
}

.logout a:hover {
    background: #b91c1c;
}

/* =========================
   MAIN
========================= */

.main {
    margin-left: 240px;
    padding: 40px;
}

/* =========================
   HEADER
========================= */

.header {
    margin-bottom: 25px;
}

.header h1 {
    font-size: 30px;
    color: #4f46e5;

    margin-bottom: 8px;
}

.header p {
    color: #777;
    font-size: 15px;
}

/* =========================
   MESSAGES
========================= */

.message {
    padding: 14px 18px;

    border-radius: 10px;

    margin-bottom: 25px;

    font-weight: bold;
}

.success {
    background: #dcfce7;
    color: #15803d;

    border: 1px solid #bbf7d0;
}

.error {
    background: #fee2e2;
    color: #b91c1c;

    border: 1px solid #fecaca;
}

/* =========================
   COURSES GRID
========================= */

.courses {
    display: grid;

    grid-template-columns: repeat(3, 1fr);

    gap: 22px;
}

/* =========================
   COURSE CARD
========================= */

.course-card {
    background: white;

    padding: 25px;

    border-radius: 15px;

    box-shadow:
        0 5px 20px rgba(0,0,0,0.06);

    transition: all 0.25s ease;

    position: relative;

    overflow: hidden;
}

.course-card::before {
    content: "";

    position: absolute;

    top: 0;
    left: 0;

    width: 100%;
    height: 4px;

    background: #4f46e5;
}

.course-card:hover {
    transform: translateY(-6px);

    box-shadow:
        0 12px 30px rgba(0,0,0,0.10);
}

/* =========================
   COURSE ICON
========================= */

.course-icon {
    width: 60px;
    height: 60px;

    display: flex;

    align-items: center;
    justify-content: center;

    background: #eef2ff;

    border-radius: 12px;

    font-size: 30px;

    margin-bottom: 18px;
}

/* =========================
   COURSE TITLE
========================= */

.course-card h2 {
    color: #4f46e5;

    font-size: 21px;

    margin-bottom: 12px;
}

/* =========================
   DESCRIPTION
========================= */

.course-card p {
    color: #666;

    line-height: 1.6;

    min-height: 65px;

    margin-bottom: 18px;
}

/* =========================
   COURSE INFO
========================= */

.course-info {
    padding-top: 15px;

    border-top: 1px solid #eee;

    color: #777;

    font-size: 14px;

    margin-bottom: 18px;
}

.course-info strong {
    color: #333;
}

/* =========================
   ENROLL BUTTON
========================= */

.enroll-form {
    width: 100%;
}

.enroll-btn {
    width: 100%;

    padding: 12px 18px;

    border: none;

    border-radius: 8px;

    background: #4f46e5;

    color: white;

    font-size: 15px;

    font-weight: bold;

    cursor: pointer;

    transition: 0.2s;
}

.enroll-btn:hover {
    background: #4338ca;

    transform: translateY(-1px);
}

/* =========================
   EMPTY STATE
========================= */

.empty {
    background: white;

    padding: 60px 40px;

    border-radius: 15px;

    text-align: center;

    box-shadow:
        0 5px 20px rgba(0,0,0,0.06);
}

.empty-icon {
    font-size: 55px;

    margin-bottom: 20px;
}

.empty h2 {
    margin-bottom: 10px;
}

.empty p {
    color: #777;

    margin-bottom: 20px;
}

.back-btn {
    display: inline-block;

    padding: 12px 20px;

    background: #4f46e5;

    color: white;

    text-decoration: none;

    border-radius: 8px;

    font-weight: bold;
}

.back-btn:hover {
    background: #4338ca;
}

/* =========================
   RESPONSIVE
========================= */

@media (max-width: 1100px) {

    .courses {
        grid-template-columns: repeat(2, 1fr);
    }

}

@media (max-width: 700px) {

    .sidebar {
        position: relative;

        width: 100%;

        height: auto;
    }

    .main {
        margin-left: 0;

        padding: 25px;
    }

    .courses {
        grid-template-columns: 1fr;
    }

}

</style>

</head>

<body>


<!-- =====================================================
     SIDEBAR
===================================================== -->

<div class="sidebar">

    <div class="logo">
        🎓 Virtual Classroom
    </div>


    <a href="<%= contextPath %>/student/dashboard.jsp">
        🏠 Dashboard
    </a>


    <a href="<%= contextPath %>/student/my-courses">
        📚 My Courses
    </a>


    <a href="<%= contextPath %>/courses"
       class="active">

        🔎 Browse Courses

    </a>


    <a href="<%= contextPath %>/student/study-materials">
        📖 Study Materials
    </a>


    <a href="<%= contextPath %>/student/assignments">
        📝 Assignments
    </a>


    <a href="<%= contextPath %>/student/progress">
        📊 My Progress
    </a>


    <a href="<%= contextPath %>/student/announcements">
        📢 Announcements
    </a>


    <a href="<%= contextPath %>/profile">
        👤 My Profile
    </a>


    <div class="logout">

        <a href="<%= contextPath %>/logout">
            🚪 Logout
        </a>

    </div>

</div>


<!-- =====================================================
     MAIN CONTENT
===================================================== -->

<div class="main">


    <div class="header">

        <h1>
            Browse Courses 📚
        </h1>

        <p>
            Explore available courses and enroll in the ones
            you want to learn.
        </p>

    </div>


    <!-- =================================================
         SUCCESS MESSAGE
    ================================================== -->

    <% if ("enrolled".equals(success)) { %>

        <div class="message success">

            ✅ You have successfully enrolled
            in the course!

        </div>

    <% } %>


    <!-- =================================================
         ALREADY ENROLLED
    ================================================== -->

    <% if ("already".equals(error)) { %>

        <div class="message error">

            ⚠️ You are already enrolled
            in this course.

        </div>

    <% } %>


    <!-- =================================================
         INVALID COURSE
    ================================================== -->

    <% if ("invalid".equals(error)) { %>

        <div class="message error">

            ⚠️ Invalid course selected.

        </div>

    <% } %>


    <!-- =================================================
         ENROLLMENT FAILED
    ================================================== -->

    <% if ("failed".equals(error)) { %>

        <div class="message error">

            ❌ Enrollment failed.
            Please try again.

        </div>

    <% } %>


    <!-- =================================================
         COURSES
    ================================================== -->

    <% if (courses != null && !courses.isEmpty()) { %>


        <div class="courses">


            <% for (Course course : courses) { %>


                <div class="course-card">


                    <!-- Course Icon -->

                    <div class="course-icon">
                        📚
                    </div>


                    <!-- Course Name -->

                    <h2>
                        <%= course.getCourseName() %>
                    </h2>


                    <!-- Description -->

                    <p>
                        <%= course.getDescription() %>
                    </p>


                    <!-- Course Information -->

                    <div class="course-info">

                        Course ID:

                        <strong>
                            <%= course.getId() %>
                        </strong>

                    </div>


                    <!-- Enroll Form -->

                    <form
                        action="<%= contextPath %>/enroll"
                        method="post"
                        class="enroll-form">


                        <input
                            type="hidden"
                            name="courseId"
                            value="<%= course.getId() %>">


                        <button
                            type="submit"
                            class="enroll-btn">

                            🎓 Enroll Now

                        </button>


                    </form>


                </div>


            <% } %>


        </div>


    <% } else { %>


        <!-- =================================================
             EMPTY STATE
        ================================================== -->

        <div class="empty">


            <div class="empty-icon">
                📚
            </div>


            <h2>
                No Courses Available
            </h2>


            <p>
                There are currently no courses available.
            </p>


            <a
                href="<%= contextPath %>/student/dashboard.jsp"
                class="back-btn">

                Back to Dashboard

            </a>


        </div>


    <% } %>


</div>


</body>

</html>