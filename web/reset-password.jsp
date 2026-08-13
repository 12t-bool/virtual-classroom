<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String contextPath = request.getContextPath();

    String email = request.getParameter("email");

    String error = request.getParameter("error");
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Reset Password - Virtual Classroom</title>

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
           MAIN WRAPPER
        ========================================== */

        .reset-wrapper {

            width: 100%;

            max-width: 1050px;

            min-height: 600px;

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


        /* ==========================================
           LEFT CONTENT
        ========================================== */

        .left-content {

            position: relative;

            z-index: 2;
        }


        .left-content h1 {

            font-size: 40px;

            line-height: 1.15;

            margin-bottom: 20px;
        }


        .left-content p {

            font-size: 16px;

            line-height: 1.7;

            color:
                rgba(255,255,255,0.88);

            max-width: 390px;
        }


        /* ==========================================
           SECURITY FEATURES
        ========================================== */

        .features {

            margin-top: 35px;
        }


        .feature {

            display: flex;

            align-items: center;

            gap: 12px;

            margin-bottom: 16px;

            font-size: 14px;
        }


        .feature-icon {

            width: 31px;

            height: 31px;

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
           HEADER
        ========================================== */

        .form-header {

            text-align: center;

            margin-bottom: 25px;
        }


        .reset-icon {

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
           EMAIL DISPLAY
        ========================================== */

        .email-display {

            background: #f5f3ff;

            border:
                1px solid #e0e7ff;

            padding: 13px 15px;

            border-radius: 10px;

            text-align: center;

            margin-bottom: 20px;

            color: #6b7280;

            font-size: 14px;

            word-break: break-word;
        }


        .email-display strong {

            color: #4f46e5;
        }


        /* ==========================================
           ERROR
        ========================================== */

        .error {

            background: #fee2e2;

            color: #b91c1c;

            border:
                1px solid #fecaca;

            padding: 12px 15px;

            border-radius: 9px;

            margin-bottom: 18px;

            text-align: center;

            font-size: 14px;

            font-weight: bold;
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
           INPUT WRAPPER
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
           PASSWORD HINT
        ========================================== */

        .password-hint {

            margin-top: 7px;

            color: #9ca3af;

            font-size: 12px;
        }


        /* ==========================================
           RESET BUTTON
        ========================================== */

        .reset-btn {

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


        .reset-btn:hover {

            transform:
                translateY(-2px);

            box-shadow:
                0 12px 22px
                rgba(79,70,229,0.25);
        }


        /* ==========================================
           BACK TO LOGIN
        ========================================== */

        .back {

            text-align: center;

            margin-top: 22px;
        }


        .back a {

            color: #6b7280;

            text-decoration: none;

            font-size: 14px;

            font-weight: bold;
        }


        .back a:hover {

            color: #4f46e5;

            text-decoration: underline;
        }


        /* ==========================================
           RESPONSIVE
        ========================================== */

        @media (max-width: 850px) {

            .reset-wrapper {

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


            .reset-wrapper {

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
     MAIN WRAPPER
========================================== -->

<div class="reset-wrapper">


    <!-- ==========================================
         LEFT SECTION
    ========================================== -->

    <div class="left-section">


        <div class="brand">

            🎓 Virtual Classroom

        </div>


        <div class="left-content">


            <h1>

                Secure Your<br>
                Account 🔐

            </h1>


            <p>

                Create a new password and get back
                to your Virtual Classroom account.
                Your learning journey is waiting for you.

            </p>


            <div class="features">


                <div class="feature">

                    <div class="feature-icon">
                        ✓
                    </div>

                    <span>
                        Choose a strong password
                    </span>

                </div>


                <div class="feature">

                    <div class="feature-icon">
                        ✓
                    </div>

                    <span>
                        Use at least 6 characters
                    </span>

                </div>


                <div class="feature">

                    <div class="feature-icon">
                        ✓
                    </div>

                    <span>
                        Keep your account secure
                    </span>

                </div>


                <div class="feature">

                    <div class="feature-icon">
                        ✓
                    </div>

                    <span>
                        Continue learning securely
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


            <div class="reset-icon">

                🔑

            </div>


            <h2>

                Reset Password

            </h2>


            <p>

                Create a new password for your account.

            </p>


        </div>


        <!-- ==========================================
             EMAIL
        ========================================== -->

        <% if (email != null &&
               !email.trim().isEmpty()) { %>


            <div class="email-display">

                Resetting password for:

                <strong>
                    <%= email %>
                </strong>

            </div>


        <% } %>


        <!-- ==========================================
             ERRORS
        ========================================== -->

        <% if ("empty".equals(error)) { %>

            <div class="error">

                ⚠ Please enter both password fields.

            </div>

        <% } %>


        <% if ("mismatch".equals(error)) { %>

            <div class="error">

                ⚠ The passwords do not match.

            </div>

        <% } %>


        <% if ("short".equals(error)) { %>

            <div class="error">

                ⚠ Password must be at least 6 characters long.

            </div>

        <% } %>


        <% if ("failed".equals(error)) { %>

            <div class="error">

                ⚠ Failed to reset password.
                Please try again.

            </div>

        <% } %>


        <!-- ==========================================
             FORM
        ========================================== -->

        <form
            action="<%= contextPath %>/reset-password"
            method="post">


            <!-- EMAIL -->

            <input
                type="hidden"
                name="email"
                value="<%= email != null ? email : "" %>">


            <!-- NEW PASSWORD -->

            <div class="form-group">


                <label for="password">

                    New Password

                </label>


                <div class="input-wrapper">


                    <span class="input-icon">

                        🔒

                    </span>


                    <input
                        type="password"
                        id="password"
                        name="password"
                        placeholder="Enter new password"
                        minlength="6"
                        autocomplete="new-password"
                        required>


                </div>


                <div class="password-hint">

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

                        🔐

                    </span>


                    <input
                        type="password"
                        id="confirmPassword"
                        name="confirmPassword"
                        placeholder="Confirm new password"
                        minlength="6"
                        autocomplete="new-password"
                        required>


                </div>


            </div>


            <!-- BUTTON -->

            <button
                type="submit"
                class="reset-btn">

                🔐 Reset Password

            </button>


        </form>


        <!-- BACK -->

        <div class="back">


            <a
                href="<%= contextPath %>/login.jsp">

                ← Back to Login

            </a>


        </div>


    </div>


</div>


</body>

</html>