<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // ==========================================
    // SESSION CHECK
    // ==========================================

    String fullname =
            (String) session.getAttribute("fullname");

    String role =
            (String) session.getAttribute("role");

    if (fullname == null ||
        role == null ||
        !"teacher".equalsIgnoreCase(role)) {

        response.sendRedirect(
                request.getContextPath() +
                "/login.jsp"
        );

        return;
    }

    String contextPath =
            request.getContextPath();


    // ==========================================
    // GET ERROR
    // ==========================================

    String error =
            request.getParameter("error");
%>


<!DOCTYPE html>

<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>Create Course - Virtual Classroom</title>


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
   ACTIVE
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

    min-height: 100vh;

    padding: 40px;

    display: flex;

    justify-content: center;

    align-items: flex-start;
}


/* =========================================
   CONTAINER
========================================= */

.container {

    width: 100%;

    max-width: 850px;
}


/* =========================================
   HEADER
========================================= */

.header {

    display: flex;

    justify-content: space-between;

    align-items: center;

    margin-bottom: 25px;
}


.header h1 {

    font-size: 32px;

    color: #312e81;

    margin-bottom: 7px;

    font-weight: 800;
}


.header p {

    color: #6b7280;

    font-size: 15px;
}


/* =========================================
   BACK BUTTON
========================================= */

.back-btn {

    display: inline-flex;

    align-items: center;

    gap: 7px;

    padding: 11px 16px;

    background: white;

    color: #4f46e5;

    text-decoration: none;

    border-radius: 10px;

    border:
        1px solid #e0e7ff;

    font-size: 14px;

    font-weight: 600;

    transition: 0.2s;
}


.back-btn:hover {

    background: #eef2ff;

    transform:
        translateY(-2px);
}


/* =========================================
   CARD
========================================= */

.card {

    background: white;

    border-radius: 20px;

    padding: 38px;

    border:
        1px solid #eef0f5;

    box-shadow:
        0 8px 30px
        rgba(0,0,0,0.06);

    position: relative;

    overflow: hidden;
}


.card::before {

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
   FORM GROUP
========================================= */

.form-group {

    margin-bottom: 23px;
}


.form-group label {

    display: block;

    font-size: 14px;

    font-weight: 700;

    color: #374151;

    margin-bottom: 8px;
}


.required {

    color: #dc2626;
}


/* =========================================
   INPUT
========================================= */

.form-control {

    width: 100%;

    padding: 13px 15px;

    border:
        1px solid #d1d5db;

    border-radius: 10px;

    font-family:
        "Segoe UI",
        Arial,
        sans-serif;

    font-size: 14px;

    color: #1f2937;

    outline: none;

    transition:
        border-color 0.2s,
        box-shadow 0.2s;
}


.form-control:focus {

    border-color: #6366f1;

    box-shadow:
        0 0 0 3px
        rgba(99,102,241,0.12);
}


/* =========================================
   TEXTAREA
========================================= */

textarea.form-control {

    min-height: 150px;

    resize: vertical;

    line-height: 1.6;
}


/* =========================================
   BUTTON AREA
========================================= */

.button-row {

    display: flex;

    justify-content: flex-end;

    gap: 12px;

    padding-top: 10px;
}


/* =========================================
   CANCEL
========================================= */

.cancel-btn {

    padding: 13px 20px;

    background: #f3f4f6;

    color: #4b5563;

    border-radius: 10px;

    text-decoration: none;

    font-size: 14px;

    font-weight: 700;

    transition: 0.2s;
}


.cancel-btn:hover {

    background: #e5e7eb;
}


/* =========================================
   CREATE BUTTON
========================================= */

.create-btn {

    border: none;

    padding: 13px 22px;

    background:
        linear-gradient(
            135deg,
            #4f46e5,
            #7c3aed
        );

    color: white;

    border-radius: 10px;

    font-size: 14px;

    font-weight: 700;

    cursor: pointer;

    box-shadow:
        0 6px 18px
        rgba(79,70,229,0.25);

    transition:
        transform 0.2s,
        box-shadow 0.2s;
}


.create-btn:hover {

    transform:
        translateY(-2px);

    box-shadow:
        0 9px 22px
        rgba(79,70,229,0.32);
}


/* =========================================
   ERROR
========================================= */

.error-message {

    background: #fef2f2;

    color: #b91c1c;

    border:
        1px solid #fecaca;

    padding: 13px 16px;

    border-radius: 10px;

    margin-bottom: 22px;

    font-size: 14px;

    font-weight: 600;
}


/* =========================================
   RESPONSIVE
========================================= */

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


    .header {

        flex-direction: column;

        align-items: flex-start;

        gap: 15px;
    }
}


@media (max-width: 600px) {

    .main {

        padding: 20px;
    }


    .card {

        padding: 25px 20px;
    }


    .button-row {

        flex-direction: column;
    }


    .cancel-btn,
    .create-btn {

        text-align: center;

        width: 100%;
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


    <a href="<%= contextPath %>/teacher/my-courses"
       class="active">

        📚 My Courses

    </a>


    <a href="<%= contextPath %>/teacher/study-materials">

        📖 Study Materials

    </a>


    <a href="<%= contextPath %>/teacher/assignments">

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


    <div class="container">


        <!-- =========================================
             HEADER
        ========================================= -->

        <div class="header">


            <div>

                <h1>
                    Create Course 📚
                </h1>

                <p>
                    Create a new course for your students.
                </p>

            </div>


            <a href="<%= contextPath %>/teacher/my-courses"
               class="back-btn">

                ← Back to My Courses

            </a>


        </div>


        <!-- =========================================
             ERROR MESSAGE
        ========================================= -->

        <% if ("empty".equals(error)) { %>

            <div class="error-message">

                ⚠️ Please enter a course name.

            </div>

        <% } %>


        <% if ("failed".equals(error)) { %>

            <div class="error-message">

                ❌ Course could not be created.
                Please try again.

            </div>

        <% } %>


        <!-- =========================================
             FORM CARD
        ========================================= -->

        <div class="card">


            <form
                action="<%= contextPath %>/teacher/create-course"
                method="post">


                <!-- COURSE NAME -->

                <div class="form-group">

                    <label for="courseName">

                        Course Name
                        <span class="required">*</span>

                    </label>


                    <input
                        type="text"
                        id="courseName"
                        name="courseName"
                        class="form-control"
                        placeholder="Enter course name"
                        maxlength="150"
                        required>

                </div>


                <!-- DESCRIPTION -->

                <div class="form-group">

                    <label for="description">

                        Course Description

                    </label>


                    <textarea
                        id="description"
                        name="description"
                        class="form-control"
                        placeholder="Enter a description for your course..."
                        maxlength="1000"></textarea>

                </div>


                <!-- BUTTONS -->

                <div class="button-row">


                    <a
                        href="<%= contextPath %>/teacher/my-courses"
                        class="cancel-btn">

                        Cancel

                    </a>


                    <button
                        type="submit"
                        class="create-btn">

                        ➕ Create Course

                    </button>


                </div>


            </form>


        </div>


    </div>


</div>


</body>

</html>