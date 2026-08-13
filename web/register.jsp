<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String error = request.getParameter("error");
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Create Account - Virtual Classroom</title>

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            min-height: 100vh;
            background: linear-gradient(135deg, #eef2ff, #f5f3ff);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 30px;
            color: #1f2937;
        }

        /* ==========================================
           MAIN CONTAINER
        ========================================== */

        .register-wrapper {
            width: 100%;
            max-width: 1050px;
            min-height: 650px;

            background: white;

            border-radius: 25px;

            overflow: hidden;

            display: grid;
            grid-template-columns: 45% 55%;

            box-shadow:
                0 20px 60px rgba(79, 70, 229, 0.15);
        }


        /* ==========================================
           LEFT SIDE
        ========================================== */

        .left-section {
            background: linear-gradient(
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


        .left-section::before {
            content: "";

            position: absolute;

            width: 250px;
            height: 250px;

            border-radius: 50%;

            background: rgba(255,255,255,0.08);

            top: -80px;
            left: -80px;
        }


        .left-section::after {
            content: "";

            position: absolute;

            width: 300px;
            height: 300px;

            border-radius: 50%;

            background: rgba(255,255,255,0.07);

            bottom: -130px;
            right: -100px;
        }


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

            color: rgba(255,255,255,0.88);

            max-width: 380px;
        }


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

            background: rgba(255,255,255,0.15);

            display: flex;

            align-items: center;
            justify-content: center;
        }


        /* ==========================================
           RIGHT SIDE
        ========================================== */

        .right-section {
            padding: 45px 55px;

            display: flex;

            flex-direction: column;

            justify-content: center;
        }


        .form-header {
            margin-bottom: 25px;
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
        }


        .error {
            background: #fee2e2;

            color: #b91c1c;

            border: 1px solid #fecaca;
        }


        .success {
            background: #dcfce7;

            color: #15803d;

            border: 1px solid #bbf7d0;
        }


        /* ==========================================
           FORM
        ========================================== */

        .form-group {
            margin-bottom: 17px;
        }


        .form-group label {
            display: block;

            font-size: 14px;

            font-weight: bold;

            margin-bottom: 7px;

            color: #374151;
        }


        .input-wrapper {
            position: relative;
        }


        .input-icon {
            position: absolute;

            left: 13px;

            top: 50%;

            transform: translateY(-50%);

            font-size: 16px;

            color: #9ca3af;
        }


        .form-group input,
        .form-group select {

            width: 100%;

            padding: 13px 14px 13px 42px;

            border: 1px solid #d1d5db;

            border-radius: 10px;

            font-size: 14px;

            background: #fafafa;

            transition: 0.2s;
        }


        .form-group select {
            padding-left: 42px;

            cursor: pointer;
        }


        .form-group input:focus,
        .form-group select:focus {

            outline: none;

            background: white;

            border-color: #6366f1;

            box-shadow:
                0 0 0 3px rgba(99,102,241,0.10);
        }


        /* ==========================================
           BUTTON
        ========================================== */

        .register-btn {

            width: 100%;

            padding: 14px;

            border: none;

            border-radius: 10px;

            background: linear-gradient(
                135deg,
                #4f46e5,
                #6366f1
            );

            color: white;

            font-size: 15px;

            font-weight: bold;

            cursor: pointer;

            margin-top: 5px;

            transition: 0.2s;

            box-shadow:
                0 8px 18px rgba(79,70,229,0.20);
        }


        .register-btn:hover {

            transform: translateY(-2px);

            box-shadow:
                0 12px 22px rgba(79,70,229,0.25);
        }


        /* ==========================================
           LOGIN LINK
        ========================================== */

        .login-link {

            text-align: center;

            margin-top: 22px;

            color: #6b7280;

            font-size: 14px;
        }


        .login-link a {

            color: #4f46e5;

            text-decoration: none;

            font-weight: bold;

            margin-left: 4px;
        }


        .login-link a:hover {
            text-decoration: underline;
        }


        /* ==========================================
           RESPONSIVE
        ========================================== */

        @media (max-width: 850px) {

            .register-wrapper {

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


            .register-wrapper {
                border-radius: 18px;
            }


            .right-section {
                padding: 35px 25px;
            }


            .form-header h2 {
                font-size: 26px;
            }
        }

    </style>

</head>


<body>


<!-- ==========================================
     REGISTER WRAPPER
========================================== -->

<div class="register-wrapper">


    <!-- ==========================================
         LEFT SECTION
    ========================================== -->

    <div class="left-section">


        <div class="brand">
            🎓 Virtual Classroom
        </div>


        <div class="left-content">

            <h1>
                Start Your<br>
                Learning Journey.
            </h1>


            <p>
                Join Virtual Classroom and connect with
                teachers, courses, study materials,
                assignments and announcements
                all in one place.
            </p>


            <div class="features">

                <div class="feature">

                    <div class="feature-icon">
                        ✓
                    </div>

                    <span>
                        Access your courses easily
                    </span>

                </div>


                <div class="feature">

                    <div class="feature-icon">
                        ✓
                    </div>

                    <span>
                        Learn with organized study materials
                    </span>

                </div>


                <div class="feature">

                    <div class="feature-icon">
                        ✓
                    </div>

                    <span>
                        Submit and manage assignments
                    </span>

                </div>


                <div class="feature">

                    <div class="feature-icon">
                        ✓
                    </div>

                    <span>
                        Stay updated with announcements
                    </span>

                </div>

            </div>

        </div>

    </div>


    <!-- ==========================================
         RIGHT SECTION
    ========================================== -->

    <div class="right-section">


        <div class="form-header">

            <h2>
                Create Account
            </h2>

            <p>
                Fill in your details to get started.
            </p>

        </div>


        <!-- ==========================================
             ERROR MESSAGES
        ========================================== -->

        <% if ("empty".equals(error)) { %>

            <div class="message error">
                ⚠ Please fill in all fields.
            </div>

        <% } else if ("exists".equals(error)) { %>

            <div class="message error">
                ⚠ Email already registered.
            </div>

        <% } else if ("failed".equals(error)) { %>

            <div class="message error">
                ⚠ Registration failed. Please try again.
            </div>

        <% } %>


        <!-- ==========================================
             REGISTER FORM
        ========================================== -->

        <form
            action="register"
            method="post">


            <!-- FULL NAME -->

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
                        placeholder="Enter your full name"
                        autocomplete="name"
                        required>

                </div>

            </div>


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
                        placeholder="Create a password"
                        autocomplete="new-password"
                        required>

                </div>

            </div>


            <!-- ROLE -->

            <div class="form-group">

                <label for="role">
                    Register As
                </label>

                <div class="input-wrapper">

                    <span class="input-icon">
                        🎓
                    </span>

                    <select
                        name="role"
                        id="role"
                        required>

                        <option value="">
                            Select your role
                        </option>

                        <option value="student">
                            Student
                        </option>

                        <option value="teacher">
                            Teacher
                        </option>

                    </select>

                </div>

            </div>


            <!-- SUBMIT -->

            <button
                type="submit"
                class="register-btn">

                Create My Account →

            </button>


        </form>


        <!-- LOGIN -->

        <div class="login-link">

            Already have an account?

            <a href="login.jsp">
                Login
            </a>

        </div>


    </div>


</div>


</body>

</html>