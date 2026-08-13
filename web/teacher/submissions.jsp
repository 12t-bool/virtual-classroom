```jsp
<%@page import="com.virtualclassroom.model.Submission"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
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

String contextPath = request.getContextPath();

List<Submission> submissions =
        (List<Submission>) request.getAttribute("submissions");

if (submissions == null) {
    submissions = new ArrayList<Submission>();
}

int totalSubmissions = submissions.size();

int pendingReview = 0;
int reviewed = 0;

for (Submission submission : submissions) {

    if (submission.getMarks() == null) {
        pendingReview++;
    } else {
        reviewed++;
    }
}

String error = request.getParameter("error");
String success = request.getParameter("success");
%>


<!DOCTYPE html>

<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>Student Submissions - Virtual Classroom</title>


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

    font-family:
        "Segoe UI",
        Arial,
        sans-serif;

    background:
        radial-gradient(
            circle at 10% 10%,
            rgba(129,140,248,0.13),
            transparent 30%
        ),
        radial-gradient(
            circle at 90% 90%,
            rgba(139,92,246,0.10),
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
            #4f46e5 0%,
            #3730a3 100%
        );

    color: white;

    padding: 25px 18px;

    box-shadow:
        5px 0 25px rgba(0,0,0,0.10);

    z-index: 100;
}


/* =========================================
   LOGO
========================================= */

.logo {

    font-size: 21px;

    font-weight: 800;

    text-align: center;

    margin-bottom: 35px;

    padding-bottom: 20px;

    border-bottom:
        1px solid rgba(255,255,255,0.20);

    letter-spacing: 0.2px;
}


/* =========================================
   SIDEBAR LINKS
========================================= */

.sidebar a {

    display: flex;

    align-items: center;

    gap: 8px;

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
        translateX(3px);
}


/* =========================================
   ACTIVE LINK
========================================= */

.sidebar a.active {

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
        1px solid rgba(255,255,255,0.20);
}


.logout a {

    background:
        rgba(220,38,38,0.95);
}


.logout a:hover {

    background:
        #b91c1c;
}


/* =========================================
   MAIN
========================================= */

.main {

    margin-left: 245px;

    padding: 40px;
}


/* =========================================
   HEADER
========================================= */

.header {

    display: flex;

    justify-content: space-between;

    align-items: flex-start;

    gap: 20px;

    margin-bottom: 30px;
}


.header h1 {

    font-size: 32px;

    color: #312e81;

    margin-bottom: 8px;

    font-weight: 800;
}


.header p {

    color: #6b7280;

    font-size: 15px;
}


/* =========================================
   HEADER ICON
========================================= */

.header-icon {

    width: 62px;
    height: 62px;

    display: flex;

    align-items: center;
    justify-content: center;

    border-radius: 16px;

    background:
        linear-gradient(
            135deg,
            #eef2ff,
            #e0e7ff
        );

    font-size: 29px;

    box-shadow:
        0 8px 20px
        rgba(79,70,229,0.10);
}


/* =========================================
   MESSAGE
========================================= */

.message {

    padding: 14px 18px;

    border-radius: 10px;

    margin-bottom: 22px;

    font-size: 14px;

    font-weight: 600;
}


.message.success {

    background: #dcfce7;

    color: #166534;

    border-left:
        4px solid #16a34a;
}


.message.error {

    background: #fee2e2;

    color: #991b1b;

    border-left:
        4px solid #dc2626;
}


/* =========================================
   STAT GRID
========================================= */

.content-grid {

    display: grid;

    grid-template-columns:
        repeat(3, minmax(0, 1fr));

    gap: 22px;

    margin-bottom: 25px;
}


/* =========================================
   STAT CARD
========================================= */

.stat-card {

    background: white;

    padding: 23px;

    border-radius: 17px;

    border:
        1px solid #eef0f5;

    box-shadow:
        0 6px 25px
        rgba(0,0,0,0.05);

    display: flex;

    align-items: center;

    gap: 16px;

    transition:
        transform 0.25s,
        box-shadow 0.25s;
}


.stat-card:hover {

    transform:
        translateY(-4px);

    box-shadow:
        0 12px 30px
        rgba(0,0,0,0.08);
}


/* =========================================
   STAT ICON
========================================= */

.stat-icon {

    width: 55px;
    height: 55px;

    display: flex;

    align-items: center;
    justify-content: center;

    border-radius: 14px;

    background: #eef2ff;

    font-size: 26px;
}


/* =========================================
   STAT NUMBER
========================================= */

.stat-number {

    font-size: 24px;

    font-weight: 800;

    color: #312e81;
}


/* =========================================
   STAT LABEL
========================================= */

.stat-label {

    font-size: 13px;

    color: #6b7280;

    margin-top: 3px;
}


/* =========================================
   SUBMISSIONS SECTION
========================================= */

.submissions-section {

    margin-top: 10px;
}


/* =========================================
   SECTION HEADER
========================================= */

.section-header {

    background: white;

    padding: 25px 30px;

    border-radius: 18px;

    margin-bottom: 20px;

    border:
        1px solid #eef0f5;

    box-shadow:
        0 6px 25px
        rgba(0,0,0,0.05);
}


.section-header h2 {

    color: #312e81;

    font-size: 22px;

    margin-bottom: 6px;
}


.section-header p {

    color: #6b7280;

    font-size: 14px;
}


/* =========================================
   SUBMISSION LIST
========================================= */

.submission-list {

    display: flex;

    flex-direction: column;

    gap: 18px;
}


/* =========================================
   SUBMISSION CARD
========================================= */

.submission-card {

    background: white;

    border-radius: 18px;

    padding: 25px;

    border:
        1px solid #eef0f5;

    box-shadow:
        0 6px 25px
        rgba(0,0,0,0.05);

    display: flex;

    gap: 20px;

    transition:
        transform 0.25s,
        box-shadow 0.25s;
}


.submission-card:hover {

    transform:
        translateY(-3px);

    box-shadow:
        0 12px 30px
        rgba(0,0,0,0.08);
}


/* =========================================
   SUBMISSION ICON
========================================= */

.submission-icon {

    width: 58px;
    height: 58px;

    min-width: 58px;

    display: flex;

    align-items: center;
    justify-content: center;

    border-radius: 14px;

    background: #eef2ff;

    font-size: 27px;
}


/* =========================================
   SUBMISSION CONTENT
========================================= */

.submission-content {

    flex: 1;
}


/* =========================================
   TOP
========================================= */

.submission-top {

    display: flex;

    justify-content: space-between;

    align-items: flex-start;

    gap: 15px;

    margin-bottom: 18px;
}


.submission-top h3 {

    color: #312e81;

    font-size: 19px;

    margin-bottom: 5px;
}


.submission-top p {

    color: #6b7280;

    font-size: 13px;
}


/* =========================================
   STATUS
========================================= */

.status {

    padding: 7px 12px;

    border-radius: 20px;

    font-size: 12px;

    font-weight: 700;

    white-space: nowrap;
}


.status.pending {

    background: #fff7ed;

    color: #c2410c;

    border:
        1px solid #fed7aa;
}


.status.reviewed {

    background: #dcfce7;

    color: #15803d;

    border:
        1px solid #bbf7d0;
}


/* =========================================
   SUBMISSION DETAILS
========================================= */

.submission-details {

    display: grid;

    grid-template-columns:
        repeat(4, 1fr);

    gap: 12px;

    margin-bottom: 18px;
}


.submission-details > div {

    background: #f8fafc;

    padding: 12px;

    border-radius: 9px;
}


.detail-label {

    display: block;

    color: #9ca3af;

    font-size: 11px;

    margin-bottom: 5px;

    text-transform: uppercase;

    font-weight: 700;
}


.submission-details strong {

    color: #374151;

    font-size: 13px;
}


/* =========================================
   ANSWER PREVIEW
========================================= */

.submission-preview {

    background: #f8fafc;

    border-left:
        4px solid #6366f1;

    padding: 14px;

    border-radius: 8px;

    color: #6b7280;

    font-size: 13px;

    line-height: 1.6;

    margin-bottom: 18px;

    max-height: 85px;

    overflow: hidden;
}


.submission-preview span {

    color: #312e81;

    font-weight: 700;
}


/* =========================================
   ACTION
========================================= */

.submission-action {

    display: flex;

    justify-content: flex-end;
}


/* =========================================
   REVIEW BUTTON
========================================= */

.review-btn {

    display: inline-flex;

    align-items: center;

    gap: 7px;

    padding: 11px 18px;

    border-radius: 9px;

    background: #4f46e5;

    color: white;

    text-decoration: none;

    font-size: 13px;

    font-weight: 700;

    transition: 0.25s;
}


.review-btn:hover {

    background: #4338ca;

    transform:
        translateY(-2px);

    box-shadow:
        0 6px 15px
        rgba(79,70,229,0.20);
}


/* =========================================
   EMPTY CARD
========================================= */

.empty-card {

    background: white;

    padding: 38px;

    border-radius: 20px;

    border:
        1px solid #eef0f5;

    box-shadow:
        0 8px 30px
        rgba(0,0,0,0.06);

    min-height: 350px;

    display: flex;

    flex-direction: column;

    align-items: center;

    justify-content: center;

    text-align: center;
}


.empty-icon {

    width: 90px;
    height: 90px;

    display: flex;

    align-items: center;
    justify-content: center;

    border-radius: 50%;

    background:
        linear-gradient(
            135deg,
            #eef2ff,
            #e0e7ff
        );

    font-size: 42px;

    margin-bottom: 20px;
}


.empty-card h2 {

    color: #312e81;

    margin-bottom: 10px;
}


.empty-card p {

    color: #6b7280;

    max-width: 500px;

    line-height: 1.7;

    margin-bottom: 20px;
}


.info-badge {

    display: inline-flex;

    align-items: center;

    gap: 7px;

    padding: 10px 16px;

    border-radius: 30px;

    background: #f5f3ff;

    color: #5b21b6;

    font-size: 13px;

    font-weight: 600;

    border:
        1px solid #ddd6fe;
}


/* =========================================
   RESPONSIVE
========================================= */

@media (max-width: 1000px) {

    .content-grid {

        grid-template-columns:
            repeat(2, minmax(0, 1fr));
    }

    .submission-details {

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

    .main {

        margin-left: 0;

        padding: 25px;
    }

    .submission-card {

        flex-direction: column;
    }

}


@media (max-width: 600px) {

    .content-grid {

        grid-template-columns: 1fr;
    }

    .submission-details {

        grid-template-columns: 1fr;
    }

    .main {

        padding: 20px;
    }

    .header h1 {

        font-size: 26px;
    }

    .submission-top {

        flex-direction: column;
    }

    .submission-action {

        justify-content: stretch;
    }

    .review-btn {

        width: 100%;

        justify-content: center;
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


    <a href="<%= contextPath %>/teacher/my-courses">

        📚 My Courses

    </a>


    <a href="<%= contextPath %>/teacher/study-materials">

        📖 Study Materials

    </a>


    <a href="<%= contextPath %>/teacher/assignments">

        📝 Assignments

    </a>


    <a href="<%= contextPath %>/teacher/submissions"
       class="active">

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

        <div>

            <h1>
                Student Submissions 👨‍🎓
            </h1>

            <p>
                Review and manage assignments submitted
                by your students.
            </p>

        </div>


        <div class="header-icon">

            📥

        </div>

    </div>


    <!-- =========================================
         SUCCESS / ERROR MESSAGE
    ========================================= -->

    <% if ("graded".equals(success)) { %>

        <div class="message success">

            ✅ Submission graded successfully!

        </div>

    <% } %>


    <% if ("marks".equals(error)) { %>

        <div class="message error">

            ⚠️ Marks must be between 0 and 100.

        </div>

    <% } %>


    <% if ("invalid".equals(error)) { %>

        <div class="message error">

            ❌ Invalid submission information.

        </div>

    <% } %>


    <% if ("failed".equals(error)) { %>

        <div class="message error">

            ❌ Something went wrong. Please try again.

        </div>

    <% } %>


    <% if ("notfound".equals(error)) { %>

        <div class="message error">

            ❌ Submission could not be found.

        </div>

    <% } %>


    <!-- =========================================
         STAT CARDS
    ========================================= -->

    <div class="content-grid">


        <!-- TOTAL -->

        <div class="stat-card">

            <div class="stat-icon">
                📥
            </div>

            <div>

                <div class="stat-number">
                    <%= totalSubmissions %>
                </div>

                <div class="stat-label">
                    Total Submissions
                </div>

            </div>

        </div>


        <!-- PENDING -->

        <div class="stat-card">

            <div class="stat-icon">
                ⏳
            </div>

            <div>

                <div class="stat-number">
                    <%= pendingReview %>
                </div>

                <div class="stat-label">
                    Pending Review
                </div>

            </div>

        </div>


        <!-- REVIEWED -->

        <div class="stat-card">

            <div class="stat-icon">
                ✅
            </div>

            <div>

                <div class="stat-number">
                    <%= reviewed %>
                </div>

                <div class="stat-label">
                    Reviewed
                </div>

            </div>

        </div>


    </div>


    <!-- =========================================
         SUBMISSIONS
    ========================================= -->

    <div class="submissions-section">


        <div class="section-header">

            <h2>
                📥 Submitted Assignments
            </h2>

            <p>
                Review the student's answer and assign marks
                and feedback.
            </p>

        </div>


        <% if (submissions.isEmpty()) { %>


            <!-- EMPTY -->

            <div class="empty-card">

                <div class="empty-icon">
                    📄
                </div>

                <h2>
                    No Submissions Yet
                </h2>

                <p>
                    Submitted assignments from your students
                    will appear here once they start submitting
                    their work.
                </p>

                <div class="info-badge">

                    💡
                    Student submissions will be displayed here

                </div>

            </div>


        <% } else { %>


            <!-- SUBMISSION LIST -->

            <div class="submission-list">


                <% for (Submission submission : submissions) { %>


                    <div class="submission-card">


                        <div class="submission-icon">

                            📝

                        </div>


                        <div class="submission-content">


                            <!-- TOP -->

                            <div class="submission-top">


                                <div>

                                    <h3>

                                        <%= submission.getAssignmentTitle() != null
                                            ? submission.getAssignmentTitle()
                                            : "Assignment #" + submission.getAssignmentId() %>

                                    </h3>


                                    <p>

                                        <%= submission.getCourseName() != null
                                            ? submission.getCourseName()
                                            : "Course" %>

                                    </p>

                                </div>


                                <% if (submission.getMarks() == null) { %>

                                    <span class="status pending">

                                        ⏳ Pending Review

                                    </span>

                                <% } else { %>

                                    <span class="status reviewed">

                                        ✅ Reviewed

                                    </span>

                                <% } %>


                            </div>


                            <!-- DETAILS -->

                            <div class="submission-details">


                                <div>

                                    <span class="detail-label">
                                        👨‍🎓 Student
                                    </span>

                                    <strong>

                                        <%= submission.getStudentName() != null
                                            ? submission.getStudentName()
                                            : "Student #" + submission.getStudentId() %>

                                    </strong>

                                </div>


                                <div>

                                    <span class="detail-label">
                                        🆔 Submission
                                    </span>

                                    <strong>

                                        #<%= submission.getId() %>

                                    </strong>

                                </div>


                                <div>

                                    <span class="detail-label">
                                        🕐 Submitted
                                    </span>

                                    <strong>

                                        <%= submission.getSubmittedAt() %>

                                    </strong>

                                </div>


                                <div>

                                    <span class="detail-label">
                                        📊 Marks
                                    </span>

                                    <strong>

                                        <% if (submission.getMarks() == null) { %>

                                            Not Graded

                                        <% } else { %>

                                            <%= submission.getMarks() %> / 100

                                        <% } %>

                                    </strong>

                                </div>


                            </div>


                            <!-- ANSWER PREVIEW -->

                            <div class="submission-preview">

                                <span>
                                    📄 Answer:
                                </span>

                                <%= submission.getSubmissionText() %>

                            </div>


                            <!-- REVIEW BUTTON -->

                            <div class="submission-action">

                                <a
                                    href="<%= contextPath %>/teacher/review-submission?id=<%= submission.getId() %>"
                                    class="review-btn">

                                    👁️ Review Submission

                                </a>

                            </div>


                        </div>


                    </div>


                <% } %>


            </div>


        <% } %>


    </div>


</div>


</body>

</html>
```
