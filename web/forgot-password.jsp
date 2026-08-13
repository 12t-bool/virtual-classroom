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

    <title>Forgot Password - Virtual Classroom</title>

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            min-height: 100vh;

            display: flex;
            align-items: center;
            justify-content: center;

            padding: 25px;

            background:
                radial-gradient(
                    circle at top left,
                    #ddd6fe 0,
                    transparent 35%
                ),
                radial-gradient(
                    circle at bottom right,
                    #bfdbfe 0,
                    transparent 35%
                ),
                #f5f7fb;

            color: #1f2937;
        }

        /* ==========================================
           MAIN CARD
        ========================================== */

        .container {
            width: 100%;
            max-width: 470px;

            background: rgba(255,255,255,0.95);

            padding: 42px;

            border-radius: 24px;

            box-shadow:
                0 25px 60px rgba(31,41,55,0.12);

            border: 1px solid rgba(255,255,255,0.8);
        }

        /* ==========================================
           LOGO
        ========================================== */

        .logo {
            text-align: center;

            font-size: 21px;

            font-weight: 800;

            color: #4f46e5;

            margin-bottom: 30px;

            letter-spacing: 0.2px;
        }

        /* ==========================================
           ICON
        ========================================== */

        .icon-wrapper {
            display: flex;
            justify-content: center;

            margin-bottom: 24px;
        }

        .icon {
            width: 82px;
            height: 82px;

            display: flex;
            align-items: center;
            justify-content: center;

            border-radius: 22px;

            background:
                linear-gradient(
                    135deg,
                    #4f46e5,
                    #7c3aed
                );

            color: white;

            font-size: 36px;

            box-shadow:
                0 12px 25px rgba(79,70,229,0.25);
        }

        /* ==========================================
           TITLE
        ========================================== */

        h1 {
            text-align: center;

            color: #111827;

            font-size: 29px;

            margin-bottom: 10px;
        }

        .description {
            text-align: center;

            color: #6b7280;

            line-height: 1.6;

            max-width: 360px;

            margin: 0 auto 28px;
        }

        /* ==========================================
           MESSAGES
        ========================================== */

        .message {
            padding: 14px 16px;

            border-radius: 10px;

            margin-bottom: 22px;

            text-align: center;

            font-size: 14px;

            font-weight: 600;
        }

        .error {
            background: #fef2f2;

            color: #b91c1c;

            border: 1px solid #fecaca;
        }

        .success {
            background: #f0fdf4;

            color: #15803d;

            border: 1px solid #bbf7d0;
        }

        /* ==========================================
           FORM
        ========================================== */

        .form-group {
            margin-bottom: 22px;
        }

        .form-group label {
            display: block;

            margin-bottom: 9px;

            font-size: 14px;

            font-weight: 700;

            color: #374151;
        }

        .input-wrapper {
            position: relative;
        }

        .input-icon {
            position: absolute;

            left: 14px;
            top: 50%;

            transform: translateY(-50%);

            font-size: 18px;
        }

        .form-group input {
            width: 100%;

            padding: 14px 15px 14px 45px;

            border: 1px solid #d1d5db;

            border-radius: 11px;

            background: #f9fafb;

            color: #111827;

            font-size: 15px;

            transition: 0.2s;
        }

        .form-group input::placeholder {
            color: #9ca3af;
        }

        .form-group input:hover {
            border-color: #a5b4fc;
        }

        .form-group input:focus {
            outline: none;

            background: white;

            border-color: #4f46e5;

            box-shadow:
                0 0 0 4px rgba(79,70,229,0.10);
        }

        /* ==========================================
           BUTTON
        ========================================== */

        .btn {
            width: 100%;

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

            transition: 0.2s;

            box-shadow:
                0 8px 18px rgba(79,70,229,0.20);
        }

        .btn:hover {
            transform: translateY(-2px);

            box-shadow:
                0 12px 24px rgba(79,70,229,0.28);
        }

        .btn:active {
            transform: translateY(0);
        }

        /* ==========================================
           BACK TO LOGIN
        ========================================== */

        .back {
            text-align: center;

            margin-top: 25px;

            padding-top: 22px;

            border-top: 1px solid #e5e7eb;
        }

        .back a {
            color: #4f46e5;

            text-decoration: none;

            font-size: 14px;

            font-weight: 700;

            transition: 0.2s;
        }

        .back a:hover {
            color: #3730a3;

            text-decoration: underline;
        }

        /* ==========================================
           SECURITY NOTE
        ========================================== */

        .security-note {
            margin-top: 22px;

            text-align: center;

            font-size: 12px;

            color: #9ca3af;

            line-height: 1.5;
        }

        /* ==========================================
           RESPONSIVE
        ========================================== */

        @media (max-width: 500px) {

            body {
                padding: 15px;
            }

            .container {
                padding: 32px 24px;

                border-radius: 20px;
            }

            h1 {
                font-size: 25px;
            }

            .icon {
                width: 72px;
                height: 72px;

                font-size: 31px;
            }

        }

    </style>

</head>

<body>


<div class="container">


    <!-- LOGO -->

    <div class="logo">

        🎓 Virtual Classroom

    </div>


    <!-- ICON -->

    <div class="icon-wrapper">

        <div class="icon">

            🔐

        </div>

    </div>


    <!-- TITLE -->

    <h1>

        Forgot Password?

    </h1>


    <p class="description">

        No worries! Enter the email address
        associated with your Virtual Classroom
        account and we'll help you get back in.

    </p>


    <!-- ==========================================
         ERROR MESSAGES
    ========================================== -->

    <% if ("empty".equals(error)) { %>

        <div class="message error">

            ⚠ Please enter your email address.

        </div>

    <% } %>


    <% if ("notfound".equals(error)) { %>

        <div class="message error">

            ⚠ No account was found with this email address.

        </div>

    <% } %>


    <% if ("failed".equals(error)) { %>

        <div class="message error">

            ⚠ Something went wrong.
            Please try again.

        </div>

    <% } %>


    <!-- ==========================================
         SUCCESS MESSAGE
    ========================================== -->

    <% if ("success".equals(success)) { %>

        <div class="message success">

            ✓ Your password has been reset successfully.

        </div>

    <% } %>


    <!-- ==========================================
         FORM
    ========================================== -->

    <form
        action="<%= contextPath %>/forgot-password"
        method="post">


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
                    placeholder="Enter your email address"
                    autocomplete="email"
                    required>

            </div>

        </div>


        <button
            type="submit"
            class="btn">

            Continue →

        </button>


    </form>


    <!-- ==========================================
         BACK TO LOGIN
    ========================================== -->

    <div class="back">

        <a
            href="<%= contextPath %>/login.jsp">

            ← Back to Login

        </a>

    </div>


    <!-- SECURITY NOTE -->

    <div class="security-note">

        🔒 Your account information remains secure.

    </div>


</div>


</body>

</html>