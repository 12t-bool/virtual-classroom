<%@page import="java.util.List"%>
<%@page import="com.virtualclassroom.model.Course"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // =====================================================
    // SESSION
    // =====================================================

    String fullname =
            (String) session.getAttribute("fullname");

    String role =
            (String) session.getAttribute("role");

    String contextPath =
            request.getContextPath();


    // =====================================================
    // CHECK TEACHER LOGIN
    // =====================================================

    if (fullname == null ||
        role == null ||
        !"teacher".equalsIgnoreCase(role)) {

        response.sendRedirect(
                contextPath + "/login.jsp"
        );

        return;
    }


    // =====================================================
    // GET COURSES FROM SERVLET
    // =====================================================

    List<Course> courses =
            (List<Course>) request.getAttribute("courses");


    // =====================================================
    // IMPORTANT
    //
    // If assignments.jsp is opened directly instead of
    // /teacher/assignments, courses will be null.
    //
    // Send the request to the servlet so the servlet can
    // load the teacher's courses.
    // =====================================================

    if (courses == null) {

        response.sendRedirect(
                contextPath + "/teacher/assignments"
        );

        return;
    }


    // =====================================================
    // GET SUCCESS / ERROR PARAMETERS
    // =====================================================

    String error =
            request.getParameter("error");

    String success =
            request.getParameter("success");
%>


<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        Assignments - Virtual Classroom
    </title>


    <style>

        /* =================================================
           RESET
        ================================================= */

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }


        /* =================================================
           BODY
        ================================================= */

        body {

            font-family:
                "Segoe UI",
                Arial,
                sans-serif;

            background:
                radial-gradient(
                    circle at top right,
                    #eef2ff 0,
                    transparent 30%
                ),
                radial-gradient(
                    circle at bottom left,
                    #f5f3ff 0,
                    transparent 30%
                ),
                #f5f7fb;

            color: #1f2937;

            min-height: 100vh;
        }


        /* =================================================
           SIDEBAR
        ================================================= */

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
                5px 0 25px
                rgba(0,0,0,0.08);

            z-index: 1000;

            overflow-y: auto;
        }


        /* =================================================
           LOGO
        ================================================= */

        .logo {

            font-size: 21px;

            font-weight: 800;

            text-align: center;

            margin-bottom: 35px;

            padding-bottom: 20px;

            border-bottom:
                1px solid
                rgba(255,255,255,0.20);
        }


        /* =================================================
           SIDEBAR LINKS
        ================================================= */

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
                translateX(3px);
        }


        /* =================================================
           ACTIVE ASSIGNMENTS
        ================================================= */

        .sidebar a.active {

            background:
                rgba(255,255,255,0.18);

            box-shadow:
                inset 3px 0 0 white;
        }


        /* =================================================
           LOGOUT
        ================================================= */

        .logout {

            margin-top: 25px;

            padding-top: 20px;

            border-top:
                1px solid
                rgba(255,255,255,0.20);
        }


        .logout a {

            background:
                rgba(220,38,38,0.95);
        }


        .logout a:hover {

            background:
                #b91c1c;
        }


        /* =================================================
           MAIN
        ================================================= */

        .main {

            margin-left: 245px;

            padding: 40px;

            min-height: 100vh;
        }


        /* =================================================
           HEADER
        ================================================= */

        .header {

            display: flex;

            justify-content:
                space-between;

            align-items: center;

            margin-bottom: 30px;
        }


        .header-content h1 {

            font-size: 32px;

            color: #312e81;

            margin-bottom: 8px;

            font-weight: 800;
        }


        .header-content p {

            color: #6b7280;

            font-size: 15px;
        }


        /* =================================================
           TEACHER BADGE
        ================================================= */

        .teacher-badge {

            display: flex;

            align-items: center;

            gap: 10px;

            padding: 10px 15px;

            background: white;

            border-radius: 12px;

            box-shadow:
                0 5px 18px
                rgba(0,0,0,0.05);

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

            background:
                #eef2ff;

            font-size: 18px;
        }


        /* =================================================
           MESSAGE
        ================================================= */

        .message {

            max-width: 800px;

            padding: 15px 18px;

            border-radius: 11px;

            margin-bottom: 25px;

            font-weight: 600;

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


        /* =================================================
           FORM CONTAINER
        ================================================= */

        .form-container {

            max-width: 800px;

            background:
                rgba(255,255,255,0.98);

            padding: 35px;

            border-radius: 20px;

            box-shadow:
                0 8px 30px
                rgba(0,0,0,0.06);

            border:
                1px solid #eef0f5;

            position: relative;

            overflow: hidden;
        }


        .form-container::before {

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


        /* =================================================
           FORM HEADING
        ================================================= */

        .form-heading {

            display: flex;

            align-items: center;

            gap: 15px;

            margin-bottom: 30px;
        }


        .form-icon {

            width: 55px;
            height: 55px;

            display: flex;

            align-items: center;

            justify-content: center;

            border-radius: 14px;

            background:
                #eef2ff;

            font-size: 27px;
        }


        .form-heading h2 {

            color: #312e81;

            font-size: 22px;

            margin-bottom: 4px;
        }


        .form-heading p {

            color: #9ca3af;

            font-size: 13px;
        }


        /* =================================================
           FORM GROUP
        ================================================= */

        .form-group {

            margin-bottom: 23px;
        }


        .form-group label {

            display: block;

            margin-bottom: 9px;

            font-weight: bold;

            font-size: 14px;

            color: #374151;
        }


        .form-group input,
        .form-group textarea,
        .form-group select {

            width: 100%;

            padding: 14px 15px;

            border:
                1px solid #d1d5db;

            border-radius: 10px;

            background:
                #f9fafb;

            color: #111827;

            font-family:
                "Segoe UI",
                Arial,
                sans-serif;

            font-size: 15px;

            transition:
                border 0.2s,
                box-shadow 0.2s,
                background 0.2s;
        }


        .form-group input:hover,
        .form-group textarea:hover,
        .form-group select:hover {

            border-color:
                #a5b4fc;
        }


        .form-group input:focus,
        .form-group textarea:focus,
        .form-group select:focus {

            outline: none;

            background: white;

            border-color:
                #4f46e5;

            box-shadow:
                0 0 0 4px
                rgba(79,70,229,0.10);
        }


        /* =================================================
           SELECT
        ================================================= */

        .form-group select {

            cursor: pointer;
        }


        /* =================================================
           TEXTAREA
        ================================================= */

        .form-group textarea {

            min-height: 140px;

            resize: vertical;

            line-height: 1.6;
        }


        /* =================================================
           DATE
        ================================================= */

        .form-group input[type="datetime-local"] {

            cursor: pointer;
        }


        /* =================================================
           HINT
        ================================================= */

        .field-hint {

            margin-top: 6px;

            font-size: 12px;

            color: #9ca3af;
        }


        /* =================================================
           SUBMIT BUTTON
        ================================================= */

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


        /* =================================================
           NO COURSES
        ================================================= */

        .no-courses {

            max-width: 800px;

            background: white;

            padding: 70px 40px;

            border-radius: 20px;

            text-align: center;

            box-shadow:
                0 8px 30px
                rgba(0,0,0,0.06);

            border:
                1px solid #eef0f5;
        }


        .no-courses-icon {

            width: 90px;
            height: 90px;

            margin:
                0 auto 22px;

            display: flex;

            align-items: center;

            justify-content: center;

            border-radius: 50%;

            background:
                #eef2ff;

            font-size: 42px;
        }


        .no-courses h2 {

            color:
                #312e81;

            margin-bottom:
                10px;

            font-size:
                23px;
        }


        .no-courses p {

            color:
                #6b7280;

            line-height:
                1.6;

            max-width:
                450px;

            margin:
                0 auto 20px;
        }


        /* =================================================
           CREATE COURSE BUTTON
        ================================================= */

        .course-btn {

            display: inline-block;

            padding: 12px 20px;

            border-radius: 10px;

            background:
                #4f46e5;

            color: white;

            text-decoration: none;

            font-weight: bold;

            transition:
                0.2s;
        }


        .course-btn:hover {

            background:
                #3730a3;

            transform:
                translateY(-2px);
        }


        /* =================================================
           RESPONSIVE
        ================================================= */

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

                align-items:
                    flex-start;

                gap: 20px;
            }
        }


        @media (max-width: 600px) {

            .main {

                padding: 20px;
            }


            .header {

                flex-direction:
                    column;
            }


            .teacher-badge {

                width: 100%;

                justify-content:
                    center;
            }


            .form-container {

                padding:
                    25px 20px;
            }


            .no-courses {

                padding:
                    50px 25px;
            }


            .header-content h1 {

                font-size:
                    27px;
            }
        }

    </style>

</head>


<body>


<!-- =====================================================
     SIDEBAR
===================================================== -->

<div class="sidebar">


    <!-- LOGO -->

    <div class="logo">

        🎓 Virtual Classroom

    </div>


    <!-- DASHBOARD -->

    <a
        href="<%= contextPath %>/teacher/dashboard.jsp">

        🏠 Dashboard

    </a>


    <!-- MY COURSES -->

    <a
        href="<%= contextPath %>/teacher/my-courses">

        📚 My Courses

    </a>


    <!-- STUDY MATERIALS -->

    <a
        href="<%= contextPath %>/teacher/study-materials">

        📖 Study Materials

    </a>


    <!-- ASSIGNMENTS -->

    <a
        href="<%= contextPath %>/teacher/assignments"
        class="active">

        📝 Assignments

    </a>


    <!-- SUBMISSIONS -->

    <a
        href="<%= contextPath %>/teacher/submissions">

        👨‍🎓 Student Submissions

    </a>


    <!-- ANNOUNCEMENTS -->

    <a
        href="<%= contextPath %>/teacher/announcements">

        📢 Announcements

    </a>


    <!-- PROFILE -->

    <a
        href="<%= contextPath %>/profile">

        👤 My Profile

    </a>


    <!-- LOGOUT -->

    <div class="logout">

        <a
            href="<%= contextPath %>/logout">

            🚪 Logout

        </a>

    </div>

</div>



<!-- =====================================================
     MAIN
===================================================== -->

<div class="main">


    <!-- =================================================
         HEADER
    ================================================= -->

    <div class="header">


        <div class="header-content">

            <h1>
                Assignments 📝
            </h1>

            <p>
                Create and manage assignments for your courses.
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



    <!-- =================================================
         SUCCESS MESSAGE
    ================================================= -->

    <% if ("added".equals(success)) { %>

        <div class="message success">

            <span>✓</span>

            <span>
                Assignment created successfully!
            </span>

        </div>

    <% } %>



    <!-- =================================================
         ERROR - EMPTY
    ================================================= -->

    <% if ("empty".equals(error)) { %>

        <div class="message error">

            <span>⚠</span>

            <span>
                Please select a course and enter an assignment title.
            </span>

        </div>

    <% } %>



    <!-- =================================================
         ERROR - UNAUTHORIZED
    ================================================= -->

    <% if ("unauthorized".equals(error)) { %>

        <div class="message error">

            <span>⚠</span>

            <span>
                You are not authorized to create an assignment
                for this course.
            </span>

        </div>

    <% } %>



    <!-- =================================================
         ERROR - INVALID COURSE
    ================================================= -->

    <% if ("invalid".equals(error)) { %>

        <div class="message error">

            <span>⚠</span>

            <span>
                Invalid course.
            </span>

        </div>

    <% } %>



    <!-- =================================================
         ERROR - INVALID DATE
    ================================================= -->

    <% if ("invaliddate".equals(error)) { %>

        <div class="message error">

            <span>⚠</span>

            <span>
                Invalid due date.
            </span>

        </div>

    <% } %>



    <!-- =================================================
         ERROR - FAILED
    ================================================= -->

    <% if ("failed".equals(error)) { %>

        <div class="message error">

            <span>⚠</span>

            <span>
                Failed to create assignment.
                Please try again.
            </span>

        </div>

    <% } %>



    <!-- =================================================
         COURSES AVAILABLE
    ================================================= -->

    <% if (courses != null && !courses.isEmpty()) { %>


        <div class="form-container">


            <!-- FORM HEADING -->

            <div class="form-heading">

                <div class="form-icon">

                    📝

                </div>


                <div>

                    <h2>
                        Create Assignment
                    </h2>

                    <p>
                        Add a new assignment for your students.
                    </p>

                </div>

            </div>



            <!-- =================================================
                 CREATE ASSIGNMENT FORM
            ================================================= -->

            <form
                action="<%= contextPath %>/teacher/assignments"
                method="post">


                <!-- =================================================
                     COURSE
                ================================================= -->

                <div class="form-group">

                    <label for="courseId">

                        📚 Select Course

                    </label>


                    <select
                        id="courseId"
                        name="courseId"
                        required>


                        <option value="">

                            -- Select Course --

                        </option>


                        <% for (Course course : courses) { %>

                            <option
                                value="<%= course.getId() %>">

                                <%= course.getCourseName() %>

                            </option>

                        <% } %>


                    </select>


                    <div class="field-hint">

                        Choose the course this assignment belongs to.

                    </div>

                </div>



                <!-- =================================================
                     TITLE
                ================================================= -->

                <div class="form-group">

                    <label for="title">

                        ✏️ Assignment Title

                    </label>


                    <input
                        type="text"
                        id="title"
                        name="title"
                        placeholder="e.g. Introduction to Tourism Management"
                        required>


                    <div class="field-hint">

                        Give your assignment a clear and descriptive title.

                    </div>

                </div>



                <!-- =================================================
                     DESCRIPTION
                ================================================= -->

                <div class="form-group">

                    <label for="description">

                        📄 Description

                    </label>


                    <textarea
                        id="description"
                        name="description"
                        placeholder="Enter assignment instructions, requirements, or questions..."></textarea>


                    <div class="field-hint">

                        Provide instructions to help students complete the assignment.

                    </div>

                </div>



                <!-- =================================================
                     DUE DATE
                ================================================= -->

                <div class="form-group">

                    <label for="dueDate">

                        📅 Due Date

                    </label>


                    <input
                        type="datetime-local"
                        id="dueDate"
                        name="dueDate">


                    <div class="field-hint">

                        Set a deadline for students to submit their work.

                    </div>

                </div>



                <!-- =================================================
                     SUBMIT
                ================================================= -->

                <button
                    type="submit"
                    class="submit-btn">

                    📝 Create Assignment

                </button>


            </form>


        </div>


    <% } else { %>


        <!-- =================================================
             NO COURSES
        ================================================= -->

        <div class="no-courses">


            <div class="no-courses-icon">

                📚

            </div>


            <h2>

                No Courses Available

            </h2>


            <p>

                You need to create a course before
                creating assignments.

            </p>


            <a
                href="<%= contextPath %>/teacher/my-courses"
                class="course-btn">

                📚 Go to My Courses

            </a>


        </div>


    <% } %>


</div>


</body>

</html>