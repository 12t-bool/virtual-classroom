<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // ==========================================
    // CHECK LOGIN
    // ==========================================

    String fullname =
            (String) session.getAttribute("fullname");

    String role =
            (String) session.getAttribute("role");

    if (fullname == null || role == null) {

        response.sendRedirect(
                request.getContextPath() +
                "/login.jsp"
        );

        return;
    }


    // ==========================================
    // GET PROFILE DATA
    // ==========================================

    String[] profile =
            (String[]) request.getAttribute("profile");

    if (profile == null) {

        response.sendRedirect(
                request.getContextPath() +
                "/profile"
        );

        return;
    }


    String profileName = profile[0];
    String email = profile[1];
    String profileRole = profile[2];

    String contextPath =
            request.getContextPath();

    String error =
            request.getParameter("error");
%>


<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Edit Profile - Virtual Classroom</title>


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

            font-family:
                "Segoe UI",
                Arial,
                sans-serif;

            min-height: 100vh;

            background:
                radial-gradient(
                    circle at top right,
                    #ddd6fe 0,
                    transparent 30%
                ),
                radial-gradient(
                    circle at bottom left,
                    #bfdbfe 0,
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
                rgba(31,41,55,0.12);

            z-index: 1000;

            overflow-y: auto;
        }


        /* ==========================================
           LOGO
        ========================================== */

        .logo {

            font-size: 21px;

            font-weight: 800;

            text-align: center;

            margin-bottom: 35px;

            padding-bottom: 20px;

            border-bottom:
                1px solid
                rgba(255,255,255,0.2);
        }


        /* ==========================================
           SIDEBAR LINKS
        ========================================== */

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


        /* ==========================================
           PROFILE ACTIVE
        ========================================== */

        .sidebar a.profile-active {

            background:
                rgba(255,255,255,0.18);

            box-shadow:
                inset 3px 0 0 white;
        }


        /* ==========================================
           LOGOUT
        ========================================== */

        .logout {

            margin-top: 25px;

            padding-top: 20px;

            border-top:
                1px solid
                rgba(255,255,255,0.2);
        }


        .logout a {

            background:
                #dc2626;
        }


        .logout a:hover {

            background:
                #b91c1c;
        }


        /* ==========================================
           MAIN
        ========================================== */

        .main {

            margin-left: 245px;

            min-height: 100vh;

            padding: 45px;
        }


        /* ==========================================
           HEADER
        ========================================== */

        .header {

            margin-bottom: 28px;
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


        /* ==========================================
           ERROR MESSAGE
        ========================================== */

        .message {

            max-width: 720px;

            padding: 15px 18px;

            border-radius: 11px;

            margin-bottom: 22px;

            font-size: 14px;

            font-weight: 600;
        }


        .error {

            background:
                #fef2f2;

            color:
                #b91c1c;

            border:
                1px solid #fecaca;

            border-left:
                5px solid #ef4444;
        }


        /* ==========================================
           FORM CARD
        ========================================== */

        .form-container {

            width: 100%;

            max-width: 720px;

            background:
                rgba(255,255,255,0.96);

            padding: 38px;

            border-radius: 20px;

            border:
                1px solid
                rgba(255,255,255,0.8);

            box-shadow:
                0 20px 50px
                rgba(31,41,55,0.08);

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


        /* ==========================================
           CARD HEADER
        ========================================== */

        .form-title {

            display: flex;

            align-items: center;

            gap: 15px;

            margin-bottom: 30px;

            padding-bottom: 22px;

            border-bottom:
                1px solid #e5e7eb;
        }


        .form-icon {

            width: 58px;
            height: 58px;

            display: flex;

            align-items: center;

            justify-content: center;

            border-radius: 16px;

            background:
                linear-gradient(
                    135deg,
                    #4f46e5,
                    #7c3aed
                );

            color: white;

            font-size: 26px;

            box-shadow:
                0 10px 22px
                rgba(79,70,229,0.22);
        }


        .form-title h2 {

            color:
                #111827;

            font-size:
                21px;

            margin-bottom:
                4px;
        }


        .form-title p {

            color:
                #9ca3af;

            font-size:
                13px;
        }


        /* ==========================================
           FORM GROUP
        ========================================== */

        .form-group {

            margin-bottom:
                23px;
        }


        .form-group label {

            display:
                block;

            margin-bottom:
                9px;

            font-size:
                14px;

            font-weight:
                700;

            color:
                #374151;
        }


        /* ==========================================
           INPUT WRAPPER
        ========================================== */

        .input-wrapper {

            position:
                relative;
        }


        .input-icon {

            position:
                absolute;

            left:
                14px;

            top:
                50%;

            transform:
                translateY(-50%);

            font-size:
                17px;

            z-index:
                2;
        }


        /* ==========================================
           INPUT
        ========================================== */

        .form-group input {

            width:
                100%;

            padding:
                14px
                15px
                14px
                45px;

            border:
                1px solid #d1d5db;

            border-radius:
                11px;

            background:
                #f9fafb;

            color:
                #111827;

            font-size:
                15px;

            transition:
                0.2s;
        }


        .form-group input:hover {

            border-color:
                #a5b4fc;
        }


        .form-group input:focus {

            outline:
                none;

            background:
                white;

            border-color:
                #4f46e5;

            box-shadow:
                0 0 0 4px
                rgba(79,70,229,0.10);
        }


        /* ==========================================
           ROLE BOX
        ========================================== */

        .role-box {

            display:
                flex;

            align-items:
                center;

            gap:
                12px;

            padding:
                14px 15px;

            background:
                #f3f4f6;

            border:
                1px solid #e5e7eb;

            border-radius:
                11px;

            color:
                #374151;

            font-size:
                15px;

            font-weight:
                600;

            text-transform:
                capitalize;
        }


        .role-icon {

            width:
                34px;

            height:
                34px;

            display:
                flex;

            align-items:
                center;

            justify-content:
                center;

            background:
                #e0e7ff;

            border-radius:
                9px;

            font-size:
                17px;
        }


        /* ==========================================
           BUTTON GROUP
        ========================================== */

        .button-group {

            display:
                flex;

            gap:
                12px;

            margin-top:
                30px;
        }


        /* ==========================================
           SAVE BUTTON
        ========================================== */

        .submit-btn {

            flex:
                1;

            padding:
                14px;

            border:
                none;

            border-radius:
                11px;

            background:
                linear-gradient(
                    135deg,
                    #4f46e5,
                    #6366f1
                );

            color:
                white;

            font-size:
                15px;

            font-weight:
                700;

            cursor:
                pointer;

            transition:
                0.2s;

            box-shadow:
                0 8px 18px
                rgba(79,70,229,0.20);
        }


        .submit-btn:hover {

            transform:
                translateY(-2px);

            box-shadow:
                0 12px 24px
                rgba(79,70,229,0.28);
        }


        /* ==========================================
           BACK BUTTON
        ========================================== */

        .back-btn {

            flex:
                1;

            display:
                flex;

            align-items:
                center;

            justify-content:
                center;

            padding:
                14px;

            background:
                #f3f4f6;

            color:
                #374151;

            text-decoration:
                none;

            border-radius:
                11px;

            font-size:
                15px;

            font-weight:
                700;

            border:
                1px solid #e5e7eb;

            transition:
                0.2s;
        }


        .back-btn:hover {

            background:
                #e5e7eb;

            transform:
                translateY(-1px);
        }


        /* ==========================================
           INFO NOTE
        ========================================== */

        .profile-note {

            margin-top:
                25px;

            padding:
                14px 16px;

            background:
                #eef2ff;

            color:
                #4338ca;

            border-radius:
                10px;

            font-size:
                13px;

            line-height:
                1.5;
        }


        /* ==========================================
           RESPONSIVE
        ========================================== */

        @media (max-width: 800px) {

            .sidebar {

                position:
                    relative;

                width:
                    100%;

                height:
                    auto;

                padding:
                    20px;
            }


            .logo {

                margin-bottom:
                    20px;
            }


            .main {

                margin-left:
                    0;

                padding:
                    30px 20px;
            }


            .form-container {

                padding:
                    28px 22px;
            }

        }


        @media (max-width: 550px) {

            .header h1 {

                font-size:
                    27px;
            }


            .button-group {

                flex-direction:
                    column;
            }


            .submit-btn,
            .back-btn {

                width:
                    100%;
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


    <!-- ==========================================
         TEACHER SIDEBAR
    ========================================== -->

    <% if ("teacher".equalsIgnoreCase(role)) { %>


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


        <a href="<%= contextPath %>/teacher/submissions">

            👨‍🎓 Student Submissions

        </a>


        <a href="<%= contextPath %>/teacher/announcements">

            📢 Announcements

        </a>


    <% } else { %>


    <!-- ==========================================
         STUDENT SIDEBAR
    ========================================== -->


        <a href="<%= contextPath %>/student/dashboard.jsp">

            🏠 Dashboard

        </a>


        <a href="<%= contextPath %>/courses">

            📚 Browse Courses

        </a>


        <a href="<%= contextPath %>/student/study-materials">

            📖 Study Materials

        </a>


        <a href="<%= contextPath %>/student/assignments">

            📝 Assignments

        </a>


        <a href="<%= contextPath %>/student/announcements">

            📢 Announcements

        </a>


    <% } %>


    <!-- ==========================================
         PROFILE
    ========================================== -->

    <a
        href="<%= contextPath %>/profile"
        class="profile-active">

        👤 My Profile

    </a>


    <!-- ==========================================
         LOGOUT
    ========================================== -->

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


    <!-- ==========================================
         HEADER
    ========================================== -->

    <div class="header">

        <h1>

            Edit Profile ✏️

        </h1>


        <p>

            Update your Virtual Classroom
            profile information.

        </p>

    </div>



    <!-- ==========================================
         ERROR MESSAGES
    ========================================== -->

    <% if ("empty".equals(error)) { %>


        <div class="message error">

            ⚠ Please fill in all required fields.

        </div>


    <% } %>



    <% if ("failed".equals(error)) { %>


        <div class="message error">

            ⚠ Unable to update your profile.
            Please try again.

        </div>


    <% } %>



    <!-- ==========================================
         FORM CONTAINER
    ========================================== -->

    <div class="form-container">


        <!-- ==========================================
             FORM TITLE
        ========================================== -->

        <div class="form-title">


            <div class="form-icon">

                👤

            </div>


            <div>

                <h2>

                    Profile Information

                </h2>


                <p>

                    Keep your account details up to date.

                </p>

            </div>


        </div>



        <!-- ==========================================
             FORM
        ========================================== -->

        <form
            action="<%= contextPath %>/edit-profile"
            method="post">


            <!-- ======================================
                 FULL NAME
            ======================================= -->

            <div class="form-group">


                <label for="fullname">

                    Full Name

                </label>


                <div class="input-wrapper">


                    <span class="input-icon">

                        👤

                    </span>


                    <input
                        type="text"
                        id="fullname"
                        name="fullname"
                        value="<%= profileName %>"
                        placeholder="Enter your full name"
                        required>


                </div>


            </div>



            <!-- ======================================
                 EMAIL
            ======================================= -->

            <div class="form-group">


                <label for="email">

                    Email Address

                </label>


                <div class="input-wrapper">


                    <span class="input-icon">

                        ✉️

                    </span>


                    <input
                        type="email"
                        id="email"
                        name="email"
                        value="<%= email %>"
                        placeholder="Enter your email"
                        required>


                </div>


            </div>



            <!-- ======================================
                 ROLE
            ======================================= -->

            <div class="form-group">


                <label>

                    Account Type

                </label>


                <div class="role-box">


                    <div class="role-icon">

                        🎓

                    </div>


                    <%= profileRole %>


                </div>


            </div>



            <!-- ======================================
                 BUTTONS
            ======================================= -->

            <div class="button-group">


                <button
                    type="submit"
                    class="submit-btn">

                    💾 Save Changes

                </button>


                <a
                    href="<%= contextPath %>/profile"
                    class="back-btn">

                    ← Back to Profile

                </a>


            </div>


        </form>



        <!-- ==========================================
             INFORMATION NOTE
        ========================================== -->

        <div class="profile-note">

            🔒 Your profile information is securely
            stored and can be updated whenever needed.

        </div>


    </div>


</div>


</body>

</html>