```jsp
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // =========================================================
    // SESSION DATA
    // =========================================================

    String fullname =
            (String) session.getAttribute("fullname");

    String role =
            (String) session.getAttribute("role");


    // =========================================================
    // LOGIN CHECK
    // =========================================================

    if (fullname == null ||
        role == null ||
        !"student".equalsIgnoreCase(role)) {

        response.sendRedirect(
                request.getContextPath() + "/login.jsp"
        );

        return;
    }


    String contextPath =
            request.getContextPath();


    // =========================================================
    // DASHBOARD DATA
    // =========================================================

    Object enrollmentCountObj =
            request.getAttribute("enrollmentCount");

    Object assignmentCountObj =
            request.getAttribute("assignmentCount");

    Object completedAssignmentCountObj =
            request.getAttribute("completedAssignmentCount");

    Object progressObj =
            request.getAttribute("progress");


    // =========================================================
    // IMPORTANT:
    // Dashboard JSP must be opened through
    // StudentDashboardServlet.
    //
    // If these attributes are missing, redirect to
    // /student/dashboard so the servlet can load the data.
    // =========================================================

    if (enrollmentCountObj == null ||
        assignmentCountObj == null ||
        completedAssignmentCountObj == null ||
        progressObj == null) {

        response.sendRedirect(
                request.getContextPath() +
                "/student/dashboard"
        );

        return;
    }


    // =========================================================
    // CONVERT DASHBOARD DATA
    // =========================================================

    int enrollmentCount =
            (Integer) enrollmentCountObj;


    int assignmentCount =
            (Integer) assignmentCountObj;


    int completedAssignmentCount =
            (Integer) completedAssignmentCountObj;


    int progress =
            (Integer) progressObj;


    // =========================================================
    // AVATAR LETTER
    // =========================================================

    String avatarLetter = "S";

    if (fullname != null &&
        !fullname.trim().isEmpty()) {

        avatarLetter =
                fullname.substring(0, 1).toUpperCase();
    }
%>


<!DOCTYPE html>

<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>Student Dashboard - Virtual Classroom</title>


<style>

/* =========================================================
   RESET
========================================================= */

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}


/* =========================================================
   BODY
========================================================= */

body {
    font-family:
        Arial,
        Helvetica,
        sans-serif;

    background: #f5f7fb;

    color: #1f2937;
}


/* =========================================================
   SIDEBAR
========================================================= */

.sidebar {

    position: fixed;

    left: 0;
    top: 0;

    width: 250px;
    height: 100vh;

    background:
        linear-gradient(
            180deg,
            #4f46e5,
            #4338ca
        );

    color: white;

    padding: 28px 18px;

    box-shadow:
        5px 0 20px rgba(0,0,0,0.08);

    z-index: 1000;

    overflow-y: auto;
}


/* =========================================================
   LOGO
========================================================= */

.logo {

    text-align: center;

    font-size: 21px;

    font-weight: bold;

    padding-bottom: 30px;

    margin-bottom: 15px;

    border-bottom:
        1px solid
        rgba(255,255,255,0.15);
}


/* =========================================================
   SIDEBAR LINKS
========================================================= */

.sidebar a {

    display: flex;

    align-items: center;

    color:
        rgba(255,255,255,0.9);

    text-decoration: none;

    padding: 13px 15px;

    margin-bottom: 7px;

    border-radius: 10px;

    font-size: 14px;

    transition:
        all 0.25s ease;
}


.sidebar a:hover {

    background:
        rgba(255,255,255,0.15);

    color: white;

    transform:
        translateX(4px);
}


/* =========================================================
   ACTIVE LINK
========================================================= */

.sidebar a.active {

    background:
        rgba(255,255,255,0.18);

    color: white;

    box-shadow:
        inset 3px 0 0 white;
}


/* =========================================================
   LOGOUT
========================================================= */

.logout {

    margin-top: 35px;

    padding-top: 20px;

    border-top:
        1px solid
        rgba(255,255,255,0.15);
}


.logout a {

    background: #dc2626;

    color: white;
}


.logout a:hover {

    background: #b91c1c;

    transform: none;
}


/* =========================================================
   MAIN
========================================================= */

.main {

    margin-left: 250px;

    padding: 40px;

    min-height: 100vh;
}


/* =========================================================
   TOP BAR
========================================================= */

.top-bar {

    display: flex;

    justify-content:
        space-between;

    align-items: center;

    margin-bottom: 30px;
}


.top-bar h1 {

    font-size: 28px;

    color: #111827;
}


.top-bar p {

    margin-top: 5px;

    color: #6b7280;

    font-size: 14px;
}


/* =========================================================
   STUDENT BADGE
========================================================= */

.student-badge {

    display: flex;

    align-items: center;

    gap: 12px;

    background: white;

    padding: 10px 16px;

    border-radius: 12px;

    box-shadow:
        0 5px 18px
        rgba(0,0,0,0.05);
}


/* =========================================================
   AVATAR
========================================================= */

.avatar {

    width: 42px;
    height: 42px;

    border-radius: 50%;

    background:
        linear-gradient(
            135deg,
            #6366f1,
            #8b5cf6
        );

    color: white;

    display: flex;

    align-items: center;

    justify-content: center;

    font-size: 18px;

    font-weight: bold;
}


.student-name {

    font-weight: bold;

    font-size: 14px;
}


.student-role {

    font-size: 12px;

    color: #6b7280;

    margin-top: 2px;
}


/* =========================================================
   WELCOME
========================================================= */

.welcome {

    position: relative;

    overflow: hidden;

    background:
        linear-gradient(
            135deg,
            #4f46e5,
            #6366f1,
            #7c3aed
        );

    color: white;

    padding: 35px;

    border-radius: 20px;

    margin-bottom: 30px;

    box-shadow:
        0 15px 35px
        rgba(79,70,229,0.25);
}


.welcome::before {

    content: "";

    position: absolute;

    width: 180px;
    height: 180px;

    border-radius: 50%;

    background:
        rgba(255,255,255,0.08);

    right: -50px;

    top: -70px;
}


.welcome::after {

    content: "";

    position: absolute;

    width: 120px;
    height: 120px;

    border-radius: 50%;

    background:
        rgba(255,255,255,0.06);

    right: 120px;

    bottom: -60px;
}


.welcome-content {

    position: relative;

    z-index: 2;
}


.welcome h2 {

    font-size: 28px;

    margin-bottom: 10px;
}


.welcome p {

    max-width: 700px;

    color:
        rgba(255,255,255,0.9);

    line-height: 1.7;

    font-size: 15px;
}


/* =========================================================
   STATS
========================================================= */

.stats {

    display: grid;

    grid-template-columns:
        repeat(4, 1fr);

    gap: 20px;

    margin-bottom: 30px;
}


/* =========================================================
   STAT CARD
========================================================= */

.stat-card {

    background: white;

    padding: 22px;

    border-radius: 15px;

    box-shadow:
        0 5px 20px
        rgba(0,0,0,0.05);

    display: flex;

    align-items: center;

    gap: 15px;

    transition:
        all 0.25s ease;
}


.stat-card:hover {

    transform:
        translateY(-4px);

    box-shadow:
        0 12px 28px
        rgba(0,0,0,0.08);
}


/* =========================================================
   STAT ICON
========================================================= */

.stat-icon {

    width: 50px;
    height: 50px;

    border-radius: 12px;

    display: flex;

    align-items: center;

    justify-content: center;

    font-size: 24px;

    background: #eef2ff;

    flex-shrink: 0;
}


/* =========================================================
   STAT NUMBER
========================================================= */

.stat-number {

    font-size: 23px;

    font-weight: bold;

    color: #111827;
}


/* =========================================================
   STAT LABEL
========================================================= */

.stat-label {

    font-size: 12px;

    color: #6b7280;

    margin-top: 4px;
}


/* =========================================================
   SECTION HEADER
========================================================= */

.section-header {

    display: flex;

    justify-content:
        space-between;

    align-items: center;

    margin-bottom: 18px;
}


.section-header h2 {

    font-size: 21px;

    color: #111827;
}


.section-header span {

    color: #6b7280;

    font-size: 13px;
}


/* =========================================================
   CARDS
========================================================= */

.cards {

    display: grid;

    grid-template-columns:
        repeat(3, 1fr);

    gap: 22px;
}


.card {

    position: relative;

    overflow: hidden;

    background: white;

    padding: 26px;

    border-radius: 17px;

    text-decoration: none;

    color: #333;

    box-shadow:
        0 5px 20px
        rgba(0,0,0,0.05);

    border:
        1px solid #f0f0f0;

    transition:
        transform 0.25s ease,
        box-shadow 0.25s ease;
}


.card:hover {

    transform:
        translateY(-7px);

    box-shadow:
        0 15px 35px
        rgba(0,0,0,0.10);
}


/* =========================================================
   CARD ICON
========================================================= */

.card-icon {

    width: 58px;
    height: 58px;

    border-radius: 14px;

    background: #eef2ff;

    display: flex;

    align-items: center;

    justify-content: center;

    font-size: 29px;

    margin-bottom: 18px;
}


/* =========================================================
   CARD TITLE
========================================================= */

.card h3 {

    font-size: 19px;

    color: #4f46e5;

    margin-bottom: 9px;
}


/* =========================================================
   CARD DESCRIPTION
========================================================= */

.card p {

    color: #6b7280;

    font-size: 14px;

    line-height: 1.6;

    padding-right: 20px;
}


/* =========================================================
   CARD ARROW
========================================================= */

.card-arrow {

    position: absolute;

    right: 22px;

    bottom: 20px;

    width: 32px;
    height: 32px;

    border-radius: 50%;

    background: #f5f3ff;

    color: #4f46e5;

    display: flex;

    align-items: center;

    justify-content: center;

    font-size: 17px;

    transition: 0.25s;
}


.card:hover .card-arrow {

    background: #4f46e5;

    color: white;

    transform:
        translateX(4px);
}


/* =========================================================
   FOOTER
========================================================= */

.footer {

    margin-top: 40px;

    padding: 20px 0;

    border-top:
        1px solid #e5e7eb;

    color: #9ca3af;

    font-size: 13px;

    text-align: center;
}


/* =========================================================
   RESPONSIVE
========================================================= */

@media (max-width: 1200px) {

    .stats {

        grid-template-columns:
            repeat(2, 1fr);
    }


    .cards {

        grid-template-columns:
            repeat(2, 1fr);
    }
}


@media (max-width: 800px) {

    .sidebar {

        position: relative;

        width: 100%;

        height: auto;

        padding: 20px;
    }


    .logo {

        margin-bottom: 20px;
    }


    .main {

        margin-left: 0;

        padding: 25px;
    }


    .top-bar {

        flex-direction: column;

        align-items: flex-start;

        gap: 15px;
    }


    .student-badge {

        width: 100%;
    }


    .stats {

        grid-template-columns: 1fr;
    }


    .cards {

        grid-template-columns: 1fr;
    }
}


@media (max-width: 500px) {

    .main {

        padding: 18px;
    }


    .welcome {

        padding: 25px;
    }


    .welcome h2 {

        font-size: 23px;
    }
}

</style>

</head>


<body>


<!-- =========================================================
     SIDEBAR
========================================================= -->

<div class="sidebar">


    <div class="logo">

        🎓 Virtual Classroom

    </div>


    <a
        href="<%= contextPath %>/student/dashboard"
        class="active">

        🏠 &nbsp; Dashboard

    </a>


    <a
        href="<%= contextPath %>/student/my-courses">

        📚 &nbsp; My Courses

    </a>


    <a
        href="<%= contextPath %>/courses">

        🔎 &nbsp; Browse Courses

    </a>


    <a
        href="<%= contextPath %>/student/study-materials">

        📖 &nbsp; Study Materials

    </a>


    <a
        href="<%= contextPath %>/student/assignments">

        📝 &nbsp; Assignments

    </a>


    <a
        href="<%= contextPath %>/student/progress">

        📊 &nbsp; My Progress

    </a>


    <a
        href="<%= contextPath %>/student/announcements">

        📢 &nbsp; Announcements

    </a>


    <a
        href="<%= contextPath %>/profile">

        👤 &nbsp; My Profile

    </a>


    <div class="logout">

        <a
            href="<%= contextPath %>/logout">

            🚪 &nbsp; Logout

        </a>

    </div>

</div>


<!-- =========================================================
     MAIN
========================================================= -->

<div class="main">


    <!-- =====================================================
         TOP BAR
    ===================================================== -->

    <div class="top-bar">


        <div>

            <h1>
                Student Dashboard
            </h1>

            <p>
                Welcome back! Here's what's happening
                in your classroom.
            </p>

        </div>


        <div class="student-badge">


            <div class="avatar">

                <%= avatarLetter %>

            </div>


            <div>

                <div class="student-name">

                    <%= fullname %>

                </div>


                <div class="student-role">

                    Student

                </div>

            </div>

        </div>

    </div>


    <!-- =====================================================
         WELCOME BANNER
    ===================================================== -->

    <div class="welcome">


        <div class="welcome-content">


            <h2>

                Hello, <%= fullname %>! 👋

            </h2>


            <p>

                Keep learning, complete your assignments
                and track your progress. Everything you
                need for your Virtual Classroom is right here.

            </p>


        </div>

    </div>


    <!-- =====================================================
         STATISTICS
    ===================================================== -->

    <div class="stats">


        <!-- ENROLLED COURSES -->

        <div class="stat-card">


            <div class="stat-icon">

                📚

            </div>


            <div>

                <div class="stat-number">

                    <%= enrollmentCount %>

                </div>


                <div class="stat-label">

                    Enrolled Courses

                </div>

            </div>

        </div>


        <!-- ASSIGNMENTS -->

        <div class="stat-card">


            <div class="stat-icon">

                📝

            </div>


            <div>

                <div class="stat-number">

                    <%= assignmentCount %>

                </div>


                <div class="stat-label">

                    Assignments

                </div>

            </div>

        </div>


        <!-- COMPLETED -->

        <div class="stat-card">


            <div class="stat-icon">

                ✅

            </div>


            <div>

                <div class="stat-number">

                    <%= completedAssignmentCount %>

                </div>


                <div class="stat-label">

                    Completed

                </div>

            </div>

        </div>


        <!-- PROGRESS -->

        <div class="stat-card">


            <div class="stat-icon">

                📊

            </div>


            <div>

                <div class="stat-number">

                    <%= progress %>%

                </div>


                <div class="stat-label">

                    Progress

                </div>

            </div>

        </div>

    </div>


    <!-- =====================================================
         QUICK ACCESS
    ===================================================== -->

    <div class="section-header">


        <h2>

            Quick Access

        </h2>


        <span>

            Explore your classroom

        </span>

    </div>


    <!-- =====================================================
         DASHBOARD CARDS
    ===================================================== -->

    <div class="cards">


        <!-- MY COURSES -->

        <a
            href="<%= contextPath %>/student/my-courses"
            class="card">


            <div class="card-icon">

                📚

            </div>


            <h3>

                My Courses

            </h3>


            <p>

                View all courses you are currently
                enrolled in and continue learning.

            </p>


            <div class="card-arrow">

                →

            </div>

        </a>


        <!-- BROWSE COURSES -->

        <a
            href="<%= contextPath %>/courses"
            class="card">


            <div class="card-icon">

                🔎

            </div>


            <h3>

                Browse Courses

            </h3>


            <p>

                Discover available courses and
                enroll in something new.

            </p>


            <div class="card-arrow">

                →

            </div>

        </a>


        <!-- STUDY MATERIALS -->

        <a
            href="<%= contextPath %>/student/study-materials"
            class="card">


            <div class="card-icon">

                📖

            </div>


            <h3>

                Study Materials

            </h3>


            <p>

                Access notes, documents and other
                learning materials from your teachers.

            </p>


            <div class="card-arrow">

                →

            </div>

        </a>


        <!-- ASSIGNMENTS -->

        <a
            href="<%= contextPath %>/student/assignments"
            class="card">


            <div class="card-icon">

                📝

            </div>


            <h3>

                Assignments

            </h3>


            <p>

                View upcoming assignments and
                submit your answers before the deadline.

            </p>


            <div class="card-arrow">

                →

            </div>

        </a>


        <!-- PROGRESS -->

        <a
            href="<%= contextPath %>/student/progress"
            class="card">


            <div class="card-icon">

                📊

            </div>


            <h3>

                My Progress

            </h3>


            <p>

                Track your assignment completion
                and overall learning progress.

            </p>


            <div class="card-arrow">

                →

            </div>

        </a>


        <!-- ANNOUNCEMENTS -->

        <a
            href="<%= contextPath %>/student/announcements"
            class="card">


            <div class="card-icon">

                📢

            </div>


            <h3>

                Announcements

            </h3>


            <p>

                Stay updated with important
                announcements from your teachers.

            </p>


            <div class="card-arrow">

                →

            </div>

        </a>

    </div>


    <!-- =====================================================
         FOOTER
    ===================================================== -->

    <div class="footer">

        🎓 Virtual Classroom &nbsp;•&nbsp;
        Keep learning, keep growing.

    </div>


</div>


</body>

</html>
```
