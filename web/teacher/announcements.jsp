<%@page import="java.util.List"%>
<%@page import="com.virtualclassroom.model.Course"%>
<%@page import="com.virtualclassroom.model.Announcement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
String fullname = (String) session.getAttribute("fullname");
String role = (String) session.getAttribute("role");

if (fullname == null || role == null ||
!"teacher".equalsIgnoreCase(role)) {

    response.sendRedirect(request.getContextPath() + "/login.jsp");
    return;
}

List<Course> courses =
(List<Course>) request.getAttribute("courses");

List<Announcement> announcements =
(List<Announcement>) request.getAttribute("announcements");

String success = request.getParameter("success");
String error = request.getParameter("error");

String contextPath = request.getContextPath();
%>

<!DOCTYPE html>

<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>Announcements - Virtual Classroom</title>

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

    background:
        radial-gradient(
            circle at top right,
            #eef2ff 0,
            transparent 30%
        ),
        #f5f7fb;

    color: #1f2937;

    min-height: 100vh;
}


/* =========================================
   SIDEBAR
========================================= */

.sidebar {
    position: fixed;

    left: 0;
    top: 0;

    width: 245px;
    height: 100vh;

    background:
        linear-gradient(
            180deg,
            #4f46e5,
            #3730a3
        );

    color: white;

    padding: 25px 18px;

    box-shadow:
        5px 0 25px rgba(0,0,0,0.08);

    z-index: 100;
}


/* =========================================
   LOGO
========================================= */

.logo {
    font-size: 21px;

    font-weight: bold;

    text-align: center;

    margin-bottom: 35px;

    padding-bottom: 20px;

    border-bottom:
        1px solid rgba(255,255,255,0.2);
}


/* =========================================
   SIDEBAR LINKS
========================================= */

.sidebar a {
    display: flex;

    align-items: center;

    gap: 9px;

    color: white;

    text-decoration: none;

    padding: 13px 15px;

    margin-bottom: 7px;

    border-radius: 10px;

    transition:
        background 0.25s,
        transform 0.25s;
}


.sidebar a:hover {
    background:
        rgba(255,255,255,0.15);

    transform:
        translateX(4px);
}


/* =========================================
   ACTIVE ANNOUNCEMENT LINK
========================================= */

.sidebar a[href*="announcements"] {
    background:
        rgba(255,255,255,0.18);

    box-shadow:
        inset 3px 0 0 white;
}


/* =========================================
   LOGOUT
========================================= */

.logout {
    margin-top: 25px;

    padding-top: 20px;

    border-top:
        1px solid rgba(255,255,255,0.2);
}


.logout a {
    background: #dc2626;
}


.logout a:hover {
    background: #b91c1c;
}


/* =========================================
   MAIN
========================================= */

.main {
    margin-left: 245px;

    padding: 40px;

    min-height: 100vh;
}


/* =========================================
   HEADER
========================================= */

.header {
    display: flex;

    justify-content: space-between;

    align-items: center;

    margin-bottom: 30px;
}


.header-content h1 {
    font-size: 32px;

    color: #312e81;

    margin-bottom: 8px;
}


.header-content p {
    color: #6b7280;

    font-size: 15px;
}


/* =========================================
   TEACHER BADGE
========================================= */

.teacher-badge {
    display: flex;

    align-items: center;

    gap: 10px;

    padding: 10px 15px;

    background: white;

    border-radius: 12px;

    box-shadow:
        0 5px 18px rgba(0,0,0,0.05);

    color: #4f46e5;

    font-size: 14px;

    font-weight: bold;
}


.teacher-avatar {
    width: 35px;
    height: 35px;

    display: flex;

    align-items: center;
    justify-content: center;

    border-radius: 50%;

    background: #eef2ff;

    font-size: 18px;
}


/* =========================================
   MESSAGES
========================================= */

.message {
    padding: 15px 18px;

    border-radius: 11px;

    margin-bottom: 25px;

    font-weight: bold;

    display: flex;

    align-items: center;

    gap: 10px;
}


.success {
    background: #dcfce7;

    color: #15803d;

    border-left:
        5px solid #22c55e;
}


.error {
    background: #fee2e2;

    color: #b91c1c;

    border-left:
        5px solid #ef4444;
}


/* =========================================
   CREATE FORM CARD
========================================= */

.form-card {
    max-width: 850px;

    background:
        rgba(255,255,255,0.98);

    padding: 35px;

    border-radius: 20px;

    box-shadow:
        0 8px 30px rgba(0,0,0,0.06);

    border:
        1px solid #eef0f5;

    position: relative;

    overflow: hidden;

    margin-bottom: 40px;
}


.form-card::before {
    content: "";

    position: absolute;

    top: 0;
    left: 0;

    width: 100%;
    height: 5px;

    background:
        linear-gradient(
            90deg,
            #4f46e5,
            #7c3aed
        );
}


/* =========================================
   FORM HEADING
========================================= */

.form-heading {
    display: flex;

    align-items: center;

    gap: 15px;

    margin-bottom: 30px;
}


.form-icon {
    width: 58px;
    height: 58px;

    display: flex;

    align-items: center;
    justify-content: center;

    border-radius: 15px;

    background: #eef2ff;

    font-size: 28px;
}


.form-heading h2 {
    color: #312e81;

    font-size: 22px;

    margin-bottom: 5px;
}


.form-heading p {
    color: #9ca3af;

    font-size: 13px;
}


/* =========================================
   FORM GROUP
========================================= */

.form-group {
    margin-bottom: 23px;
}


.form-group label {
    display: block;

    margin-bottom: 9px;

    font-size: 14px;

    font-weight: bold;

    color: #374151;
}


.form-group input,
.form-group select,
.form-group textarea {
    width: 100%;

    padding: 14px 15px;

    border:
        1px solid #d1d5db;

    border-radius: 10px;

    background: #f9fafb;

    color: #111827;

    font-family: Arial, sans-serif;

    font-size: 15px;

    transition:
        border 0.2s,
        box-shadow 0.2s,
        background 0.2s;
}


.form-group input:hover,
.form-group select:hover,
.form-group textarea:hover {
    border-color: #a5b4fc;
}


.form-group input:focus,
.form-group select:focus,
.form-group textarea:focus {
    outline: none;

    background: white;

    border-color: #4f46e5;

    box-shadow:
        0 0 0 4px
        rgba(79,70,229,0.10);
}


/* =========================================
   SELECT
========================================= */

.form-group select {
    cursor: pointer;
}


/* =========================================
   TEXTAREA
========================================= */

.form-group textarea {
    min-height: 150px;

    resize: vertical;

    line-height: 1.6;
}


/* =========================================
   FIELD HINT
========================================= */

.field-hint {
    margin-top: 6px;

    color: #9ca3af;

    font-size: 12px;
}


/* =========================================
   SUBMIT BUTTON
========================================= */

.submit-btn {
    width: 100%;

    padding: 15px;

    border: none;

    border-radius: 11px;

    background:
        linear-gradient(
            135deg,
            #4f46e5,
            #6366f1
        );

    color: white;

    font-size: 15px;

    font-weight: bold;

    cursor: pointer;

    box-shadow:
        0 8px 18px
        rgba(79,70,229,0.20);

    transition:
        transform 0.2s,
        box-shadow 0.2s;
}


.submit-btn:hover {
    transform:
        translateY(-2px);

    box-shadow:
        0 12px 25px
        rgba(79,70,229,0.28);
}


.submit-btn:active {
    transform:
        translateY(0);
}


/* =========================================
   SECTION HEADER
========================================= */

.section-header {
    display: flex;

    align-items: center;

    justify-content: space-between;

    margin-bottom: 20px;
}


.section-title {
    color: #312e81;

    font-size: 23px;

    display: flex;

    align-items: center;

    gap: 9px;
}


.announcement-count {
    background: #eef2ff;

    color: #4f46e5;

    padding: 6px 12px;

    border-radius: 20px;

    font-size: 13px;

    font-weight: bold;
}


/* =========================================
   ANNOUNCEMENT CARD
========================================= */

.announcement-card {
    background: white;

    padding: 25px;

    border-radius: 18px;

    box-shadow:
        0 7px 25px rgba(0,0,0,0.06);

    border:
        1px solid #eef0f5;

    margin-bottom: 20px;

    position: relative;

    overflow: hidden;

    transition:
        transform 0.25s,
        box-shadow 0.25s;
}


.announcement-card::before {
    content: "";

    position: absolute;

    left: 0;
    top: 0;

    width: 5px;
    height: 100%;

    background:
        linear-gradient(
            180deg,
            #4f46e5,
            #7c3aed
        );
}


.announcement-card:hover {
    transform:
        translateY(-4px);

    box-shadow:
        0 14px 32px rgba(0,0,0,0.09);
}


/* =========================================
   ANNOUNCEMENT TOP
========================================= */

.announcement-top {
    display: flex;

    align-items: flex-start;

    gap: 15px;

    margin-bottom: 15px;
}


.announcement-icon {
    width: 52px;
    height: 52px;

    flex-shrink: 0;

    display: flex;

    align-items: center;
    justify-content: center;

    border-radius: 14px;

    background: #eef2ff;

    font-size: 25px;
}


.announcement-card h2 {
    color: #312e81;

    font-size: 20px;

    line-height: 1.4;
}


/* =========================================
   ANNOUNCEMENT MESSAGE
========================================= */

.announcement-message {
    line-height: 1.7;

    color: #4b5563;

    margin-bottom: 20px;

    white-space: pre-line;

    padding-left: 67px;
}


/* =========================================
   ANNOUNCEMENT INFO
========================================= */

.announcement-info {
    margin-left: 67px;

    padding-top: 15px;

    border-top:
        1px solid #edf0f5;

    display: flex;

    flex-wrap: wrap;

    gap: 18px;

    color: #9ca3af;

    font-size: 13px;
}


.info-item {
    display: flex;

    align-items: center;

    gap: 5px;
}


.info-item strong {
    color: #4f46e5;
}


/* =========================================
   EMPTY STATE
========================================= */

.empty {
    background: white;

    padding: 65px 40px;

    text-align: center;

    border-radius: 18px;

    box-shadow:
        0 7px 25px rgba(0,0,0,0.06);

    border:
        1px solid #eef0f5;
}


.empty-icon {
    width: 90px;
    height: 90px;

    margin:
        0 auto 20px;

    display: flex;

    align-items: center;
    justify-content: center;

    border-radius: 50%;

    background: #eef2ff;

    font-size: 42px;
}


.empty h2 {
    color: #312e81;

    margin-bottom: 10px;

    font-size: 23px;
}


.empty p {
    color: #6b7280;

    line-height: 1.6;
}


/* =========================================
   RESPONSIVE
========================================= */

@media (max-width: 900px) {

    .sidebar {
        position: relative;

        width: 100%;

        height: auto;
    }


    .main {
        margin-left: 0;

        padding: 30px;
    }


    .header {
        align-items: flex-start;

        gap: 20px;
    }

}


@media (max-width: 600px) {

    .main {
        padding: 20px;
    }


    .header {
        flex-direction: column;
    }


    .teacher-badge {
        width: 100%;

        justify-content: center;
    }


    .form-card {
        padding: 25px 20px;
    }


    .announcement-card {
        padding: 22px 18px;
    }


    .announcement-message,
    .announcement-info {
        margin-left: 0;

        padding-left: 0;
    }


    .announcement-top {
        gap: 10px;
    }


    .section-header {
        align-items: flex-start;

        gap: 10px;
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


    <a href="<%= contextPath %>/teacher/my-courses.jsp">
        📚 My Courses
    </a>


    <a href="<%= contextPath %>/teacher/study-materials">
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
     MAIN
========================================= -->

<div class="main">


    <!-- HEADER -->

    <div class="header">

        <div class="header-content">

            <h1>
                Announcements 📢
            </h1>

            <p>
                Create and share important updates with your students.
            </p>

        </div>


        <div class="teacher-badge">

            <div class="teacher-avatar">
                👨‍🏫
            </div>

            <span>
                Teacher Panel
            </span>

        </div>

    </div>


    <!-- =========================================
         SUCCESS
    ========================================= -->

    <% if ("added".equals(success)) { %>

        <div class="message success">

            <span>✓</span>

            <span>
                Announcement created successfully!
            </span>

        </div>

    <% } %>


    <!-- =========================================
         ERRORS
    ========================================= -->

    <% if ("empty".equals(error)) { %>

        <div class="message error">

            <span>⚠</span>

            <span>
                Please fill in all required fields.
            </span>

        </div>

    <% } else if ("unauthorized".equals(error)) { %>

        <div class="message error">

            <span>❌</span>

            <span>
                You are not authorized to post announcements
                for this course.
            </span>

        </div>

    <% } else if ("invalid".equals(error)) { %>

        <div class="message error">

            <span>❌</span>

            <span>
                Invalid course selected.
            </span>

        </div>

    <% } else if ("failed".equals(error)) { %>

        <div class="message error">

            <span>❌</span>

            <span>
                Failed to create announcement. Please try again.
            </span>

        </div>

    <% } %>


    <!-- =========================================
         CREATE ANNOUNCEMENT
    ========================================= -->

    <div class="form-card">


        <div class="form-heading">

            <div class="form-icon">
                📢
            </div>

            <div>

                <h2>
                    Create Announcement
                </h2>

                <p>
                    Share important information with your students
                </p>

            </div>

        </div>


        <form
            action="<%= contextPath %>/teacher/announcements"
            method="post">


            <!-- COURSE -->

            <div class="form-group">

                <label>
                    📚 Select Course
                </label>


                <select
                    name="courseId"
                    required>

                    <option value="">
                        -- Select Course --
                    </option>


                    <% if (courses != null) {

                        for (Course course : courses) {
                    %>

                        <option
                            value="<%= course.getId() %>">

                            <%= course.getCourseName() %>

                        </option>

                    <%
                        }
                    }
                    %>

                </select>


                <div class="field-hint">
                    Choose the course where this announcement will appear.
                </div>

            </div>


            <!-- TITLE -->

            <div class="form-group">

                <label>
                    ✏️ Announcement Title
                </label>


                <input
                    type="text"
                    name="title"
                    placeholder="e.g. Important Class Update"
                    required>


                <div class="field-hint">
                    Use a short and clear title that gets students' attention.
                </div>

            </div>


            <!-- MESSAGE -->

            <div class="form-group">

                <label>
                    📝 Message
                </label>


                <textarea
                    name="message"
                    placeholder="Write your announcement here..."
                    required></textarea>


                <div class="field-hint">
                    Include all the important information your students need.
                </div>

            </div>


            <!-- BUTTON -->

            <button
                type="submit"
                class="submit-btn">

                📢 Create Announcement

            </button>


        </form>

    </div>


    <!-- =========================================
         ANNOUNCEMENTS HEADER
    ========================================= -->

    <div class="section-header">

        <h2 class="section-title">

            📢 Your Announcements

        </h2>


        <% if (announcements != null &&
               !announcements.isEmpty()) { %>

            <div class="announcement-count">

                <%= announcements.size() %>
                Published

            </div>

        <% } %>

    </div>


    <!-- =========================================
         ANNOUNCEMENTS
    ========================================= -->

    <% if (announcements != null &&
           !announcements.isEmpty()) { %>


        <% for (Announcement announcement : announcements) { %>


            <div class="announcement-card">


                <div class="announcement-top">


                    <div class="announcement-icon">
                        📢
                    </div>


                    <div>

                        <h2>
                            <%= announcement.getTitle() %>
                        </h2>

                    </div>


                </div>


                <div class="announcement-message">

                    <%= announcement.getMessage() %>

                </div>


                <div class="announcement-info">


                    <div class="info-item">

                        📚

                        <span>
                            Course ID:
                        </span>

                        <strong>
                            <%= announcement.getCourseId() %>
                        </strong>

                    </div>


                    <div class="info-item">

                        🕐

                        <span>
                            Created:
                        </span>

                        <strong>
                            <%= announcement.getCreatedAt() %>
                        </strong>

                    </div>


                </div>


            </div>


        <% } %>


    <% } else { %>


        <!-- =========================================
             EMPTY STATE
        ========================================= -->

        <div class="empty">


            <div class="empty-icon">
                📢
            </div>


            <h2>
                No Announcements Yet
            </h2>


            <p>
                You haven't created any announcements yet.
                Create your first announcement above to keep
                your students informed.
            </p>


        </div>


    <% } %>


</div>


</body>

</html>