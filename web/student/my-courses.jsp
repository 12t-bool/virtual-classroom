<%@page import="java.util.List"%>
<%@page import="com.virtualclassroom.model.Course"%>
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

    List<Course> courses =
        (List<Course>) request.getAttribute("courses");

    String contextPath = request.getContextPath();
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>My Courses - Virtual Classroom</title>

    <style>

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: Arial, sans-serif;
            background: #f5f7fb;
            color: #333;
            min-height: 100vh;
        }

        /* =========================
           SIDEBAR
        ========================= */

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
            box-shadow: 5px 0 20px rgba(0,0,0,0.08);
            z-index: 1000;
        }

        .logo {
            font-size: 21px;
            font-weight: bold;
            text-align: center;
            padding: 15px 10px;
            margin-bottom: 35px;
            background: rgba(255,255,255,0.1);
            border-radius: 12px;
        }

        .sidebar a {
            display: flex;
            align-items: center;
            color: white;
            text-decoration: none;
            padding: 13px 15px;
            margin-bottom: 7px;
            border-radius: 10px;
            font-size: 15px;
            transition: all 0.25s ease;
        }

        .sidebar a:hover {
            background: rgba(255,255,255,0.15);
            transform: translateX(4px);
        }

        .sidebar a.active {
            background: white;
            color: #4f46e5;
            font-weight: bold;
        }

        .logout {
            margin-top: 30px;
        }

        .logout a {
            background: #dc2626;
        }

        .logout a:hover {
            background: #b91c1c;
            transform: translateX(0);
        }

        /* =========================
           MAIN
        ========================= */

        .main {
            margin-left: 250px;
            padding: 40px;
        }

        /* =========================
           HEADER
        ========================= */

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 35px;
        }

        .header-left h1 {
            font-size: 32px;
            color: #312e81;
            margin-bottom: 8px;
        }

        .header-left p {
            color: #777;
            font-size: 15px;
        }

        .student-badge {
            background: white;
            padding: 12px 18px;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
            color: #4f46e5;
            font-weight: bold;
        }

        /* =========================
           COURSE COUNT
        ========================= */

        .course-summary {
            background: linear-gradient(
                135deg,
                #4f46e5,
                #7c3aed
            );
            color: white;
            padding: 25px 30px;
            border-radius: 16px;
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 8px 25px rgba(79,70,229,0.2);
        }

        .course-summary h2 {
            font-size: 20px;
            margin-bottom: 6px;
        }

        .course-summary p {
            opacity: 0.85;
            font-size: 14px;
        }

        .course-count {
            width: 60px;
            height: 60px;
            background: rgba(255,255,255,0.18);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            font-weight: bold;
        }

        /* =========================
           COURSES GRID
        ========================= */

        .courses {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 25px;
        }

        /* =========================
           COURSE CARD
        ========================= */

        .course-card {
            background: white;
            border-radius: 18px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0,0,0,0.06);
            transition: all 0.3s ease;
            position: relative;
        }

        .course-card:hover {
            transform: translateY(-7px);
            box-shadow: 0 12px 30px rgba(0,0,0,0.10);
        }

        .course-top {
            background: linear-gradient(
                135deg,
                #eef2ff,
                #e0e7ff
            );
            padding: 25px;
            position: relative;
        }

        .course-icon {
            width: 58px;
            height: 58px;
            background: white;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 30px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            margin-bottom: 18px;
        }

        .course-card h2 {
            color: #3730a3;
            font-size: 20px;
            line-height: 1.4;
        }

        .course-body {
            padding: 22px 25px 25px;
        }

        .course-description {
            color: #666;
            line-height: 1.6;
            font-size: 14px;
            min-height: 70px;
        }

        .course-info {
            margin-top: 20px;
            padding-top: 15px;
            border-top: 1px solid #eee;
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: #777;
            font-size: 13px;
        }

        .course-id {
            font-weight: bold;
            color: #4f46e5;
        }

        .status {
            margin-top: 18px;
            padding: 10px 12px;
            border-radius: 9px;
            background: #dcfce7;
            color: #15803d;
            text-align: center;
            font-weight: bold;
            font-size: 13px;
        }

        /* =========================
           EMPTY STATE
        ========================= */

        .empty {
            background: white;
            padding: 70px 40px;
            border-radius: 18px;
            text-align: center;
            box-shadow: 0 5px 20px rgba(0,0,0,0.06);
            max-width: 700px;
            margin: 30px auto;
        }

        .empty-icon {
            width: 90px;
            height: 90px;
            background: #eef2ff;
            border-radius: 50%;
            margin: 0 auto 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 45px;
        }

        .empty h2 {
            color: #333;
            margin-bottom: 10px;
        }

        .empty p {
            color: #777;
            margin-bottom: 25px;
        }

        .browse-btn {
            display: inline-block;
            padding: 13px 25px;
            background: #4f46e5;
            color: white;
            text-decoration: none;
            border-radius: 9px;
            font-weight: bold;
            transition: 0.2s;
        }

        .browse-btn:hover {
            background: #4338ca;
            transform: translateY(-2px);
        }

        /* =========================
           RESPONSIVE
        ========================= */

        @media (max-width: 1200px) {

            .courses {
                grid-template-columns: repeat(2, 1fr);
            }

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

            .header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }

            .course-summary {
                padding: 20px;
            }

            .courses {
                grid-template-columns: 1fr;
            }

        }

        @media (max-width: 500px) {

            .main {
                padding: 20px;
            }

            .header-left h1 {
                font-size: 26px;
            }

            .course-summary {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }

            .course-count {
                width: 50px;
                height: 50px;
                font-size: 20px;
            }

        }

    </style>

</head>

<body>

<!-- =====================================
     SIDEBAR
===================================== -->

<div class="sidebar">

    <div class="logo">
        🎓 Virtual Classroom
    </div>

    <a href="<%= contextPath %>/student/dashboard.jsp">
        🏠 Dashboard
    </a>

    <a href="<%= contextPath %>/student/my-courses"
       class="active">
        📚 My Courses
    </a>

    <a href="<%= contextPath %>/courses">
        🔍 Browse Courses
    </a>

    <a href="<%= contextPath %>/student/study-materials">
        📖 Study Materials
    </a>

    <a href="<%= contextPath %>/student/assignments">
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


<!-- =====================================
     MAIN CONTENT
===================================== -->

<div class="main">

    <!-- HEADER -->

    <div class="header">

        <div class="header-left">

            <h1>
                My Courses 📚
            </h1>

            <p>
                View and manage the courses you are enrolled in.
            </p>

        </div>

        <div class="student-badge">

            👋 <%= fullname %>

        </div>

    </div>


    <% if (courses != null && !courses.isEmpty()) { %>


        <!-- COURSE SUMMARY -->

        <div class="course-summary">

            <div>

                <h2>
                    Your Learning Journey 🚀
                </h2>

                <p>
                    Keep learning and complete your course assignments.
                </p>

            </div>

            <div class="course-count">

                <%= courses.size() %>

            </div>

        </div>


        <!-- COURSES -->

        <div class="courses">


            <% for (Course course : courses) { %>


                <div class="course-card">


                    <!-- Course Header -->

                    <div class="course-top">

                        <div class="course-icon">
                            📚
                        </div>

                        <h2>
                            <%= course.getCourseName() %>
                        </h2>

                    </div>


                    <!-- Course Body -->

                    <div class="course-body">


                        <div class="course-description">

                            <%= course.getDescription() %>

                        </div>


                        <div class="course-info">

                            <span>
                                Course ID
                            </span>

                            <span class="course-id">

                                #<%= course.getId() %>

                            </span>

                        </div>


                        <div class="status">

                            ✓ Currently Enrolled

                        </div>


                    </div>


                </div>


            <% } %>


        </div>


    <% } else { %>


        <!-- =====================================
             EMPTY STATE
        ====================================== -->

        <div class="empty">

            <div class="empty-icon">
                📚
            </div>

            <h2>
                No Courses Yet
            </h2>

            <p>
                You haven't enrolled in any courses yet.
                Browse available courses and start learning!
            </p>

            <a
                href="<%= contextPath %>/courses"
                class="browse-btn">

                🔍 Browse Courses

            </a>

        </div>


    <% } %>


</div>

</body>

</html>