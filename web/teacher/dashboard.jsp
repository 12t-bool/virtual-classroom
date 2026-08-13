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
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Teacher Dashboard - Virtual Classroom</title>

    <style>

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

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

            color: #333333;

            min-height: 100vh;
        }


        /* ================= SIDEBAR ================= */

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
                5px 0 25px
                rgba(0,0,0,0.10);

            overflow-y: auto;

            z-index: 1000;
        }


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


        .sidebar a.active {

            background:
                rgba(255,255,255,0.18);

            box-shadow:
                inset 3px 0 0 white;
        }


        /* ================= LOGOUT ================= */

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

            background: #b91c1c;
        }


        /* ================= MAIN ================= */

        .main {

            margin-left: 245px;

            padding: 40px;

            min-height: 100vh;
        }


        /* ================= WELCOME ================= */

        .welcome {

            background: white;

            padding: 30px;

            border-radius: 18px;

            margin-bottom: 30px;

            border:
                1px solid #eef0f5;

            box-shadow:
                0 7px 25px
                rgba(0,0,0,0.06);

            position: relative;

            overflow: hidden;
        }


        .welcome::before {

            content: "";

            position: absolute;

            left: 0;
            top: 0;

            width: 100%;
            height: 5px;

            background:
                linear-gradient(
                    90deg,
                    #4f46e5,
                    #7c3aed
                );
        }


        .welcome h1 {

            font-size: 30px;

            margin-bottom: 10px;

            color: #312e81;

            font-weight: 800;
        }


        .welcome p {

            color: #666666;

            font-size: 16px;

            line-height: 1.6;
        }


        /* ================= CARDS ================= */

        .cards {

            display: grid;

            grid-template-columns:
                repeat(3, minmax(0, 1fr));

            gap: 22px;
        }


        .card {

            background: white;

            padding: 25px;

            border-radius: 17px;

            border:
                1px solid #eef0f5;

            box-shadow:
                0 7px 25px
                rgba(0,0,0,0.06);

            text-decoration: none;

            color: #333333;

            transition:
                transform 0.25s,
                box-shadow 0.25s;

            position: relative;

            overflow: hidden;

            min-height: 190px;
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


        .card:hover {

            transform:
                translateY(-5px);

            box-shadow:
                0 13px 32px
                rgba(0,0,0,0.10);
        }


        .card-icon {

            width: 55px;
            height: 55px;

            display: flex;

            align-items: center;
            justify-content: center;

            border-radius: 14px;

            background: #eef2ff;

            font-size: 27px;

            margin-bottom: 17px;
        }


        .card h2 {

            color: #312e81;

            margin-bottom: 9px;

            font-size: 20px;
        }


        .card p {

            color: #666666;

            line-height: 1.6;

            font-size: 14px;
        }


        /* ================= RESPONSIVE ================= */

        @media (max-width: 1100px) {

            .cards {

                grid-template-columns:
                    repeat(2, minmax(0, 1fr));
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


            .cards {

                grid-template-columns: 1fr;
            }
        }


        @media (max-width: 600px) {

            .main {

                padding: 20px;
            }


            .welcome {

                padding: 25px 20px;
            }


            .welcome h1 {

                font-size: 26px;
            }
        }

    </style>

</head>


<body>


<!-- =====================================================
     SIDEBAR
===================================================== -->

<div class="sidebar">


    <div class="logo">

        🎓 Virtual Classroom

    </div>


    <!-- DASHBOARD -->

    <a
        href="<%= contextPath %>/teacher/dashboard.jsp"
        class="active">

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

    <!-- IMPORTANT:
         DO NOT USE assignments.jsp HERE -->

    <a
        href="<%= contextPath %>/teacher/assignments">

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


    <!-- WELCOME -->

    <div class="welcome">

        <h1>

            Welcome, <%= fullname %>! 👋

        </h1>


        <p>

            Manage your courses, assignments,
            study materials and student submissions
            from your teacher dashboard.

        </p>

    </div>



    <!-- =================================================
         CARDS
    ================================================= -->

    <div class="cards">


        <!-- MY COURSES -->

        <a
            href="<%= contextPath %>/teacher/my-courses"
            class="card">

            <div class="card-icon">

                📚

            </div>

            <h2>

                My Courses

            </h2>

            <p>

                View and manage the courses
                you have created.

            </p>

        </a>



        <!-- ASSIGNMENTS -->

        <!-- IMPORTANT:
             THIS MUST GO TO THE SERVLET -->

        <a
            href="<%= contextPath %>/teacher/assignments"
            class="card">

            <div class="card-icon">

                📝

            </div>

            <h2>

                Assignments

            </h2>

            <p>

                Create and manage assignments
                for your courses.

            </p>

        </a>



        <!-- SUBMISSIONS -->

        <a
            href="<%= contextPath %>/teacher/submissions"
            class="card">

            <div class="card-icon">

                👨‍🎓

            </div>

            <h2>

                Student Submissions

            </h2>

            <p>

                View assignments submitted
                by your students.

            </p>

        </a>



        <!-- STUDY MATERIALS -->

        <a
            href="<%= contextPath %>/teacher/study-materials"
            class="card">

            <div class="card-icon">

                📖

            </div>

            <h2>

                Study Materials

            </h2>

            <p>

                Upload and manage learning
                materials for your courses.

            </p>

        </a>



        <!-- ANNOUNCEMENTS -->

        <a
            href="<%= contextPath %>/teacher/announcements"
            class="card">

            <div class="card-icon">

                📢

            </div>

            <h2>

                Announcements

            </h2>

            <p>

                Share important announcements
                with your students.

            </p>

        </a>



        <!-- PROFILE -->

        <a
            href="<%= contextPath %>/profile"
            class="card">

            <div class="card-icon">

                👤

            </div>

            <h2>

                My Profile

            </h2>

            <p>

                View your teacher profile
                and account information.

            </p>

        </a>


    </div>


</div>


</body>

</html>