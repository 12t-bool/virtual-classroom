<%@page import="java.util.List"%>
<%@page import="com.virtualclassroom.model.Course"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String fullname = (String) session.getAttribute("fullname");
    String role = (String) session.getAttribute("role");

    if (fullname == null || role == null ||
        !"teacher".equalsIgnoreCase(role)) {

        response.sendRedirect(
            request.getContextPath() + "/login.jsp"
        );

        return;
    }

    List<Course> courses =
        (List<Course>) request.getAttribute("courses");

    String error = request.getParameter("error");
    String success = request.getParameter("success");

    String contextPath = request.getContextPath();
%>

<!DOCTYPE html>

<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>Study Materials | Virtual Classroom</title>

<style>

/* =========================================
   RESET
========================================= */

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}


/* =========================================
   BODY
========================================= */

body {
    font-family: Arial, sans-serif;
    background: #f5f7fb;
    color: #1f2937;
}


/* =========================================
   SIDEBAR
========================================= */

.sidebar {
    position: fixed;
    left: 0;
    top: 0;

    width: 250px;
    height: 100vh;

    background: linear-gradient(
        180deg,
        #4f46e5,
        #3730a3
    );

    color: white;

    padding: 25px 18px;

    box-shadow: 5px 0 20px rgba(0,0,0,0.08);

    z-index: 100;
}


.logo {
    text-align: center;

    font-size: 21px;

    font-weight: bold;

    padding: 15px 5px;

    margin-bottom: 35px;
}


.sidebar a {
    display: flex;

    align-items: center;

    gap: 10px;

    color: white;

    text-decoration: none;

    padding: 13px 15px;

    margin-bottom: 7px;

    border-radius: 10px;

    font-size: 14px;

    transition: 0.2s;
}


.sidebar a:hover {
    background: rgba(255,255,255,0.15);

    transform: translateX(3px);
}


/* ACTIVE PAGE */

.sidebar a.active {
    background: rgba(255,255,255,0.20);

    font-weight: bold;
}


/* LOGOUT */

.logout {
    margin-top: 30px;

    padding-top: 20px;

    border-top: 1px solid rgba(255,255,255,0.15);
}


.logout a {
    background: #dc2626;
}


.logout a:hover {
    background: #b91c1c;

    transform: none;
}


/* =========================================
   MAIN
========================================= */

.main {
    margin-left: 250px;

    padding: 40px;

    min-height: 100vh;
}


/* =========================================
   TOP HEADER
========================================= */

.top-bar {
    display: flex;

    justify-content: space-between;

    align-items: center;

    margin-bottom: 30px;
}


.header h1 {
    font-size: 32px;

    color: #111827;

    margin-bottom: 7px;
}


.header p {
    color: #6b7280;

    font-size: 15px;
}


.teacher-badge {
    background: white;

    padding: 10px 16px;

    border-radius: 12px;

    box-shadow: 0 5px 18px rgba(0,0,0,0.05);

    color: #4f46e5;

    font-weight: bold;
}


/* =========================================
   MESSAGES
========================================= */

.message {
    padding: 15px 18px;

    border-radius: 10px;

    margin-bottom: 25px;

    font-weight: bold;
}


.success {
    background: #dcfce7;

    color: #15803d;

    border-left: 5px solid #16a34a;
}


.error {
    background: #fee2e2;

    color: #b91c1c;

    border-left: 5px solid #dc2626;
}


/* =========================================
   FORM CARD
========================================= */

.form-card {
    background: white;

    padding: 30px;

    border-radius: 18px;

    box-shadow:
        0 8px 30px rgba(0,0,0,0.06);

    margin-bottom: 35px;

    max-width: 850px;
}


.form-heading {
    display: flex;

    align-items: center;

    gap: 12px;

    margin-bottom: 25px;
}


.form-heading-icon {
    width: 45px;

    height: 45px;

    display: flex;

    align-items: center;

    justify-content: center;

    background: #eef2ff;

    border-radius: 12px;

    font-size: 23px;
}


.form-heading h2 {
    color: #111827;

    font-size: 21px;
}


.form-heading p {
    color: #777;

    font-size: 13px;

    margin-top: 4px;
}


/* =========================================
   FORM
========================================= */

.form-group {
    margin-bottom: 20px;
}


.form-group label {
    display: block;

    margin-bottom: 8px;

    font-size: 14px;

    font-weight: bold;

    color: #374151;
}


.form-group input,
.form-group select,
.form-group textarea {
    width: 100%;

    padding: 13px 14px;

    border: 1px solid #d1d5db;

    border-radius: 9px;

    font-size: 14px;

    font-family: Arial, sans-serif;

    background: #fafafa;

    transition: 0.2s;
}


.form-group textarea {
    min-height: 110px;

    resize: vertical;
}


.form-group input:focus,
.form-group select:focus,
.form-group textarea:focus {
    outline: none;

    border-color: #4f46e5;

    background: white;

    box-shadow:
        0 0 0 3px rgba(79,70,229,0.10);
}


/* =========================================
   BUTTON
========================================= */

.add-btn {
    width: 100%;

    padding: 14px;

    border: none;

    border-radius: 9px;

    background: linear-gradient(
        135deg,
        #4f46e5,
        #6366f1
    );

    color: white;

    font-size: 15px;

    font-weight: bold;

    cursor: pointer;

    transition: 0.2s;
}


.add-btn:hover {
    transform: translateY(-2px);

    box-shadow:
        0 8px 18px rgba(79,70,229,0.25);
}


/* =========================================
   COURSES HEADER
========================================= */

.section-header {
    display: flex;

    justify-content: space-between;

    align-items: center;

    margin-bottom: 20px;
}


.section-header h2 {
    color: #111827;

    font-size: 22px;
}


.course-count {
    background: #eef2ff;

    color: #4f46e5;

    padding: 7px 13px;

    border-radius: 20px;

    font-size: 13px;

    font-weight: bold;
}


/* =========================================
   COURSES
========================================= */

.courses {
    display: grid;

    grid-template-columns:
        repeat(3, 1fr);

    gap: 22px;
}


.course-card {
    background: white;

    padding: 25px;

    border-radius: 17px;

    box-shadow:
        0 6px 25px rgba(0,0,0,0.05);

    transition: 0.25s;

    border: 1px solid #f1f1f1;
}


.course-card:hover {
    transform: translateY(-5px);

    box-shadow:
        0 12px 30px rgba(0,0,0,0.09);
}


.course-top {
    display: flex;

    justify-content: space-between;

    align-items: center;

    margin-bottom: 18px;
}


.course-icon {
    width: 48px;

    height: 48px;

    display: flex;

    justify-content: center;

    align-items: center;

    background: #eef2ff;

    border-radius: 13px;

    font-size: 24px;
}


.course-number {
    font-size: 12px;

    color: #9ca3af;
}


.course-card h3 {
    color: #111827;

    font-size: 18px;

    margin-bottom: 10px;
}


.course-card p {
    color: #6b7280;

    line-height: 1.6;

    font-size: 14px;

    min-height: 65px;

    margin-bottom: 18px;
}


.course-footer {
    padding-top: 15px;

    border-top: 1px solid #eee;

    display: flex;

    justify-content: space-between;

    align-items: center;
}


.course-id {
    color: #9ca3af;

    font-size: 12px;
}


.material-label {
    background: #ecfdf5;

    color: #15803d;

    padding: 6px 9px;

    border-radius: 7px;

    font-size: 11px;

    font-weight: bold;
}


/* =========================================
   EMPTY
========================================= */

.empty {
    background: white;

    padding: 60px 40px;

    border-radius: 17px;

    text-align: center;

    box-shadow:
        0 6px 25px rgba(0,0,0,0.05);
}


.empty-icon {
    width: 70px;

    height: 70px;

    margin: 0 auto 20px;

    display: flex;

    align-items: center;

    justify-content: center;

    background: #eef2ff;

    border-radius: 20px;

    font-size: 34px;
}


.empty h2 {
    margin-bottom: 10px;

    color: #111827;
}


.empty p {
    color: #777;

    font-size: 14px;
}


/* =========================================
   RESPONSIVE
========================================= */

@media (max-width: 1100px) {

    .courses {
        grid-template-columns:
            repeat(2, 1fr);
    }

}


@media (max-width: 750px) {

    .sidebar {
        position: relative;

        width: 100%;

        height: auto;
    }


    .main {
        margin-left: 0;

        padding: 25px;
    }


    .top-bar {
        align-items: flex-start;

        gap: 15px;

        flex-direction: column;
    }


    .courses {
        grid-template-columns: 1fr;
    }


    .form-card {
        padding: 22px;
    }

}

</style>

</head>


<body>


<!-- =========================================
     SIDEBAR
========================================= -->

<div class="sidebar">

    <div class="logo">
        🎓 Virtual Classroom
    </div>


    <a href="<%= contextPath %>/teacher/dashboard.jsp">
        🏠 Dashboard
    </a>


    <a href="<%= contextPath %>/my-courses">
        📚 My Courses
    </a>


    <a
        href="<%= contextPath %>/teacher/study-materials"
        class="active">

        📖 Study Materials

    </a>


    <a href="<%= contextPath %>/teacher/assignments.jsp">
        📝 Assignments
    </a>


    <a href="<%= contextPath %>/teacher/submissions">
        👨‍🎓 Student Submissions
    </a>


    <a href="<%= contextPath %>/teacher/announcements">
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


<!-- =========================================
     MAIN CONTENT
========================================= -->

<div class="main">


    <!-- HEADER -->

    <div class="top-bar">

        <div class="header">

            <h1>
                Study Materials 📖
            </h1>

            <p>
                Upload and manage learning materials
                for your courses.
            </p>

        </div>


        <div class="teacher-badge">

            👨‍🏫 <%= fullname %>

        </div>

    </div>


    <!-- =====================================
         SUCCESS MESSAGE
    ====================================== -->

    <% if ("added".equals(success)) { %>

        <div class="message success">

            ✅ Study material added successfully!

        </div>

    <% } %>


    <!-- =====================================
         ERROR MESSAGES
    ====================================== -->

    <% if ("empty".equals(error)) { %>

        <div class="message error">

            ⚠️ Please select a course and enter a title.

        </div>

    <% } else if ("unauthorized".equals(error)) { %>

        <div class="message error">

            ❌ You are not authorized to add material
            to this course.

        </div>

    <% } else if ("invalid".equals(error)) { %>

        <div class="message error">

            ❌ Invalid course.

        </div>

    <% } else if ("failed".equals(error)) { %>

        <div class="message error">

            ❌ Failed to add study material.
            Please try again.

        </div>

    <% } %>


    <!-- =====================================
         ADD MATERIAL FORM
    ====================================== -->

    <div class="form-card">


        <div class="form-heading">

            <div class="form-heading-icon">
                ➕
            </div>

            <div>

                <h2>
                    Add Study Material
                </h2>

                <p>
                    Add notes, links or learning resources
                    to one of your courses.
                </p>

            </div>

        </div>


        <form
            action="<%= contextPath %>/teacher/study-materials"
            method="post">


            <!-- COURSE -->

            <div class="form-group">

                <label for="courseId">
                    Select Course
                </label>

                <select
                    name="courseId"
                    id="courseId"
                    required>

                    <option value="">
                        -- Select Course --
                    </option>


                    <% if (courses != null &&
                           !courses.isEmpty()) { %>


                        <% for (Course course : courses) { %>

                            <option
                                value="<%= course.getId() %>">

                                <%= course.getCourseName() %>

                            </option>

                        <% } %>


                    <% } %>

                </select>

            </div>


            <!-- TITLE -->

            <div class="form-group">

                <label for="title">
                    Material Title
                </label>

                <input
                    type="text"
                    name="title"
                    id="title"
                    placeholder="Example: Java Introduction Notes"
                    required>

            </div>


            <!-- DESCRIPTION -->

            <div class="form-group">

                <label for="description">
                    Description
                </label>

                <textarea
                    name="description"
                    id="description"
                    placeholder="Briefly describe this study material..."></textarea>

            </div>


            <!-- FILE URL -->

            <div class="form-group">

                <label for="fileUrl">
                    File / Resource URL
                </label>

                <input
                    type="url"
                    name="fileUrl"
                    id="fileUrl"
                    placeholder="https://example.com/material.pdf">

            </div>


            <!-- BUTTON -->

            <button
                type="submit"
                class="add-btn">

                ➕ Add Study Material

            </button>


        </form>

    </div>


    <!-- =====================================
         COURSES
    ====================================== -->

    <div class="section-header">

        <h2>
            📚 Your Courses
        </h2>

        <span class="course-count">

            <%= courses != null ? courses.size() : 0 %>
            Courses

        </span>

    </div>


    <% if (courses != null &&
           !courses.isEmpty()) { %>


        <div class="courses">


            <% for (Course course : courses) { %>


                <div class="course-card">


                    <div class="course-top">

                        <div class="course-icon">
                            📚
                        </div>

                        <div class="course-number">

                            ID #<%= course.getId() %>

                        </div>

                    </div>


                    <h3>

                        <%= course.getCourseName() %>

                    </h3>


                    <p>

                        <%= course.getDescription() != null
                            ? course.getDescription()
                            : "No course description available." %>

                    </p>


                    <div class="course-footer">

                        <div class="course-id">

                            Course ID:

                            <strong>
                                <%= course.getId() %>
                            </strong>

                        </div>


                        <div class="material-label">

                            📖 Materials

                        </div>

                    </div>


                </div>


            <% } %>


        </div>


    <% } else { %>


        <div class="empty">

            <div class="empty-icon">
                📚
            </div>

            <h2>
                No Courses Found
            </h2>

            <p>
                You haven't created any courses yet.
            </p>

        </div>


    <% } %>


</div>


</body>

</html>