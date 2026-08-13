<%@page import="java.util.List"%>
<%@page import="com.virtualclassroom.model.Progress"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
String fullname = (String) session.getAttribute("fullname");
String role = (String) session.getAttribute("role");

if (fullname == null || role == null ||
    !"student".equalsIgnoreCase(role)) {

    response.sendRedirect(
        request.getContextPath() + "/login.jsp"
    );

    return;
}

List<Progress> progressList =
        (List<Progress>) request.getAttribute("progressList");

String contextPath = request.getContextPath();
%>

<!DOCTYPE html>

<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>My Progress - Virtual Classroom</title>

<style>

/* ==========================================
   RESET
========================================== */

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}


/* ==========================================
   BODY
========================================== */

body {
    font-family: Arial, sans-serif;
    background: #f5f7fb;
    color: #1f2937;
}


/* ==========================================
   SIDEBAR
========================================== */

.sidebar {
    position: fixed;
    left: 0;
    top: 0;

    width: 250px;
    height: 100vh;

    background: linear-gradient(
        180deg,
        #4f46e5,
        #4338ca
    );

    color: white;

    padding: 25px 18px;

    box-shadow:
        4px 0 20px rgba(0,0,0,0.08);

    z-index: 100;
}


/* LOGO */

.logo {
    font-size: 21px;
    font-weight: bold;

    text-align: center;

    margin-bottom: 40px;

    padding-bottom: 25px;

    border-bottom:
        1px solid rgba(255,255,255,0.2);
}


/* SIDEBAR LINKS */

.sidebar a {
    display: flex;
    align-items: center;

    color: white;

    text-decoration: none;

    padding: 13px 15px;

    margin-bottom: 7px;

    border-radius: 10px;

    font-size: 14px;

    transition:
        background 0.25s ease,
        transform 0.25s ease;
}


.sidebar a:hover {
    background:
        rgba(255,255,255,0.15);

    transform:
        translateX(4px);
}


/* ACTIVE LINK */

.sidebar a.active {
    background: white;
    color: #4f46e5;

    font-weight: bold;

    box-shadow:
        0 5px 15px rgba(0,0,0,0.12);
}


/* LOGOUT */

.logout {
    margin-top: 30px;

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


/* ==========================================
   MAIN CONTENT
========================================== */

.main {
    margin-left: 250px;

    padding: 40px;
}


/* ==========================================
   HEADER
========================================== */

.header {
    display: flex;

    justify-content: space-between;

    align-items: center;

    margin-bottom: 35px;
}


.header-left h1 {
    font-size: 32px;

    color: #111827;

    margin-bottom: 8px;
}


.header-left h1 span {
    color: #4f46e5;
}


.header-left p {
    color: #6b7280;

    font-size: 15px;
}


/* USER BADGE */

.user-badge {
    display: flex;

    align-items: center;

    gap: 12px;

    background: white;

    padding: 10px 15px;

    border-radius: 12px;

    box-shadow:
        0 5px 18px rgba(0,0,0,0.05);
}


.user-avatar {
    width: 42px;
    height: 42px;

    border-radius: 50%;

    background: #eef2ff;

    display: flex;
    align-items: center;
    justify-content: center;

    font-size: 20px;
}


.user-info strong {
    display: block;

    font-size: 14px;

    color: #111827;
}


.user-info span {
    font-size: 12px;

    color: #6b7280;
}


/* ==========================================
   OVERVIEW
========================================== */

.overview {
    display: grid;

    grid-template-columns:
        repeat(3, 1fr);

    gap: 20px;

    margin-bottom: 30px;
}


.overview-card {
    background: white;

    border-radius: 16px;

    padding: 22px;

    box-shadow:
        0 5px 20px rgba(0,0,0,0.05);

    display: flex;

    align-items: center;

    gap: 16px;

    transition:
        transform 0.25s ease,
        box-shadow 0.25s ease;
}


.overview-card:hover {
    transform:
        translateY(-4px);

    box-shadow:
        0 12px 30px rgba(0,0,0,0.08);
}


.overview-icon {
    width: 55px;
    height: 55px;

    border-radius: 14px;

    background: #eef2ff;

    display: flex;
    align-items: center;
    justify-content: center;

    font-size: 25px;
}


.overview-text span {
    display: block;

    color: #6b7280;

    font-size: 13px;

    margin-bottom: 5px;
}


.overview-text strong {
    font-size: 25px;

    color: #111827;
}


/* ==========================================
   SECTION HEADER
========================================== */

.section-header {
    display: flex;

    justify-content: space-between;

    align-items: center;

    margin-bottom: 20px;
}


.section-header h2 {
    font-size: 21px;

    color: #111827;
}


.section-header p {
    color: #6b7280;

    font-size: 13px;
}


/* ==========================================
   PROGRESS GRID
========================================== */

.progress-grid {
    display: grid;

    grid-template-columns:
        repeat(3, 1fr);

    gap: 22px;
}


/* ==========================================
   PROGRESS CARD
========================================== */

.progress-card {
    background: white;

    padding: 25px;

    border-radius: 18px;

    box-shadow:
        0 5px 20px rgba(0,0,0,0.05);

    transition:
        transform 0.25s ease,
        box-shadow 0.25s ease;

    position: relative;

    overflow: hidden;
}


.progress-card::before {
    content: "";

    position: absolute;

    left: 0;
    top: 0;

    width: 100%;
    height: 4px;

    background:
        linear-gradient(
            90deg,
            #4f46e5,
            #7c3aed
        );
}


.progress-card:hover {
    transform:
        translateY(-5px);

    box-shadow:
        0 15px 35px rgba(0,0,0,0.08);
}


/* COURSE HEADER */

.course-header {
    display: flex;

    align-items: center;

    justify-content: space-between;

    margin-bottom: 20px;
}


.course-icon {
    width: 50px;
    height: 50px;

    background: #eef2ff;

    border-radius: 13px;

    display: flex;
    align-items: center;
    justify-content: center;

    font-size: 25px;
}


.course-status {
    font-size: 11px;

    font-weight: bold;

    padding: 6px 10px;

    border-radius: 20px;

    background: #dcfce7;

    color: #15803d;
}


/* COURSE NAME */

.progress-card h2 {
    font-size: 19px;

    color: #111827;

    margin-bottom: 20px;

    min-height: 23px;
}


/* ==========================================
   STATISTICS
========================================== */

.stats {
    display: grid;

    grid-template-columns:
        1fr 1fr;

    gap: 12px;

    margin-bottom: 22px;
}


.stat {
    background: #f8fafc;

    padding: 15px;

    border-radius: 11px;

    text-align: center;

    border:
        1px solid #f1f5f9;
}


.stat-number {
    font-size: 23px;

    font-weight: bold;

    color: #4f46e5;

    margin-bottom: 5px;
}


.stat-label {
    font-size: 11px;

    color: #6b7280;
}


/* ==========================================
   PROGRESS
========================================== */

.progress-container {
    margin-top: 10px;
}


.progress-label {
    display: flex;

    justify-content: space-between;

    align-items: center;

    margin-bottom: 9px;

    font-size: 13px;

    font-weight: bold;
}


.progress-label span:last-child {
    color: #4f46e5;
}


/* PROGRESS BAR */

.progress-bar {
    width: 100%;

    height: 10px;

    background: #e5e7eb;

    border-radius: 20px;

    overflow: hidden;
}


.progress-fill {
    height: 100%;

    background:
        linear-gradient(
            90deg,
            #4f46e5,
            #7c3aed
        );

    border-radius: 20px;

    width: 0;

    animation:
        progressAnimation 1.2s ease forwards;
}


/* ==========================================
   ANIMATION
========================================== */

@keyframes progressAnimation {

    from {
        width: 0;
    }

}


/* ==========================================
   EMPTY STATE
========================================== */

.empty {
    background: white;

    padding: 70px 40px;

    border-radius: 18px;

    text-align: center;

    box-shadow:
        0 5px 20px rgba(0,0,0,0.05);
}


.empty-icon {
    width: 80px;
    height: 80px;

    margin:
        0 auto 20px;

    border-radius: 50%;

    background: #eef2ff;

    display: flex;
    align-items: center;
    justify-content: center;

    font-size: 38px;
}


.empty h2 {
    margin-bottom: 10px;

    color: #111827;
}


.empty p {
    color: #6b7280;

    max-width: 450px;

    margin: auto;

    line-height: 1.6;
}


/* ==========================================
   RESPONSIVE
========================================== */

@media (max-width: 1100px) {

    .progress-grid {
        grid-template-columns:
            repeat(2, 1fr);
    }

    .overview {
        grid-template-columns:
            repeat(3, 1fr);
    }

}


@media (max-width: 850px) {

    .sidebar {
        width: 210px;
    }

    .main {
        margin-left: 210px;
        padding: 25px;
    }

    .progress-grid {
        grid-template-columns: 1fr;
    }

}


@media (max-width: 700px) {

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

    .header {
        flex-direction: column;

        align-items: flex-start;

        gap: 20px;
    }

    .overview {
        grid-template-columns: 1fr;
    }

}


@media (max-width: 450px) {

    .main {
        padding: 18px;
    }

    .header-left h1 {
        font-size: 26px;
    }

    .progress-card {
        padding: 20px;
    }

}

</style>

</head>

<body>


<!-- ==========================================
     SIDEBAR
========================================== -->

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


    <a href="<%= contextPath %>/student/study-materials">
        📖 Study Materials
    </a>


    <a href="<%= contextPath %>/student/assignments">
        📝 Assignments
    </a>


    <a
        href="<%= contextPath %>/student/progress"
        class="active">

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


<!-- ==========================================
     MAIN
========================================== -->

<div class="main">


    <!-- HEADER -->

    <div class="header">

        <div class="header-left">

            <h1>
                My <span>Progress</span> 📊
            </h1>

            <p>
                Track your learning progress and assignment
                completion.
            </p>

        </div>


        <div class="user-badge">

            <div class="user-avatar">
                👨‍🎓
            </div>

            <div class="user-info">

                <strong>
                    <%= fullname %>
                </strong>

                <span>
                    Student
                </span>

            </div>

        </div>

    </div>


    <!-- ==========================================
         OVERVIEW
    ========================================== -->

    <%
        int totalCourses = 0;
        int totalAssignments = 0;
        int totalSubmitted = 0;

        if (progressList != null) {

            totalCourses = progressList.size();

            for (Progress progress : progressList) {

                totalAssignments +=
                    progress.getTotalAssignments();

                totalSubmitted +=
                    progress.getSubmittedAssignments();

            }
        }

        int overallPercentage = 0;

        if (totalAssignments > 0) {

            overallPercentage =
                (int) Math.round(
                    ((double) totalSubmitted /
                    totalAssignments) * 100
                );
        }
    %>


    <div class="overview">


        <!-- COURSES -->

        <div class="overview-card">

            <div class="overview-icon">
                📚
            </div>

            <div class="overview-text">

                <span>
                    Total Courses
                </span>

                <strong>
                    <%= totalCourses %>
                </strong>

            </div>

        </div>


        <!-- ASSIGNMENTS -->

        <div class="overview-card">

            <div class="overview-icon">
                📝
            </div>

            <div class="overview-text">

                <span>
                    Assignments
                </span>

                <strong>
                    <%= totalAssignments %>
                </strong>

            </div>

        </div>


        <!-- COMPLETION -->

        <div class="overview-card">

            <div class="overview-icon">
                🎯
            </div>

            <div class="overview-text">

                <span>
                    Overall Completion
                </span>

                <strong>
                    <%= overallPercentage %>%
                </strong>

            </div>

        </div>

    </div>


    <!-- ==========================================
         SECTION HEADER
    ========================================== -->

    <div class="section-header">

        <div>

            <h2>
                Course Progress
            </h2>

            <p>
                Your assignment completion by course
            </p>

        </div>

    </div>


    <!-- ==========================================
         PROGRESS
    ========================================== -->

    <% if (progressList != null &&
           !progressList.isEmpty()) { %>


        <div class="progress-grid">


            <% for (Progress progress : progressList) {

                double percentage =
                    progress.getPercentage();

                String status;

                if (percentage >= 100) {
                    status = "Completed";
                }
                else if (percentage >= 50) {
                    status = "In Progress";
                }
                else {
                    status = "Getting Started";
                }

            %>


                <div class="progress-card">


                    <!-- COURSE HEADER -->

                    <div class="course-header">

                        <div class="course-icon">
                            📚
                        </div>

                        <div class="course-status">

                            <%= status %>

                        </div>

                    </div>


                    <!-- COURSE NAME -->

                    <h2>

                        <%= progress.getCourseName() %>

                    </h2>


                    <!-- STATISTICS -->

                    <div class="stats">


                        <div class="stat">

                            <div class="stat-number">

                                <%= progress.getTotalAssignments() %>

                            </div>

                            <div class="stat-label">

                                Total Assignments

                            </div>

                        </div>


                        <div class="stat">

                            <div class="stat-number">

                                <%= progress.getSubmittedAssignments() %>

                            </div>

                            <div class="stat-label">

                                Submitted

                            </div>

                        </div>


                    </div>


                    <!-- PROGRESS -->

                    <div class="progress-container">


                        <div class="progress-label">

                            <span>
                                Completion
                            </span>

                            <span>

                                <%= String.format(
                                    "%.0f",
                                    percentage
                                ) %>%

                            </span>

                        </div>


                        <div class="progress-bar">

                            <div
                                class="progress-fill"
                                style="width: <%= percentage %>%;">
                            </div>

                        </div>


                    </div>


                </div>


            <% } %>


        </div>


    <% } else { %>


        <!-- ==========================================
             EMPTY STATE
        ========================================== -->

        <div class="empty">


            <div class="empty-icon">
                📊
            </div>


            <h2>
                No Progress Available
            </h2>


            <p>

                Enroll in a course and complete assignments
                to start tracking your learning progress.

            </p>


        </div>


    <% } %>


</div>


</body>

</html>