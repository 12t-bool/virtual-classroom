<%@page import="com.virtualclassroom.model.Assignment"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String fullname = (String) session.getAttribute("fullname");
    String role = (String) session.getAttribute("role");

    if (fullname == null || role == null ||
        !"student".equalsIgnoreCase(role)) {

        response.sendRedirect("../login.jsp");
        return;
    }

    Assignment assignment =
            (Assignment) request.getAttribute("assignment");

    if (assignment == null) {
        response.sendRedirect("assignments");
        return;
    }

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

<title>Submit Assignment - Virtual Classroom</title>

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
    color: #333;
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

    padding: 28px 20px;

    box-shadow: 4px 0 20px rgba(0,0,0,0.08);
}


/* LOGO */

.logo {
    font-size: 21px;
    font-weight: bold;

    text-align: center;

    margin-bottom: 45px;
}


/* NAV LINKS */

.sidebar a {
    display: flex;
    align-items: center;

    color: white;

    text-decoration: none;

    padding: 14px 16px;

    margin-bottom: 9px;

    border-radius: 10px;

    font-size: 15px;

    transition: all 0.25s ease;
}


.sidebar a:hover {
    background: rgba(255,255,255,0.15);

    transform: translateX(4px);
}


/* ACTIVE */

.sidebar a.active {
    background: rgba(255,255,255,0.18);

    font-weight: bold;
}


/* LOGOUT */

.logout {
    margin-top: 35px;
}

.logout a {
    background: #dc2626;
}

.logout a:hover {
    background: #b91c1c;

    transform: translateX(0);
}


/* ==========================================
   MAIN
========================================== */

.main {
    margin-left: 250px;

    padding: 45px;

    min-height: 100vh;
}


/* ==========================================
   HEADER
========================================== */

.header {
    margin-bottom: 30px;
}

.header h1 {
    font-size: 32px;

    color: #4f46e5;

    margin-bottom: 8px;
}

.header p {
    color: #777;

    font-size: 15px;
}


/* ==========================================
   MESSAGE
========================================== */

.message {
    max-width: 900px;

    padding: 15px 18px;

    border-radius: 10px;

    margin-bottom: 25px;

    font-size: 14px;

    font-weight: bold;
}

.error {
    background: #fee2e2;

    color: #b91c1c;

    border-left: 4px solid #dc2626;
}

.success {
    background: #dcfce7;

    color: #15803d;

    border-left: 4px solid #16a34a;
}


/* ==========================================
   ASSIGNMENT CONTAINER
========================================== */

.assignment-box {
    max-width: 900px;

    background: white;

    border-radius: 18px;

    padding: 35px;

    box-shadow:
        0 8px 30px rgba(0,0,0,0.07);

    animation: fadeIn 0.5s ease;
}


/* ==========================================
   TOP SECTION
========================================== */

.assignment-top {
    display: flex;

    align-items: center;

    gap: 18px;

    margin-bottom: 25px;

    padding-bottom: 22px;

    border-bottom: 1px solid #eee;
}


/* ICON */

.assignment-icon {
    width: 65px;
    height: 65px;

    display: flex;
    align-items: center;
    justify-content: center;

    background: #eef2ff;

    border-radius: 15px;

    font-size: 32px;
}


/* TITLE */

.assignment-title h2 {
    color: #4f46e5;

    font-size: 25px;

    margin-bottom: 6px;
}

.assignment-title span {
    color: #888;

    font-size: 13px;
}


/* ==========================================
   DESCRIPTION
========================================== */

.description-title {
    font-size: 17px;

    font-weight: bold;

    margin-bottom: 10px;

    color: #333;
}


.description {
    color: #666;

    line-height: 1.8;

    font-size: 15px;

    margin-bottom: 25px;

    white-space: pre-line;
}


/* ==========================================
   INFO
========================================== */

.info {
    display: grid;

    grid-template-columns: 1fr 1fr;

    gap: 15px;

    margin-bottom: 30px;
}


.info-item {
    background: #f8fafc;

    padding: 17px;

    border-radius: 10px;

    border: 1px solid #eef0f4;
}


.info-label {
    display: block;

    font-size: 12px;

    color: #888;

    margin-bottom: 6px;

    text-transform: uppercase;

    font-weight: bold;
}


.info-value {
    color: #333;

    font-size: 15px;

    font-weight: bold;
}


/* ==========================================
   ANSWER SECTION
========================================== */

.answer-section {
    margin-top: 10px;

    padding-top: 25px;

    border-top: 1px solid #eee;
}


.answer-section h3 {
    font-size: 19px;

    color: #333;

    margin-bottom: 7px;
}


.answer-section p {
    color: #888;

    font-size: 13px;

    margin-bottom: 18px;
}


/* ==========================================
   TEXTAREA
========================================== */

.form-group {
    margin-bottom: 20px;
}


textarea {
    width: 100%;

    min-height: 240px;

    padding: 16px;

    border: 1px solid #d9dce3;

    border-radius: 12px;

    font-family: Arial, sans-serif;

    font-size: 15px;

    line-height: 1.6;

    resize: vertical;

    transition: all 0.2s ease;
}


textarea::placeholder {
    color: #aaa;
}


textarea:focus {
    outline: none;

    border-color: #4f46e5;

    box-shadow:
        0 0 0 3px rgba(79,70,229,0.1);
}


/* ==========================================
   BUTTONS
========================================== */

.button-row {
    display: flex;

    gap: 12px;

    margin-top: 18px;
}


.submit-btn {
    flex: 1;

    padding: 15px;

    border: none;

    border-radius: 10px;

    background: #4f46e5;

    color: white;

    font-size: 15px;

    font-weight: bold;

    cursor: pointer;

    transition: all 0.25s ease;
}


.submit-btn:hover {
    background: #4338ca;

    transform: translateY(-2px);

    box-shadow:
        0 7px 15px rgba(79,70,229,0.2);
}


.cancel-btn {
    padding: 15px 25px;

    border-radius: 10px;

    background: #f1f5f9;

    color: #475569;

    text-decoration: none;

    font-size: 15px;

    font-weight: bold;

    transition: 0.25s;
}


.cancel-btn:hover {
    background: #e2e8f0;
}


/* ==========================================
   FOOT NOTE
========================================== */

.note {
    margin-top: 20px;

    padding: 13px 15px;

    background: #fff7ed;

    border-radius: 9px;

    color: #9a3412;

    font-size: 13px;

    border-left: 4px solid #f97316;
}


/* ==========================================
   ANIMATION
========================================== */

@keyframes fadeIn {

    from {
        opacity: 0;

        transform: translateY(10px);
    }

    to {
        opacity: 1;

        transform: translateY(0);
    }

}


/* ==========================================
   RESPONSIVE
========================================== */

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

        padding: 25px 18px;
    }

    .info {
        grid-template-columns: 1fr;
    }

    .assignment-box {
        padding: 25px;
    }

}


@media (max-width: 500px) {

    .header h1 {
        font-size: 26px;
    }

    .assignment-top {
        align-items: flex-start;
    }

    .assignment-title h2 {
        font-size: 21px;
    }

    .button-row {
        flex-direction: column;
    }

    .cancel-btn {
        text-align: center;
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


    <a href="<%= contextPath %>/courses">
        📖 Browse Courses
    </a>


    <a href="<%= contextPath %>/student/assignments"
       class="active">

        📝 Assignments

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
     MAIN CONTENT
========================================== -->

<div class="main">


    <div class="header">

        <h1>
            Submit Assignment 📝
        </h1>

        <p>
            Complete your assignment and submit your answer.
        </p>

    </div>


    <!-- ==========================================
         MESSAGES
    ========================================== -->

    <% if ("empty".equals(error)) { %>

        <div class="message error">

            ⚠️ Please enter your answer before submitting.

        </div>

    <% } else if ("already".equals(error)) { %>

        <div class="message error">

            ⚠️ You have already submitted this assignment.

        </div>

    <% } else if ("invalid".equals(error)) { %>

        <div class="message error">

            ❌ Invalid assignment.

        </div>

    <% } else if ("failed".equals(error)) { %>

        <div class="message error">

            ❌ Submission failed. Please try again.

        </div>

    <% } else if ("submitted".equals(success)) { %>

        <div class="message success">

            🎉 Assignment submitted successfully!

        </div>

    <% } %>


    <!-- ==========================================
         ASSIGNMENT CARD
    ========================================== -->

    <div class="assignment-box">


        <!-- TOP -->

        <div class="assignment-top">

            <div class="assignment-icon">
                📝
            </div>


            <div class="assignment-title">

                <h2>
                    <%= assignment.getTitle() %>
                </h2>

                <span>
                    Assignment Submission
                </span>

            </div>

        </div>


        <!-- DESCRIPTION -->

        <div class="description-title">

            📋 Assignment Instructions

        </div>


        <div class="description">

            <%= assignment.getDescription() %>

        </div>


        <!-- INFORMATION -->

        <div class="info">


            <div class="info-item">

                <span class="info-label">
                    📚 Course
                </span>

                <span class="info-value">

                    Course #<%= assignment.getCourseId() %>

                </span>

            </div>


            <div class="info-item">

                <span class="info-label">
                    🕐 Due Date
                </span>

                <span class="info-value">

                    <%= assignment.getDueDate() %>

                </span>

            </div>


        </div>


        <!-- ANSWER -->

        <div class="answer-section">

            <h3>
                ✍️ Your Answer
            </h3>

            <p>
                Write your complete answer below before submitting.
            </p>


            <form
                action="<%= contextPath %>/student/submit-assignment"
                method="post">


                <input
                    type="hidden"
                    name="assignmentId"
                    value="<%= assignment.getId() %>">


                <div class="form-group">

                    <textarea
                        id="submissionText"
                        name="submissionText"
                        placeholder="Start writing your answer here..."
                        required></textarea>

                </div>


                <div class="button-row">


                    <button
                        type="submit"
                        class="submit-btn">

                        📤 Submit Assignment

                    </button>


                    <a
                        href="<%= contextPath %>/student/assignments"
                        class="cancel-btn">

                        ← Back to Assignments

                    </a>


                </div>


            </form>


            <div class="note">

                💡 Make sure your answer is complete before submitting.
                You may not be able to submit the same assignment again.

            </div>

        </div>


    </div>


</div>


</body>

</html>