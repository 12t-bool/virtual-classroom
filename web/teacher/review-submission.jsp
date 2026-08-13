<%@page import="com.virtualclassroom.model.Submission"%>
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

    Submission submission =
            (Submission) request.getAttribute("submission");

    if (submission == null) {

        response.sendRedirect(
            request.getContextPath() + "/teacher/submissions"
        );

        return;
    }

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

<title>Review Submission - Virtual Classroom</title>

<style>

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: "Segoe UI", Arial, sans-serif;
    background: #f5f7fb;
    color: #1f2937;
    min-height: 100vh;
}

/* SIDEBAR */

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

.logo {
    font-size: 21px;
    font-weight: 800;

    text-align: center;

    margin-bottom: 35px;

    padding-bottom: 20px;

    border-bottom:
        1px solid rgba(255,255,255,0.20);
}

.sidebar a {
    display: flex;
    align-items: center;

    gap: 8px;

    color: white;

    text-decoration: none;

    padding: 13px 15px;

    margin-bottom: 7px;

    border-radius: 10px;

    transition: 0.25s;
}

.sidebar a:hover {
    background: rgba(255,255,255,0.15);
    transform: translateX(3px);
}

.sidebar a.active {
    background: rgba(255,255,255,0.18);

    box-shadow:
        inset 3px 0 0 white;
}

.logout {
    margin-top: 25px;

    padding-top: 20px;

    border-top:
        1px solid rgba(255,255,255,0.20);
}

.logout a {
    background: rgba(220,38,38,0.95);
}

.logout a:hover {
    background: #b91c1c;
}

/* MAIN */

.main {
    margin-left: 245px;
    padding: 40px;
}

/* HEADER */

.header {
    margin-bottom: 25px;
}

.header h1 {
    font-size: 32px;
    color: #312e81;
    margin-bottom: 8px;
}

.header p {
    color: #6b7280;
}

/* MESSAGE */

.message {
    max-width: 900px;

    padding: 14px 18px;

    border-radius: 10px;

    margin-bottom: 20px;

    font-weight: 600;
}

.error {
    background: #fee2e2;
    color: #b91c1c;
}

.success {
    background: #dcfce7;
    color: #15803d;
}

/* CARD */

.review-card {
    max-width: 950px;

    background: white;

    border-radius: 20px;

    padding: 35px;

    box-shadow:
        0 8px 30px rgba(0,0,0,0.06);

    border:
        1px solid #eef0f5;
}

/* STUDENT */

.student-header {
    display: flex;

    align-items: center;

    gap: 18px;

    padding-bottom: 25px;

    border-bottom: 1px solid #eee;

    margin-bottom: 25px;
}

.student-icon {
    width: 65px;
    height: 65px;

    display: flex;

    align-items: center;
    justify-content: center;

    border-radius: 15px;

    background: #eef2ff;

    font-size: 30px;
}

.student-info h2 {
    color: #312e81;

    font-size: 23px;

    margin-bottom: 5px;
}

.student-info p {
    color: #777;

    font-size: 14px;
}

/* DETAILS */

.details {
    display: grid;

    grid-template-columns:
        repeat(2, 1fr);

    gap: 15px;

    margin-bottom: 30px;
}

.detail-box {
    background: #f8fafc;

    padding: 17px;

    border-radius: 10px;

    border: 1px solid #eef0f4;
}

.detail-label {
    display: block;

    color: #888;

    font-size: 12px;

    font-weight: bold;

    text-transform: uppercase;

    margin-bottom: 6px;
}

.detail-value {
    font-size: 15px;

    font-weight: 600;

    color: #333;
}

/* ANSWER */

.answer-title {
    font-size: 19px;

    font-weight: 700;

    color: #312e81;

    margin-bottom: 12px;
}

.answer-box {
    background: #f8fafc;

    border: 1px solid #e2e8f0;

    border-radius: 12px;

    padding: 22px;

    min-height: 180px;

    line-height: 1.8;

    color: #374151;

    white-space: pre-wrap;

    margin-bottom: 30px;
}

/* GRADE */

.grade-section {
    border-top: 1px solid #eee;

    padding-top: 28px;
}

.grade-section h3 {
    font-size: 20px;

    color: #312e81;

    margin-bottom: 20px;
}

.form-group {
    margin-bottom: 20px;
}

.form-group label {
    display: block;

    font-size: 14px;

    font-weight: 700;

    color: #374151;

    margin-bottom: 8px;
}

.marks-input {
    width: 180px;

    padding: 13px 15px;

    border: 1px solid #d1d5db;

    border-radius: 9px;

    font-size: 16px;
}

.marks-input:focus {
    outline: none;

    border-color: #4f46e5;

    box-shadow:
        0 0 0 3px rgba(79,70,229,0.1);
}

textarea {
    width: 100%;

    min-height: 130px;

    padding: 15px;

    border: 1px solid #d1d5db;

    border-radius: 10px;

    font-family: Arial, sans-serif;

    font-size: 15px;

    resize: vertical;
}

textarea:focus {
    outline: none;

    border-color: #4f46e5;

    box-shadow:
        0 0 0 3px rgba(79,70,229,0.1);
}

/* BUTTONS */

.button-row {
    display: flex;

    gap: 12px;

    margin-top: 25px;
}

.grade-btn {
    padding: 14px 25px;

    border: none;

    border-radius: 9px;

    background: #4f46e5;

    color: white;

    font-size: 15px;

    font-weight: bold;

    cursor: pointer;

    transition: 0.25s;
}

.grade-btn:hover {
    background: #4338ca;

    transform: translateY(-2px);
}

.back-btn {
    padding: 14px 25px;

    border-radius: 9px;

    background: #f1f5f9;

    color: #475569;

    text-decoration: none;

    font-weight: bold;
}

.back-btn:hover {
    background: #e2e8f0;
}

/* REVIEWED */

.reviewed {
    background: #ecfdf5;

    border: 1px solid #bbf7d0;

    padding: 20px;

    border-radius: 12px;

    margin-bottom: 25px;
}

.reviewed strong {
    color: #15803d;
}

.reviewed p {
    margin-top: 8px;

    color: #374151;
}

@media (max-width: 800px) {

    .sidebar {
        position: relative;

        width: 100%;

        height: auto;
    }

    .main {
        margin-left: 0;

        padding: 25px;
    }

    .details {
        grid-template-columns: 1fr;
    }
}

</style>

</head>

<body>

<!-- SIDEBAR -->

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


<!-- MAIN -->

<div class="main">

    <div class="header">

        <h1>
            Review Submission 📝
        </h1>

        <p>
            Read the student's answer and assign marks and feedback.
        </p>

    </div>


    <!-- MESSAGES -->

    <% if ("marks".equals(error)) { %>

        <div class="message error">
            ⚠️ Marks must be between 0 and 100.
        </div>

    <% } else if ("invalid".equals(error)) { %>

        <div class="message error">
            ❌ Invalid submission information.
        </div>

    <% } else if ("failed".equals(error)) { %>

        <div class="message error">
            ❌ Failed to save the grade. Please try again.
        </div>

    <% } %>


    <div class="review-card">


        <!-- STUDENT HEADER -->

        <div class="student-header">

            <div class="student-icon">
                👨‍🎓
            </div>

            <div class="student-info">

                <h2>
                    <%= submission.getStudentName() != null
                        ? submission.getStudentName()
                        : "Student #" + submission.getStudentId() %>
                </h2>

                <p>
                    Submission #<%= submission.getId() %>
                </p>

            </div>

        </div>


        <!-- DETAILS -->

        <div class="details">

            <div class="detail-box">

                <span class="detail-label">
                    Assignment
                </span>

                <span class="detail-value">

                    <%= submission.getAssignmentTitle() != null
                        ? submission.getAssignmentTitle()
                        : "Assignment #" + submission.getAssignmentId() %>

                </span>

            </div>


            <div class="detail-box">

                <span class="detail-label">
                    Course
                </span>

                <span class="detail-value">

                    <%= submission.getCourseName() != null
                        ? submission.getCourseName()
                        : "Course" %>

                </span>

            </div>


            <div class="detail-box">

                <span class="detail-label">
                    Submitted At
                </span>

                <span class="detail-value">

                    <%= submission.getSubmittedAt() %>

                </span>

            </div>


            <div class="detail-box">

                <span class="detail-label">
                    Current Marks
                </span>

                <span class="detail-value">

                    <%= submission.getMarks() != null
                        ? submission.getMarks() + " / 100"
                        : "Not Graded Yet" %>

                </span>

            </div>

        </div>


        <!-- ANSWER -->

        <div class="answer-title">
            📄 Student's Answer
        </div>

        <div class="answer-box">
<%= submission.getSubmissionText() %>
        </div>


        <!-- PREVIOUS GRADE -->

        <% if (submission.getMarks() != null) { %>

            <div class="reviewed">

                <strong>
                    ✅ This submission has already been graded.
                </strong>

                <p>
                    Marks:
                    <strong>
                        <%= submission.getMarks() %> / 100
                    </strong>
                </p>

                <p>
                    Feedback:
                    <%= submission.getFeedback() != null
                        && !submission.getFeedback().trim().isEmpty()
                        ? submission.getFeedback()
                        : "No feedback provided." %>
                </p>

            </div>

        <% } %>


        <!-- GRADING -->

        <div class="grade-section">

            <h3>
                ✏️ Grade Student
            </h3>


            <form
                action="<%= contextPath %>/teacher/grade-submission"
                method="post">


                <input
                    type="hidden"
                    name="submissionId"
                    value="<%= submission.getId() %>">


                <div class="form-group">

                    <label for="marks">
                        Marks (0 - 100)
                    </label>

                    <input
                        type="number"
                        id="marks"
                        name="marks"
                        class="marks-input"
                        min="0"
                        max="100"
                        value="<%= submission.getMarks() != null
                                ? submission.getMarks()
                                : "" %>"
                        required>

                </div>


                <div class="form-group">

                    <label for="feedback">
                        Feedback
                    </label>

                    <textarea
                        id="feedback"
                        name="feedback"
                        placeholder="Write feedback for the student..."><%= submission.getFeedback() != null
                                ? submission.getFeedback()
                                : "" %></textarea>

                </div>


                <div class="button-row">

                    <button
                        type="submit"
                        class="grade-btn">

                        ✅ Save Grade

                    </button>


                    <a
                        href="<%= contextPath %>/teacher/submissions"
                        class="back-btn">

                        ← Back to Submissions

                    </a>

                </div>

            </form>

        </div>


    </div>

</div>

</body>

</html>