<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // ==========================================
    // CHECK LOGIN
    // ==========================================

    String fullname =
            (String) session.getAttribute("fullname");

    String role =
            (String) session.getAttribute("role");

    if (fullname == null ||
        role == null) {

        response.sendRedirect(
                request.getContextPath() +
                "/login.jsp"
        );

        return;
    }

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

    <title>Change Password - Virtual Classroom</title>

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

            background:
                radial-gradient(
                    circle at 10% 10%,
                    rgba(129,140,248,0.15),
                    transparent 30%
                ),
                radial-gradient(
                    circle at 90% 90%,
                    rgba(139,92,246,0.12),
                    transparent 30%
                ),
                #f5f7fb;

            color: #1f2937;

            min-height: 100vh;
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
                    #4f46e5 0%,
                    #3730a3 100%
                );

            color: white;

            padding: 25px 18px;

            box-shadow:
                5px 0 25px rgba(0,0,0,0.10);

            z-index: 100;
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
                1px solid rgba(255,255,255,0.20);

            letter-spacing: 0.2px;
        }


        /* ==========================================
           SIDEBAR LINKS
        ========================================== */

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


        /* ==========================================
           LOGOUT
        ========================================== */

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


        /* ==========================================
           MAIN
        ========================================== */

        .main {

            margin-left: 245px;

            padding: 40px;
        }


        /* ==========================================
           HEADER
        ========================================== */

        .header {

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


        /* ==========================================
           PASSWORD LAYOUT
        ========================================== */

        .password-layout {

            display: grid;

            grid-template-columns:
                minmax(0, 1fr)
                280px;

            gap: 25px;

            max-width: 950px;
        }


        /* ==========================================
           FORM CARD
        ========================================== */

        .form-container {

            background:
                rgba(255,255,255,0.96);

            padding: 35px;

            border-radius: 20px;

            border:
                1px solid #eef0f5;

            box-shadow:
                0 10px 35px rgba(0,0,0,0.07);

            transition:
                transform 0.25s,
                box-shadow 0.25s;
        }


        .form-container:hover {

            transform:
                translateY(-2px);

            box-shadow:
                0 15px 40px rgba(0,0,0,0.09);
        }


        /* ==========================================
           FORM TITLE
        ========================================== */

        .form-title {

            display: flex;

            align-items: center;

            gap: 14px;

            margin-bottom: 28px;

            padding-bottom: 20px;

            border-bottom:
                1px solid #edf0f5;
        }


        .form-icon {

            width: 52px;
            height: 52px;

            display: flex;

            align-items: center;
            justify-content: center;

            border-radius: 14px;

            background:
                linear-gradient(
                    135deg,
                    #eef2ff,
                    #e0e7ff
                );

            font-size: 25px;
        }


        .form-title h2 {

            color: #312e81;

            font-size: 21px;

            margin-bottom: 4px;
        }


        .form-title p {

            color: #9ca3af;

            font-size: 13px;
        }


        /* ==========================================
           FORM GROUP
        ========================================== */

        .form-group {

            margin-bottom: 22px;
        }


        .form-group label {

            display: block;

            font-size: 14px;

            font-weight: 700;

            color: #374151;

            margin-bottom: 9px;
        }


        /* ==========================================
           INPUT WRAPPER
        ========================================== */

        .input-wrapper {

            position: relative;
        }


        .input-icon {

            position: absolute;

            left: 15px;

            top: 50%;

            transform:
                translateY(-50%);

            font-size: 17px;

            z-index: 2;
        }


        .form-group input {

            width: 100%;

            padding:
                14px
                15px
                14px
                45px;

            border:
                1px solid #d1d5db;

            border-radius: 11px;

            background: #f9fafb;

            color: #111827;

            font-size: 15px;

            transition:
                border 0.2s,
                box-shadow 0.2s,
                background 0.2s;
        }


        .form-group input::placeholder {

            color: #9ca3af;
        }


        .form-group input:hover {

            border-color:
                #a5b4fc;
        }


        .form-group input:focus {

            outline: none;

            background: white;

            border-color:
                #4f46e5;

            box-shadow:
                0 0 0 4px
                rgba(79,70,229,0.10);
        }


        /* ==========================================
           PASSWORD HINT
        ========================================== */

        .hint {

            display: flex;

            align-items: center;

            gap: 6px;

            font-size: 12px;

            color: #9ca3af;

            margin-top: 7px;
        }


        /* ==========================================
           BUTTONS
        ========================================== */

        .button-row {

            display: flex;

            gap: 12px;

            margin-top: 28px;
        }


        .submit-btn {

            flex: 1;

            padding: 14px;

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


        .back-btn {

            flex: 0 0 auto;

            display: flex;

            align-items: center;

            justify-content: center;

            padding:
                14px 20px;

            background: #f3f4f6;

            color: #374151;

            text-decoration: none;

            border-radius: 11px;

            font-size: 14px;

            font-weight: 700;

            transition:
                background 0.2s,
                transform 0.2s;
        }


        .back-btn:hover {

            background: #e5e7eb;

            transform:
                translateY(-1px);
        }


        /* ==========================================
           ERROR
        ========================================== */

        .error {

            max-width: 950px;

            background:
                #fef2f2;

            color:
                #b91c1c;

            padding:
                14px 18px;

            border-radius:
                11px;

            margin-bottom:
                20px;

            border:
                1px solid #fecaca;

            border-left:
                5px solid #ef4444;

            font-size:
                14px;

            font-weight:
                600;

            box-shadow:
                0 4px 12px
                rgba(239,68,68,0.06);
        }


        /* ==========================================
           SECURITY CARD
        ========================================== */

        .security-card {

            background:
                linear-gradient(
                    145deg,
                    #ffffff,
                    #f8faff
                );

            border:
                1px solid #e5e7eb;

            border-radius:
                20px;

            padding:
                25px;

            height:
                fit-content;

            box-shadow:
                0 10px 30px
                rgba(0,0,0,0.05);
        }


        .security-icon {

            width: 58px;
            height: 58px;

            display: flex;

            align-items: center;
            justify-content: center;

            border-radius: 16px;

            background:
                linear-gradient(
                    135deg,
                    #ede9fe,
                    #e0e7ff
                );

            font-size: 28px;

            margin-bottom: 18px;
        }


        .security-card h3 {

            color: #312e81;

            font-size: 18px;

            margin-bottom: 12px;
        }


        .security-card p {

            color: #6b7280;

            font-size: 13px;

            line-height: 1.7;

            margin-bottom: 18px;
        }


        .security-list {

            list-style: none;
        }


        .security-list li {

            display: flex;

            align-items: flex-start;

            gap: 9px;

            color: #6b7280;

            font-size: 13px;

            line-height: 1.5;

            margin-bottom: 12px;
        }


        .security-list li span {

            color: #4f46e5;

            font-weight: bold;
        }


        /* ==========================================
           RESPONSIVE
        ========================================== */

        @media (max-width: 1000px) {

            .password-layout {

                grid-template-columns: 1fr;
            }

            .security-card {

                max-width: none;
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


            .logo {

                margin-bottom: 20px;
            }

        }


        @media (max-width: 550px) {

            .main {

                padding: 20px;
            }


            .header h1 {

                font-size: 26px;
            }


            .form-container {

                padding: 25px 20px;

                border-radius: 16px;
            }


            .button-row {

                flex-direction: column;
            }


            .back-btn {

                width: 100%;
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


    <% if ("teacher".equalsIgnoreCase(role)) { %>

        <a href="<%= contextPath %>/teacher/dashboard.jsp">
            🏠 Dashboard
        </a>

        <a href="<%= contextPath %>/my-courses">
            📚 My Courses
        </a>

        <a href="<%= contextPath %>/teacher/study-materials">
            📖 Study Materials
        </a>

        <a href="<%= contextPath %>/teacher/assignments.jsp">
            📝 Assignments
        </a>

        <a href="<%= contextPath %>/teacher/submissions">
            👨‍🎓 Student Submissions
        </a>

        <a href="<%= contextPath %>/teacher/announcements">
            📢 Announcements
        </a>

    <% } else { %>

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
            Change Password 🔐
        </h1>

        <p>
            Keep your Virtual Classroom account secure
            with a strong password.
        </p>

    </div>


    <!-- ==========================================
         ERROR MESSAGES
    ========================================== -->

    <% if ("empty".equals(error)) { %>

        <div class="error">
            ⚠ Please fill in all password fields.
        </div>

    <% } %>


    <% if ("match".equals(error)) { %>

        <div class="error">
            ⚠ New password and confirm password do not match.
        </div>

    <% } %>


    <% if ("length".equals(error)) { %>

        <div class="error">
            ⚠ Password must contain at least 6 characters.
        </div>

    <% } %>


    <% if ("incorrect".equals(error)) { %>

        <div class="error">
            ⚠ Your current password is incorrect.
        </div>

    <% } %>


    <% if ("failed".equals(error)) { %>

        <div class="error">
            ⚠ Password could not be changed.
            Please try again.
        </div>

    <% } %>


    <!-- ==========================================
         PASSWORD CONTENT
    ========================================== -->

    <div class="password-layout">


        <!-- ======================================
             FORM CARD
        ====================================== -->

        <div class="form-container">


            <div class="form-title">

                <div class="form-icon">
                    🔐
                </div>

                <div>

                    <h2>
                        Update Password
                    </h2>

                    <p>
                        Enter your current and new password
                    </p>

                </div>

            </div>


            <form
                action="<%= contextPath %>/change-password"
                method="post">


                <!-- CURRENT PASSWORD -->

                <div class="form-group">

                    <label for="currentPassword">
                        Current Password
                    </label>

                    <div class="input-wrapper">

                        <span class="input-icon">
                            🔑
                        </span>

                        <input
                            type="password"
                            id="currentPassword"
                            name="currentPassword"
                            placeholder="Enter your current password"
                            autocomplete="current-password"
                            required>

                    </div>

                </div>


                <!-- NEW PASSWORD -->

                <div class="form-group">

                    <label for="newPassword">
                        New Password
                    </label>

                    <div class="input-wrapper">

                        <span class="input-icon">
                            🛡️
                        </span>

                        <input
                            type="password"
                            id="newPassword"
                            name="newPassword"
                            placeholder="Enter your new password"
                            minlength="6"
                            autocomplete="new-password"
                            required>

                    </div>

                    <div class="hint">

                        💡
                        Password must contain at least 6 characters.

                    </div>

                </div>


                <!-- CONFIRM PASSWORD -->

                <div class="form-group">

                    <label for="confirmPassword">
                        Confirm New Password
                    </label>

                    <div class="input-wrapper">

                        <span class="input-icon">
                            ✓
                        </span>

                        <input
                            type="password"
                            id="confirmPassword"
                            name="confirmPassword"
                            placeholder="Re-enter your new password"
                            minlength="6"
                            autocomplete="new-password"
                            required>

                    </div>

                </div>


                <!-- BUTTONS -->

                <div class="button-row">

                    <button
                        type="submit"
                        class="submit-btn">

                        🔐 Change Password

                    </button>


                    <a
                        href="<%= contextPath %>/profile"
                        class="back-btn">

                        ← Back

                    </a>

                </div>


            </form>

        </div>


        <!-- ======================================
             SECURITY CARD
        ====================================== -->

        <div class="security-card">


            <div class="security-icon">
                🛡️
            </div>


            <h3>
                Password Security
            </h3>


            <p>
                Protect your account by choosing
                a password that is difficult for
                others to guess.
            </p>


            <ul class="security-list">

                <li>
                    <span>✓</span>
                    Use at least 6 characters.
                </li>

                <li>
                    <span>✓</span>
                    Avoid using easily guessed information.
                </li>

                <li>
                    <span>✓</span>
                    Don't share your password with anyone.
                </li>

                <li>
                    <span>✓</span>
                    Use a different password for important accounts.
                </li>

            </ul>


        </div>


    </div>


</div>


</body>

</html>