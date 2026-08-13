<%@page import="java.util.List"%>
<%@page import="com.virtualclassroom.model.Assignment"%>
<%@page import="com.virtualclassroom.model.Submission"%>
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

List<Assignment> assignments =
        (List<Assignment>) request.getAttribute("assignments");

List<Submission> submissions =
        (List<Submission>) request.getAttribute("submissions");

String contextPath = request.getContextPath();
%>

<!DOCTYPE html>

<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>My Assignments - Virtual Classroom</title>

<style>

/* =========================
   RESET
========================= */

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
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

    background: linear-gradient(
        180deg,
        #4f46e5,
        #4338ca
    );

    color: white;
    padding: 25px 20px;

    box-shadow: 5px 0 20px rgba(0,0,0,0.08);
}

.logo {
    font-size: 22px;
    font-weight: bold;
    text-align: center;
    margin-bottom: 40px;
}

.sidebar a {
    display: block;

    color: white;
    text-decoration: none;

    padding: 13px 15px;
    margin-bottom: 8px;

    border-radius: 9px;

    transition: 0.2s;
}

.sidebar a:hover {
    background: rgba(255,255,255,0.15);
    transform: translateX(3px);
}

/* Active Assignment Link */

.sidebar a.active {
    background: rgba(255,255,255,0.20);
    font-weight: bold;
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
    min-height: 100vh;
}

/* =========================
   PAGE HEADER
========================= */

.header {
    display: flex;
    justify-content: space-between;
    align-items: center;

    margin-bottom: 30px;
}

.header-left h1 {
    font-size: 32px;
    color: #4f46e5;
    margin-bottom: 8px;
}

.header-left p {
    color: #777;
    font-size: 15px;
}

/* =========================
   HEADER BADGE
========================= */

.assignment-count {
    background: white;
    padding: 14px 20px;

    border-radius: 12px;

    box-shadow: 0 5px 20px rgba(0,0,0,0.06);

    text-align: center;
}

.assignment-count span {
    display: block;

    font-size: 24px;
    font-weight: bold;

    color: #4f46e5;
}

.assignment-count small {
    color: #777;
}

/* =========================
   ASSIGNMENT CARD
========================= */

.assignment-card {
    background: white;

    border-radius: 18px;

    padding: 28px;

    margin-bottom: 22px;

    box-shadow: 0 5px 20px rgba(0,0,0,0.06);

    transition: 0.25s;

    position: relative;

    overflow: hidden;
}

.assignment-card::before {
    content: "";

    position: absolute;

    left: 0;
    top: 0;

    width: 5px;
    height: 100%;

    background: #4f46e5;
}

.assignment-card:hover {
    transform: translateY(-4px);

    box-shadow:
        0 12px 30px rgba(0,0,0,0.10);
}

/* =========================
   ASSIGNMENT TOP
========================= */

.assignment-top {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;

    margin-bottom: 20px;
}

.assignment-title-section {
    display: flex;
    align-items: center;
    gap: 15px;
}

.assignment-icon {
    width: 55px;
    height: 55px;

    display: flex;
    align-items: center;
    justify-content: center;

    background: #eef2ff;

    border-radius: 14px;

    font-size: 27px;
}

.assignment-card h2 {
    color: #312e81;

    font-size: 22px;

    margin-bottom: 5px;
}

.assignment-label {
    font-size: 13px;
    color: #888;
}

/* =========================
   INFO
========================= */

.info {
    display: flex;

    gap: 15px;

    margin-bottom: 20px;
}

.info-item {
    background: #f8fafc;

    padding: 12px 16px;

    border-radius: 10px;

    flex: 1;

    border: 1px solid #eef0f5;
}

.info-item span {
    display: block;

    font-size: 12px;

    color: #888;

    margin-bottom: 4px;
}

.info-item strong {
    color: #444;
}

/* =========================
   DESCRIPTION
========================= */

.description {
    background: #fafafa;

    border-radius: 10px;

    padding: 16px;

    margin-bottom: 20px;

    line-height: 1.7;

    color: #666;
}

.description strong {
    color: #333;

    display: block;

    margin-bottom: 6px;
}

/* =========================
   STATUS
========================= */

.status {
    padding: 14px 16px;

    border-radius: 10px;

    margin-bottom: 15px;

    font-size: 14px;
}

.submitted {
    background: #dcfce7;
    color: #15803d;

    border: 1px solid #bbf7d0;
}

.not-submitted {
    background: #fef3c7;
    color: #92400e;

    border: 1px solid #fde68a;
}

/* =========================
   STATUS DOT
========================= */

.status-title {
    font-weight: bold;

    margin-bottom: 4px;
}

.status-date {
    font-size: 13px;

    opacity: 0.8;
}

/* =========================
   GRADED
========================= */

.graded {
    background: linear-gradient(
        135deg,
        #eef2ff,
        #f5f3ff
    );

    padding: 20px;

    border-radius: 12px;

    margin-top: 15px;

    border: 1px solid #e0e7ff;
}

.graded h3 {
    color: #3730a3;

    margin-bottom: 15px;

    font-size: 17px;
}

.marks {
    font-size: 28px;

    font-weight: bold;

    color: #4f46e5;

    margin-bottom: 15px;
}

.marks-label {
    font-size: 13px;

    color: #777;

    font-weight: normal;
}

/* =========================
   FEEDBACK
========================= */

.feedback {
    background: white;

    padding: 16px;

    border-radius: 10px;

    line-height: 1.6;

    color: #555;
}

.feedback-title {
    font-weight: bold;

    color: #3730a3;

    margin-bottom: 8px;
}

/* =========================
   PENDING
========================= */

.pending {
    background: #fff7ed;

    color: #9a3412;

    padding: 14px 16px;

    border-radius: 10px;

    margin-top: 15px;

    border: 1px solid #fed7aa;
}

/* =========================
   SUBMIT BUTTON
========================= */

.submit-btn {
    display: inline-flex;

    align-items: center;

    gap: 8px;

    padding: 12px 20px;

    background: #4f46e5;

    color: white;

    text-decoration: none;

    border-radius: 9px;

    font-weight: bold;

    transition: 0.2s;
}

.submit-btn:hover {
    background: #4338ca;

    transform: translateY(-2px);

    box-shadow:
        0 6px 15px rgba(79,70,229,0.25);
}

/* =========================
   EMPTY STATE
========================= */

.empty {
    background: white;

    padding: 70px 40px;

    text-align: center;

    border-radius: 18px;

    box-shadow: 0 5px 20px rgba(0,0,0,0.06);
}

.empty-icon {
    width: 80px;
    height: 80px;

    margin: 0 auto 20px;

    display: flex;

    align-items: center;

    justify-content: center;

    background: #eef2ff;

    border-radius: 50%;

    font-size: 40px;
}

.empty h2 {
    margin-bottom: 10px;

    color: #333;
}

.empty p {
    color: #777;
}

/* =========================
   RESPONSIVE
========================= */

@media (max-width: 1000px) {

    .main {
        padding: 30px;
    }

    .info {
        flex-direction: column;
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

        padding: 25px 20px;
    }

    .header {
        flex-direction: column;

        align-items: flex-start;

        gap: 20px;
    }

    .assignment-count {
        width: 100%;
    }

    .assignment-card {
        padding: 22px;
    }

    .assignment-top {
        flex-direction: column;

        gap: 15px;
    }

}

</style>

</head>

<body>

<!-- =========================
     SIDEBAR
========================= -->

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

    <a href="<%= contextPath %>/courses">
        🔎 Browse Courses
    </a>

    <a href="<%= contextPath %>/student/study-materials">
        📖 Study Materials
    </a>

    <a href="<%= contextPath %>/student/assignments"
       class="active">
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


<!-- =========================
     MAIN CONTENT
========================= -->

<div class="main">

    <!-- HEADER -->

    <div class="header">

        <div class="header-left">

            <h1>
                My Assignments 📝
            </h1>

            <p>
                View, submit and track your assignments.
            </p>

        </div>

        <div class="assignment-count">

            <span>
                <%= assignments != null
                    ? assignments.size()
                    : 0 %>
            </span>

            <small>
                Assignments
            </small>

        </div>

    </div>


    <!-- =========================
         ASSIGNMENTS
    ========================= -->

    <% if (assignments != null &&
           !assignments.isEmpty()) { %>


        <% for (Assignment assignment : assignments) { %>

            <%

                Submission studentSubmission = null;

                if (submissions != null) {

                    for (Submission submission :
                            submissions) {

                        if (submission.getAssignmentId()
                                == assignment.getId()) {

                            studentSubmission =
                                    submission;

                            break;
                        }
                    }
                }

            %>


            <!-- ASSIGNMENT CARD -->

            <div class="assignment-card">


                <!-- TOP -->

                <div class="assignment-top">

                    <div class="assignment-title-section">

                        <div class="assignment-icon">
                            📝
                        </div>

                        <div>

                            <h2>
                                <%= assignment.getTitle() %>
                            </h2>

                            <div class="assignment-label">
                                Course Assignment
                            </div>

                        </div>

                    </div>

                </div>


                <!-- INFO -->

                <div class="info">

                    <div class="info-item">

                        <span>
                            📚 Course ID
                        </span>

                        <strong>
                            <%= assignment.getCourseId() %>
                        </strong>

                    </div>


                    <div class="info-item">

                        <span>
                            📅 Due Date
                        </span>

                        <strong>
                            <%= assignment.getDueDate() %>
                        </strong>

                    </div>

                </div>


                <!-- DESCRIPTION -->

                <div class="description">

                    <strong>
                        Assignment Description
                    </strong>

                    <%= assignment.getDescription() %>

                </div>


                <!-- =========================
                     SUBMITTED
                ========================= -->

                <% if (studentSubmission != null) { %>


                    <div class="status submitted">

                        <div class="status-title">

                            ✅ Assignment Submitted

                        </div>

                        <div class="status-date">

                            Submitted on:

                            <%= studentSubmission.getSubmittedAt() %>

                        </div>

                    </div>


                    <!-- =========================
                         GRADED
                    ========================= -->

                    <% if (studentSubmission.getMarks()
                            != null) { %>


                        <div class="graded">

                            <h3>
                                🎯 Grade & Feedback
                            </h3>


                            <div class="marks">

                                <%= studentSubmission.getMarks() %>

                                <span class="marks-label">
                                    / 100
                                </span>

                            </div>


                            <div class="feedback">

                                <div class="feedback-title">

                                    💬 Teacher Feedback

                                </div>


                                <%= studentSubmission.getFeedback()
                                        == null ||
                                    studentSubmission.getFeedback()
                                        .trim().isEmpty()

                                    ? "No feedback provided."

                                    : studentSubmission.getFeedback() %>

                            </div>

                        </div>


                    <% } else { %>


                        <!-- WAITING FOR GRADE -->

                        <div class="pending">

                            ⏳

                            <strong>
                                Waiting for teacher to grade
                                your submission.
                            </strong>

                        </div>


                    <% } %>


                <% } else { %>


                    <!-- =========================
                         NOT SUBMITTED
                    ========================= -->

                    <div class="status not-submitted">

                        <div class="status-title">

                            ⚠️ Assignment Not Submitted

                        </div>

                        <div class="status-date">

                            Submit your answer before
                            the due date.

                        </div>

                    </div>


                    <a
                        href="<%= contextPath %>/student/submit-assignment?id=<%= assignment.getId() %>"
                        class="submit-btn">

                        📤 Submit Assignment

                    </a>


                <% } %>


            </div>


        <% } %>


    <% } else { %>


        <!-- =========================
             EMPTY STATE
        ========================= -->

        <div class="empty">

            <div class="empty-icon">
                📝
            </div>

            <h2>
                No Assignments Yet
            </h2>

            <p>
                There are currently no assignments
                for your enrolled courses.
            </p>

        </div>


    <% } %>


</div>

</body>

</html>