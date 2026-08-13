<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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

    String success = request.getParameter("success");
    String error = request.getParameter("error");
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Create Course - Virtual Classroom</title>

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
            min-height: 100vh;

            background:
                radial-gradient(
                    circle at top right,
                    rgba(124, 58, 237, 0.10),
                    transparent 30%
                ),
                radial-gradient(
                    circle at bottom left,
                    rgba(79, 70, 229, 0.08),
                    transparent 30%
                ),
                #f5f7fb;

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

            background:
                linear-gradient(
                    180deg,
                    #4f46e5 0%,
                    #4338ca 55%,
                    #3730a3 100%
                );

            color: white;

            padding: 25px 18px;

            box-shadow:
                8px 0 30px rgba(31, 41, 55, 0.10);

            z-index: 100;
        }


        /* ==========================================
           LOGO
        ========================================== */

        .logo {
            display: flex;

            align-items: center;
            justify-content: center;

            gap: 9px;

            font-size: 21px;

            font-weight: 800;

            margin-bottom: 38px;

            padding: 14px 8px;

            border-radius: 14px;

            background: rgba(255,255,255,0.10);

            border: 1px solid rgba(255,255,255,0.12);

            letter-spacing: 0.2px;
        }


        /* ==========================================
           NAVIGATION
        ========================================== */

        .sidebar a {
            display: flex;

            align-items: center;

            color: rgba(255,255,255,0.88);

            text-decoration: none;

            padding: 13px 15px;

            margin-bottom: 7px;

            border-radius: 11px;

            font-size: 14px;

            font-weight: 600;

            transition:
                background 0.2s ease,
                transform 0.2s ease,
                color 0.2s ease;
        }


        .sidebar a:hover {
            background: rgba(255,255,255,0.14);

            color: white;

            transform: translateX(3px);
        }


        /* ==========================================
           ACTIVE PAGE
        ========================================== */

        .sidebar a.active {
            background: white;

            color: #4f46e5;

            box-shadow:
                0 8px 20px rgba(0,0,0,0.12);
        }


        .sidebar a.active:hover {
            background: white;

            color: #4338ca;

            transform: translateX(3px);
        }


        /* ==========================================
           LOGOUT
        ========================================== */

        .logout {
            position: absolute;

            left: 18px;
            right: 18px;

            bottom: 25px;
        }


        .logout a {
            background: rgba(220,38,38,0.92);

            color: white;

            justify-content: center;
        }


        .logout a:hover {
            background: #dc2626;

            transform: translateY(-2px);
        }


        /* ==========================================
           MAIN
        ========================================== */

        .main {
            margin-left: 250px;

            min-height: 100vh;

            padding: 45px;
        }


        /* ==========================================
           HEADER
        ========================================== */

        .header {
            margin-bottom: 30px;

            animation: fadeDown 0.5s ease;
        }


        .header h1 {
            font-size: 32px;

            color: #111827;

            margin-bottom: 9px;

            font-weight: 800;
        }


        .header h1 span {
            color: #4f46e5;
        }


        .header p {
            color: #6b7280;

            font-size: 15px;

            line-height: 1.6;
        }


        /* ==========================================
           ALERTS
        ========================================== */

        .success,
        .error {
            max-width: 760px;

            padding: 15px 18px;

            border-radius: 12px;

            margin-bottom: 22px;

            font-size: 14px;

            font-weight: 600;

            display: flex;

            align-items: center;

            gap: 9px;

            animation: fadeUp 0.4s ease;
        }


        .success {
            background: #ecfdf5;

            color: #047857;

            border: 1px solid #a7f3d0;

            box-shadow:
                0 5px 15px rgba(16,185,129,0.08);
        }


        .error {
            background: #fef2f2;

            color: #b91c1c;

            border: 1px solid #fecaca;

            box-shadow:
                0 5px 15px rgba(239,68,68,0.08);
        }


        /* ==========================================
           FORM CARD
        ========================================== */

        .form-container {
            width: 100%;

            max-width: 760px;

            background: rgba(255,255,255,0.96);

            padding: 38px;

            border-radius: 20px;

            border: 1px solid #e5e7eb;

            box-shadow:
                0 20px 45px rgba(31,41,55,0.08);

            position: relative;

            overflow: hidden;

            animation: fadeUp 0.55s ease;
        }


        .form-container::before {
            content: "";

            position: absolute;

            top: 0;
            left: 0;

            width: 100%;
            height: 4px;

            background:
                linear-gradient(
                    90deg,
                    #4f46e5,
                    #7c3aed,
                    #6366f1
                );
        }


        /* ==========================================
           FORM INTRO
        ========================================== */

        .form-top {
            display: flex;

            align-items: center;

            gap: 18px;

            margin-bottom: 32px;

            padding-bottom: 25px;

            border-bottom: 1px solid #eef0f4;
        }


        .form-icon {
            width: 58px;
            height: 58px;

            flex-shrink: 0;

            display: flex;

            align-items: center;
            justify-content: center;

            border-radius: 16px;

            background:
                linear-gradient(
                    135deg,
                    #eef2ff,
                    #ede9fe
                );

            font-size: 27px;

            box-shadow:
                0 8px 18px rgba(79,70,229,0.10);
        }


        .form-title h2 {
            font-size: 21px;

            color: #111827;

            margin-bottom: 5px;
        }


        .form-title p {
            color: #6b7280;

            font-size: 13px;
        }


        /* ==========================================
           FORM GROUP
        ========================================== */

        .form-group {
            margin-bottom: 24px;
        }


        .form-group label {
            display: block;

            font-size: 14px;

            font-weight: 700;

            color: #374151;

            margin-bottom: 9px;
        }


        /* ==========================================
           INPUTS
        ========================================== */

        .input-wrapper {
            position: relative;
        }


        .input-icon {
            position: absolute;

            left: 15px;
            top: 50%;

            transform: translateY(-50%);

            font-size: 17px;

            pointer-events: none;
        }


        .form-group input,
        .form-group textarea {
            width: 100%;

            padding: 14px 15px;

            border: 1px solid #d9dde5;

            border-radius: 11px;

            background: #f9fafb;

            color: #111827;

            font-size: 15px;

            font-family: Arial, sans-serif;

            transition:
                border 0.2s ease,
                box-shadow 0.2s ease,
                background 0.2s ease;
        }


        .form-group input {
            padding-left: 44px;
        }


        .form-group textarea {
            min-height: 165px;

            resize: vertical;

            line-height: 1.6;
        }


        .form-group input::placeholder,
        .form-group textarea::placeholder {
            color: #9ca3af;
        }


        .form-group input:hover,
        .form-group textarea:hover {
            border-color: #a5b4fc;
        }


        .form-group input:focus,
        .form-group textarea:focus {
            outline: none;

            background: white;

            border-color: #4f46e5;

            box-shadow:
                0 0 0 4px rgba(79,70,229,0.10);
        }


        /* ==========================================
           TEXTAREA ICON
        ========================================== */

        .textarea-wrapper {
            position: relative;
        }


        .textarea-icon {
            position: absolute;

            left: 15px;
            top: 16px;

            font-size: 17px;
        }


        .textarea-wrapper textarea {
            padding-left: 44px;
        }


        /* ==========================================
           BUTTON
        ========================================== */

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

            font-weight: 700;

            cursor: pointer;

            box-shadow:
                0 10px 22px rgba(79,70,229,0.22);

            transition:
                transform 0.2s ease,
                box-shadow 0.2s ease;
        }


        .submit-btn:hover {
            transform: translateY(-2px);

            box-shadow:
                0 14px 28px rgba(79,70,229,0.30);
        }


        .submit-btn:active {
            transform: translateY(0);
        }


        /* ==========================================
           SMALL INFO
        ========================================== */

        .form-note {
            margin-top: 18px;

            text-align: center;

            font-size: 12px;

            color: #9ca3af;
        }


        /* ==========================================
           ANIMATIONS
        ========================================== */

        @keyframes fadeUp {

            from {
                opacity: 0;
                transform: translateY(15px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }

        }


        @keyframes fadeDown {

            from {
                opacity: 0;
                transform: translateY(-10px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }

        }


        /* ==========================================
           RESPONSIVE
        ========================================== */

        @media (max-width: 900px) {

            .sidebar {
                width: 220px;
            }

            .main {
                margin-left: 220px;

                padding: 35px;
            }

        }


        @media (max-width: 700px) {

            .sidebar {
                position: relative;

                width: 100%;

                height: auto;

                padding: 18px;
            }


            .logo {
                margin-bottom: 20px;
            }


            .logout {
                position: relative;

                left: auto;
                right: auto;
                bottom: auto;

                margin-top: 20px;
            }


            .main {
                margin-left: 0;

                padding: 25px 18px;
            }


            .header h1 {
                font-size: 27px;
            }


            .form-container {
                padding: 27px 22px;

                border-radius: 17px;
            }


            .form-top {
                align-items: flex-start;
            }

        }


        @media (max-width: 450px) {

            .main {
                padding: 20px 14px;
            }


            .form-container {
                padding: 24px 18px;
            }


            .form-top {
                gap: 12px;
            }


            .form-icon {
                width: 50px;
                height: 50px;

                font-size: 23px;
            }


            .form-title h2 {
                font-size: 18px;
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


    <a href="<%= contextPath %>/teacher/dashboard.jsp">

        🏠 Dashboard

    </a>


    <a href="<%= contextPath %>/my-courses">

        📚 My Courses

    </a>


    <a href="<%= contextPath %>/course"
       class="active">

        ➕ Create Course

    </a>


    <a href="<%= contextPath %>/teacher/study-materials">

        📖 Study Materials

    </a>


    <a href="<%= contextPath %>/teacher/assignments.jsp">

        📝 Assignments

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


<!-- ==========================================
     MAIN CONTENT
========================================== -->

<div class="main">


    <!-- HEADER -->

    <div class="header">

        <h1>
            Create New <span>Course</span> 📚
        </h1>

        <p>
            Build a new learning experience for your students.
        </p>

    </div>


    <!-- ==========================================
         SUCCESS MESSAGE
    ========================================== -->

    <% if ("added".equals(success)) { %>

        <div class="success">

            ✓

            <span>
                Course created successfully!
            </span>

        </div>

    <% } %>


    <!-- ==========================================
         EMPTY FIELD ERROR
    ========================================== -->

    <% if ("empty".equals(error)) { %>

        <div class="error">

            ⚠

            <span>
                Please fill in all fields.
            </span>

        </div>

    <% } %>


    <!-- ==========================================
         DATABASE ERROR
    ========================================== -->

    <% if ("failed".equals(error)) { %>

        <div class="error">

            ⚠

            <span>
                Failed to create course. Please try again.
            </span>

        </div>

    <% } %>


    <!-- ==========================================
         FORM
    ========================================== -->

    <div class="form-container">


        <!-- FORM HEADER -->

        <div class="form-top">

            <div class="form-icon">
                📚
            </div>


            <div class="form-title">

                <h2>
                    Course Information
                </h2>

                <p>
                    Enter the details for your new course.
                </p>

            </div>

        </div>


        <form
            action="<%= contextPath %>/course"
            method="post">


            <!-- ==================================
                 COURSE NAME
            ================================== -->

            <div class="form-group">

                <label for="courseName">
                    Course Name
                </label>


                <div class="input-wrapper">

                    <span class="input-icon">
                        📖
                    </span>


                    <input
                        type="text"
                        id="courseName"
                        name="courseName"
                        placeholder="e.g. Introduction to Tourism Management"
                        required>

                </div>

            </div>


            <!-- ==================================
                 DESCRIPTION
            ================================== -->

            <div class="form-group">

                <label for="description">
                    Course Description
                </label>


                <div class="textarea-wrapper">

                    <span class="textarea-icon">
                        📝
                    </span>


                    <textarea
                        id="description"
                        name="description"
                        placeholder="Describe what students will learn in this course..."
                        required></textarea>

                </div>

            </div>


            <!-- ==================================
                 SUBMIT
            ================================== -->

            <button
                type="submit"
                class="submit-btn">

                ➕ Create Course

            </button>


            <div class="form-note">

                🔒 Your course information is securely stored.

            </div>


        </form>

    </div>


</div>


</body>

</html>