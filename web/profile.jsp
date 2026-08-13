
<%@page import="com.virtualclassroom.model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // =====================================================
    // GET SESSION DATA
    // =====================================================

    String fullname =
            (String) session.getAttribute("fullname");

    String role =
            (String) session.getAttribute("role");

    String contextPath =
            request.getContextPath();


    // =====================================================
    // CHECK LOGIN
    // =====================================================

    if (fullname == null ||
        role == null) {

        response.sendRedirect(
                contextPath + "/login.jsp"
        );

        return;
    }


    // =====================================================
    // GET USER OBJECT
    // =====================================================

    User user =
            (User) request.getAttribute("user");


    // =====================================================
    // IF USER OBJECT IS MISSING
    // =====================================================

    if (user == null) {

        response.sendRedirect(
                contextPath + "/profile"
        );

        return;
    }


    // =====================================================
    // DETERMINE DASHBOARD URL
    // =====================================================

    String dashboardUrl;


    if ("student".equalsIgnoreCase(role)) {

        dashboardUrl =
                contextPath + "/student/dashboard";

    } else if ("teacher".equalsIgnoreCase(role)) {

        dashboardUrl =
                contextPath + "/teacher/dashboard.jsp";

    } else if ("admin".equalsIgnoreCase(role)) {

        dashboardUrl =
                contextPath + "/admin/dashboard.jsp";

    } else {

        dashboardUrl =
                contextPath + "/login.jsp";
    }


    // =====================================================
    // SUCCESS / ERROR MESSAGES
    // =====================================================

    String success =
            request.getParameter("success");

    String error =
            request.getParameter("error");


    // =====================================================
    // AVATAR LETTER
    // =====================================================

    String avatarLetter = "U";

    if (fullname != null &&
        !fullname.trim().isEmpty()) {

        avatarLetter =
                fullname.substring(0, 1).toUpperCase();
    }
%>


<!DOCTYPE html>

<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>My Profile - Virtual Classroom</title>


<style>

/* =====================================================
   RESET
===================================================== */

* {

    margin: 0;

    padding: 0;

    box-sizing: border-box;

}


/* =====================================================
   BODY
===================================================== */

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

    color: #1f2937;

    min-height: 100vh;

}


/* =====================================================
   SIDEBAR
===================================================== */

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


/* =====================================================
   LOGO
===================================================== */

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


/* =====================================================
   SIDEBAR LINKS
===================================================== */

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


/* =====================================================
   ACTIVE PROFILE
===================================================== */

.sidebar a.profile-active {

    background:
        rgba(255,255,255,0.18);

    box-shadow:
        inset 3px 0 0 white;

}


/* =====================================================
   LOGOUT
===================================================== */

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


/* =====================================================
   MAIN
===================================================== */

.main {

    margin-left: 245px;

    padding: 40px;

    min-height: 100vh;

}


/* =====================================================
   HEADER
===================================================== */

.header {

    display: flex;

    justify-content: space-between;

    align-items: center;

    margin-bottom: 25px;

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


/* =====================================================
   EDIT PROFILE BUTTON
===================================================== */

.edit-profile-btn {

    display: inline-flex;

    align-items: center;

    gap: 8px;

    padding: 12px 20px;

    background:

        linear-gradient(
            135deg,
            #4f46e5,
            #7c3aed
        );

    color: white;

    text-decoration: none;

    border-radius: 10px;

    font-size: 14px;

    font-weight: 700;

    box-shadow:
        0 7px 18px
        rgba(79,70,229,0.20);

    transition:
        transform 0.2s,
        box-shadow 0.2s;

}


.edit-profile-btn:hover {

    transform:
        translateY(-2px);

    box-shadow:
        0 11px 25px
        rgba(79,70,229,0.28);

}


/* =====================================================
   MESSAGES
===================================================== */

.message {

    max-width: 800px;

    padding: 15px 18px;

    border-radius: 11px;

    margin-bottom: 25px;

    font-weight: 600;

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


/* =====================================================
   PROFILE CARD
===================================================== */

.profile-card {

    max-width: 800px;

    background: white;

    border-radius: 20px;

    padding: 35px;

    border:
        1px solid #eef0f5;

    box-shadow:
        0 8px 30px
        rgba(0,0,0,0.06);

    position: relative;

    overflow: hidden;

}


.profile-card::before {

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


/* =====================================================
   PROFILE HEADER
===================================================== */

.profile-header {

    display: flex;

    align-items: center;

    gap: 22px;

    margin-bottom: 35px;

    padding-bottom: 25px;

    border-bottom:
        1px solid #eef0f5;

}


/* =====================================================
   AVATAR
===================================================== */

.avatar {

    width: 90px;

    height: 90px;

    border-radius: 50%;

    display: flex;

    align-items: center;

    justify-content: center;

    background:

        linear-gradient(
            135deg,
            #4f46e5,
            #7c3aed
        );

    color: white;

    font-size: 38px;

    font-weight: 800;

    flex-shrink: 0;

    box-shadow:
        0 8px 20px
        rgba(79,70,229,0.25);

}


/* =====================================================
   PROFILE NAME
===================================================== */

.profile-name h2 {

    color: #312e81;

    font-size: 25px;

    margin-bottom: 7px;

}


.role-badge {

    display: inline-block;

    padding: 6px 12px;

    border-radius: 20px;

    background: #eef2ff;

    color: #4338ca;

    font-size: 12px;

    font-weight: 700;

    text-transform: capitalize;

}


/* =====================================================
   INFO SECTION
===================================================== */

.info-section {

    display: flex;

    flex-direction: column;

    gap: 15px;

}


/* =====================================================
   INFO ROW
===================================================== */

.info-row {

    display: flex;

    align-items: center;

    padding: 17px;

    background: #f8fafc;

    border-radius: 12px;

    border:
        1px solid #eef0f5;

}


/* =====================================================
   INFO ICON
===================================================== */

.info-icon {

    width: 42px;

    height: 42px;

    border-radius: 10px;

    display: flex;

    align-items: center;

    justify-content: center;

    background: #eef2ff;

    font-size: 20px;

    margin-right: 15px;

}


/* =====================================================
   INFO CONTENT
===================================================== */

.info-content {

    display: flex;

    flex-direction: column;

    gap: 3px;

}


/* =====================================================
   INFO LABEL
===================================================== */

.info-label {

    font-size: 12px;

    color: #9ca3af;

    font-weight: 600;

    text-transform: uppercase;

}


/* =====================================================
   INFO VALUE
===================================================== */

.info-value {

    font-size: 15px;

    color: #374151;

    font-weight: 600;

    word-break: break-word;

}


/* =====================================================
   RESPONSIVE
===================================================== */

@media (max-width: 850px) {

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

        gap: 20px;

    }

}


@media (max-width: 600px) {

    .main {

        padding: 20px;

    }


    .profile-card {

        padding: 25px 20px;

    }


    .profile-header {

        flex-direction: column;

        text-align: center;

    }


    .info-row {

        align-items: flex-start;

    }


    .edit-profile-btn {

        width: 100%;

        justify-content: center;

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


    <!-- =================================================
         STUDENT SIDEBAR
    ================================================= -->

    <% if ("student".equalsIgnoreCase(role)) { %>


        <a href="<%= contextPath %>/student/dashboard">

            🏠 Dashboard

        </a>


        <a href="<%= contextPath %>/student/my-courses">

            📚 My Courses

        </a>


        <a href="<%= contextPath %>/courses">

            🔎 Browse Courses

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


    <% } %>


    <!-- =================================================
         TEACHER SIDEBAR
    ================================================= -->

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


    <% } %>


    <!-- =================================================
         ADMIN SIDEBAR
    ================================================= -->

    <% if ("admin".equalsIgnoreCase(role)) { %>


        <a href="<%= contextPath %>/admin/dashboard.jsp">

            🏠 Dashboard

        </a>


    <% } %>


    <!-- =================================================
         PROFILE
    ================================================= -->

    <a
        href="<%= contextPath %>/profile"
        class="profile-active">

        👤 My Profile

    </a>


    <!-- =================================================
         LOGOUT
    ================================================= -->

    <div class="logout">

        <a href="<%= contextPath %>/logout">

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


        <div>

            <h1>

                My Profile 👤

            </h1>


            <p>

                View and manage your Virtual Classroom
                account information.

            </p>

        </div>


        <!-- EDIT PROFILE -->

        <a
            href="<%= contextPath %>/edit-profile"
            class="edit-profile-btn">

            ✏️ Edit Profile

        </a>


    </div>



    <!-- =================================================
         SUCCESS MESSAGE
    ================================================= -->

    <% if ("updated".equals(success)) { %>

        <div class="message success">

            ✓ Profile updated successfully!

        </div>

    <% } %>



    <!-- =================================================
         ERROR MESSAGE
    ================================================= -->

    <% if ("notfound".equals(error)) { %>

        <div class="message error">

            ⚠ Profile information could not be found.

        </div>

    <% } %>



    <!-- =================================================
         PROFILE CARD
    ================================================= -->

    <div class="profile-card">


        <!-- PROFILE HEADER -->

        <div class="profile-header">


            <div class="avatar">

                <%= avatarLetter %>

            </div>


            <div class="profile-name">

                <h2>

                    <%= fullname %>

                </h2>


                <span class="role-badge">

                    <%= role %>

                </span>

            </div>


        </div>



        <!-- USER INFORMATION -->

        <div class="info-section">


            <!-- FULL NAME -->

            <div class="info-row">


                <div class="info-icon">

                    👤

                </div>


                <div class="info-content">

                    <span class="info-label">

                        Full Name

                    </span>


                    <span class="info-value">

                        <%= fullname %>

                    </span>

                </div>


            </div>



            <!-- EMAIL -->

            <div class="info-row">


                <div class="info-icon">

                    📧

                </div>


                <div class="info-content">

                    <span class="info-label">

                        Email

                    </span>


                    <span class="info-value">

                        <%= user.getEmail() %>

                    </span>

                </div>


            </div>



            <!-- ROLE -->

            <div class="info-row">


                <div class="info-icon">

                    🎓

                </div>


                <div class="info-content">

                    <span class="info-label">

                        Role

                    </span>


                    <span class="info-value">

                        <%= role %>

                    </span>

                </div>


            </div>



            <!-- USER ID -->

            <div class="info-row">


                <div class="info-icon">

                    🆔

                </div>


                <div class="info-content">

                    <span class="info-label">

                        User ID

                    </span>


                    <span class="info-value">

                        <%= user.getId() %>

                    </span>

                </div>


            </div>


        </div>


    </div>


</div>


</body>

</html>

