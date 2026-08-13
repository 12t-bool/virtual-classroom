<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
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

    <title>Login - Virtual Classroom</title>


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
                linear-gradient(
                    135deg,
                    #eef2ff,
                    #f5f3ff
                );

            display: flex;

            align-items: center;

            justify-content: center;

            padding: 30px;

            color: #1f2937;
        }


        /* ==========================================
           MAIN CONTAINER
        ========================================== */

        .login-wrapper {

            width: 100%;

            max-width: 1050px;

            min-height: 620px;

            background: white;

            border-radius: 25px;

            overflow: hidden;

            display: grid;

            grid-template-columns: 45% 55%;

            box-shadow:
                0 20px 60px
                rgba(79, 70, 229, 0.15);
        }


        /* ==========================================
           LEFT SECTION
        ========================================== */

        .left-section {

            background:
                linear-gradient(
                    145deg,
                    #4f46e5,
                    #6366f1,
                    #7c3aed
                );

            color: white;

            padding: 55px 45px;

            display: flex;

            flex-direction: column;

            justify-content: center;

            position: relative;

            overflow: hidden;
        }


        /* Decorative circle */

        .left-section::before {

            content: "";

            position: absolute;

            width: 250px;

            height: 250px;

            border-radius: 50%;

            background:
                rgba(255,255,255,0.08);

            top: -80px;

            left: -80px;
        }


        .left-section::after {

            content: "";

            position: absolute;

            width: 300px;

            height: 300px;

            border-radius: 50%;

            background:
                rgba(255,255,255,0.07);

            bottom: -130px;

            right: -100px;
        }


        /* ==========================================
           BRAND
        ========================================== */

        .brand {

            position: relative;

            z-index: 2;

            font-size: 24px;

            font-weight: bold;

            margin-bottom: 60px;
        }


        .brand span {

            font-size: 30px;
        }


        /* ==========================================
           LEFT CONTENT
        ========================================== */

        .left-content {

            position: relative;

            z-index: 2;
        }


        .left-content h1 {

            font-size: 42px;

            line-height: 1.15;

            margin-bottom: 20px;
        }


        .left-content p {

            font-size: 16px;

            line-height: 1.7;

            color:
                rgba(255,255,255,0.88);

            max-width: 380px;
        }


        /* ==========================================
           FEATURES
        ========================================== */

        .features {

            margin-top: 35px;
        }


        .feature {

            display: flex;

            align-items: center;

            gap: 12px;

            margin-bottom: 15px;

            font-size: 14px;
        }


        .feature-icon {

            width: 30px;

            height: 30px;

            border-radius: 50%;

            background:
                rgba(255,255,255,0.15);

            display: flex;

            align-items: center;

            justify-content: center;
        }


        /* ==========================================
           RIGHT SECTION
        ========================================== */

        .right-section {

            padding: 50px 60px;

            display: flex;

            flex-direction: column;

            justify-content: center;
        }


        /* ==========================================
           FORM HEADER
        ========================================== */

        .form-header {

            margin-bottom: 25px;

            text-align: center;
        }


        .login-icon {

            width: 75px;

            height: 75px;

            margin: 0 auto 20px;

            border-radius: 50%;

            background:
                linear-gradient(
                    135deg,
                    #4f46e5,
                    #6366f1
                );

            color: white;

            display: flex;

            align-items: center;

            justify-content: center;

            font-size: 32px;

            box-shadow:
                0 10px 25px
                rgba(79,70,229,0.20);
        }


        .form-header h2 {

            font-size: 30px;

            color: #1f2937;

            margin-bottom: 8px;
        }


        .form-header p {

            color: #6b7280;

            font-size: 14px;
        }


        /* ==========================================
           MESSAGES
        ========================================== */

        .message {

            padding: 12px 15px;

            border-radius: 9px;

            margin-bottom: 18px;

            font-size: 14px;

            font-weight: bold;

            text-align: center;
        }


        .error {

            background: #fee2e2;

            color: #b91c1c;

            border:
                1px solid #fecaca;
        }


        .success {

            background: #dcfce7;

            color: #15803d;

            border:
                1px solid #bbf7d0;
        }


        /* ==========================================
           FORM GROUP
        ========================================== */

        .form-group {

            margin-bottom: 19px;
        }


        .form-group label {

            display: block;

            font-size: 14px;

            font-weight: bold;

            margin-bottom: 7px;

            color: #374151;
        }


        /* ==========================================
           INPUT
        ========================================== */

        .input-wrapper {

            position: relative;
        }


        .input-icon {

            position: absolute;

            left: 14px;

            top: 50%;

            transform:
                translateY(-50%);

            font-size: 16px;

            color: #9ca3af;
        }


        .form-group input {

            width: 100%;

            padding:
                13px
                14px
                13px
                43px;

            border:
                1px solid #d1d5db;

            border-radius: 10px;

            font-size: 14px;

            background: #fafafa;

            transition: 0.2s;
        }


        .form-group input:focus {

            outline: none;

            background: white;

            border-color: #6366f1;

            box-shadow:
                0 0 0 3px
                rgba(99,102,241,0.10);
        }


        /* ==========================================
           LOGIN BUTTON
        ========================================== */

        .login-btn {

            width: 100%;

            padding: 14px;

            border: none;

            border-radius: 10px;

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

            transition: 0.2s;

            box-shadow:
                0 8px 18px
                rgba(79,70,229,0.20);
        }


        .login-btn:hover {

            transform:
                translateY(-2px);

            box-shadow:
                0 12px 22px
                rgba(79,70,229,0.25);
        }


        /* ==========================================
           FORGOT PASSWORD
        ========================================== */

        .forgot-password {

            text-align: right;

            margin-top: 13px;
        }


        .forgot-password a {

            color: #4f46e5;

            text-decoration: none;

            font-size: 14px;

            font-weight: bold;
        }


        .forgot-password a:hover {

            text-decoration: underline;
        }


        /* ==========================================
           REGISTER
        ========================================== */

        .register {

            text-align: center;

            margin-top: 25px;

            padding-top: 20px;

            border-top:
                1px solid #eee;

            color: #6b7280;

            font-size: 14px;
        }


        .register a {

            color: #4f46e5;

            text-decoration: none;

            font-weight: bold;

            margin-left: 4px;
        }


        .register a:hover {

            text-decoration: underline;
        }


        /* ==========================================
           HOME
        ========================================== */

        .home {

            text-align: center;

            margin-top: 18px;
        }


        .home a {

            color: #6b7280;

            text-decoration: none;

            font-size: 14px;
        }


        .home a:hover {

            color: #4f46e5;
        }


        /* ==========================================
           RESPONSIVE
        ========================================== */

        @media (max-width: 850px) {

            .login-wrapper {

                grid-template-columns: 1fr;

                max-width: 550px;
            }


            .left-section {

                display: none;
            }


            .right-section {

                padding: 45px 35px;
            }
        }


        @media (max-width: 500px) {

            body {

                padding: 15px;
            }


            .login-wrapper {

                border-radius: 18px;
            }


            .right-section {

                padding:
                    35px 25px;
            }


            .form-header h2 {

                font-size: 26px;
            }
        }

    </style>

</head>


<body>


<!-- ==========================================
     LOGIN WRAPPER
========================================== -->

<div class="login-wrapper">


    <!-- ==========================================
         LEFT SECTION
    ========================================== -->

    <div class="left-section">


        <div class="brand">

            🎓 Virtual Classroom

        </div>


        <div class="left-content">


            <h1>

                Welcome<br>
                Back! 👋

            </h1>


            <p>

                Continue your learning journey with
                Virtual Classroom. Access your courses,
                study materials, assignments and more
                from one simple platform.

            </p>


            <div class="features">


                <div class="feature">

                    <div class="feature-icon">
                        ✓
                    </div>

                    <span>
                        Access your courses
                    </span>

                </div>


                <div class="feature">

                    <div class="feature-icon">
                        ✓
                    </div>

                    <span>
                        View study materials
                    </span>

                </div>


                <div class="feature">

                    <div class="feature-icon">
                        ✓
                    </div>

                    <span>
                        Manage assignments
                    </span>

                </div>


                <div class="feature">

                    <div class="feature-icon">
                        ✓
                    </div>

                    <span>
                        Stay connected with your classroom
                    </span>

                </div>


            </div>


        </div>


    </div>


    <!-- ==========================================
         RIGHT SECTION
    ========================================== -->

    <div class="right-section">


        <!-- HEADER -->

        <div class="form-header">


            <div class="login-icon">

                🔐

            </div>


            <h2>

                Sign In

            </h2>


            <p>

                Login to your Virtual Classroom account.

            </p>


        </div>


        <!-- ==========================================
             ERROR MESSAGES
        ========================================== -->

        <% if ("invalid".equals(error)) { %>

            <div class="message error">

                ⚠ Invalid email or password.

            </div>

        <% } %>


        <% if ("empty".equals(error)) { %>

            <div class="message error">

                ⚠ Please enter your email and password.

            </div>

        <% } %>


        <% if ("failed".equals(error)) { %>

            <div class="message error">

                ⚠ Login failed. Please try again.

            </div>

        <% } %>


        <% if ("unauthorized".equals(error)) { %>

            <div class="message error">

                ⚠ You are not authorized to access that page.

            </div>

        <% } %>


        <!-- ==========================================
             SUCCESS MESSAGES
        ========================================== -->

        <% if ("registered".equals(success)) { %>

            <div class="message success">

                ✓ Registration successful!
                Please login.

            </div>

        <% } %>


        <% if ("logout".equals(success)) { %>

            <div class="message success">

                ✓ You have been logged out successfully.

            </div>

        <% } %>


        <% if ("password".equals(success)) { %>

            <div class="message success">

                ✓ Password changed successfully.
                Please login again.

            </div>

        <% } %>


        <% if ("reset".equals(success)) { %>

            <div class="message success">

                ✓ Password reset successfully.
                Please login with your new password.

            </div>

        <% } %>


        <!-- ==========================================
             LOGIN FORM
        ========================================== -->

        <form
            action="<%= contextPath %>/login"
            method="post">


            <!-- EMAIL -->

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
                        placeholder="Enter your email"
                        autocomplete="email"
                        required>


                </div>


            </div>


            <!-- PASSWORD -->

            <div class="form-group">


                <label for="password">

                    Password

                </label>


                <div class="input-wrapper">


                    <span class="input-icon">

                        🔒

                    </span>


                    <input
                        type="password"
                        id="password"
                        name="password"
                        placeholder="Enter your password"
                        autocomplete="current-password"
                        required>


                </div>


            </div>


            <!-- LOGIN BUTTON -->

            <button
                type="submit"
                class="login-btn">

                🔐 Sign In

            </button>


        </form>


        <!-- ==========================================
             FORGOT PASSWORD
        ========================================== -->

        <div class="forgot-password">


            <a
                href="<%= contextPath %>/forgot-password.jsp">

                Forgot Password?

            </a>


        </div>


        <!-- ==========================================
             REGISTER
        ========================================== -->

        <div class="register">


            Don't have an account?


            <a
                href="<%= contextPath %>/register.jsp">

                Create Account

            </a>


        </div>


        <!-- ==========================================
             HOME
        ========================================== -->

        <div class="home">


            <a
                href="<%= contextPath %>/index.jsp">

                ← Back to Home

            </a>


        </div>


    </div>


</div>


</body>

</html>