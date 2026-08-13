<%@page import="java.util.List"%>
<%@page import="com.virtualclassroom.model.Announcement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
String fullname = (String) session.getAttribute("fullname");
String role = (String) session.getAttribute("role");

if (fullname == null ||
    role == null ||
    !"student".equalsIgnoreCase(role)) {

    response.sendRedirect(
        request.getContextPath() + "/login.jsp"
    );

    return;
}

List<Announcement> announcements =
        (List<Announcement>)
        request.getAttribute("announcements");

String contextPath = request.getContextPath();
%>

<!DOCTYPE html>

<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>Announcements - Virtual Classroom</title>

<style>

/* =========================
   RESET
========================= */

* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}


/* =========================
   BODY
========================= */

body {
    font-family: Arial, sans-serif;

    background: #f5f7fb;

    color: #333;
}


/* =========================
   SIDEBAR
========================= */

.sidebar {
    position: fixed;

    left: 0;
    top: 0;

    width: 240px;
    height: 100vh;

    background:
        linear-gradient(
            180deg,
            #4f46e5,
            #4338ca
        );

    color: white;

    padding: 25px 20px;

    box-shadow:
        5px 0 20px rgba(0,0,0,0.08);
}


.logo {
    font-size: 21px;

    font-weight: bold;

    text-align: center;

    margin-bottom: 40px;
}


.sidebar a {
    display: block;

    color: white;

    text-decoration: none;

    padding: 13px 15px;

    margin-bottom: 8px;

    border-radius: 9px;

    transition: 0.25s;
}


.sidebar a:hover {
    background: rgba(255,255,255,0.15);

    transform: translateX(4px);
}


/* =========================
   LOGOUT
========================= */

.logout {
    margin-top: 30px;
}


.logout a {
    background: #dc2626;
}


.logout a:hover {
    background: #b91c1c;
}


/* =========================
   MAIN
========================= */

.main {
    margin-left: 240px;

    padding: 40px;
}


/* =========================
   HEADER
========================= */

.header {
    margin-bottom: 30px;
}


.header h1 {
    font-size: 32px;

    color: #4f46e5;

    margin-bottom: 8px;
}


.header p {
    color: #777;

    font-size: 15px;
}


/* =========================
   ANNOUNCEMENTS
========================= */

.announcements {
    max-width: 950px;
}


/* =========================
   ANNOUNCEMENT CARD
========================= */

.announcement-card {
    position: relative;

    background: white;

    padding: 28px;

    border-radius: 18px;

    margin-bottom: 22px;

    box-shadow:
        0 5px 20px rgba(0,0,0,0.06);

    overflow: hidden;

    transition:
        transform 0.25s,
        box-shadow 0.25s;
}


.announcement-card::before {
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
            #7c3aed,
            #a855f7
        );
}


.announcement-card:hover {
    transform: translateY(-5px);

    box-shadow:
        0 15px 35px rgba(0,0,0,0.10);
}


/* =========================
   ICON
========================= */

.announcement-icon {
    width: 62px;
    height: 62px;

    display: flex;

    align-items: center;
    justify-content: center;

    background: #eef2ff;

    border-radius: 15px;

    font-size: 30px;

    margin-bottom: 18px;
}


/* =========================
   TITLE
========================= */

.announcement-card h2 {
    color: #312e81;

    font-size: 22px;

    margin-bottom: 15px;
}


/* =========================
   MESSAGE
========================= */

.announcement-message {
    color: #555;

    font-size: 15px;

    line-height: 1.8;

    margin-bottom: 22px;

    white-space: pre-line;
}


/* =========================
   INFO
========================= */

.announcement-info {
    display: flex;

    flex-wrap: wrap;

    gap: 10px 25px;

    padding-top: 17px;

    border-top:
        1px solid #eee;

    color: #777;

    font-size: 14px;
}


.info-item {
    display: flex;

    align-items: center;

    gap: 6px;
}


.info-item strong {
    color: #4f46e5;
}


/* =========================
   EMPTY STATE
========================= */

.empty {
    max-width: 950px;

    background: white;

    padding: 70px 40px;

    border-radius: 18px;

    text-align: center;

    box-shadow:
        0 5px 20px rgba(0,0,0,0.06);
}


.empty-icon {
    width: 80px;
    height: 80px;

    margin: 0 auto 20px;

    display: flex;

    align-items: center;
    justify-content: center;

    background: #eef2ff;

    border-radius: 20px;

    font-size: 42px;
}


.empty h2 {
    color: #333;

    margin-bottom: 10px;
}


.empty p {
    color: #777;

    line-height: 1.6;
}


/* =========================
   RESPONSIVE
========================= */

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

    .announcements,
    .empty {
        max-width: 100%;
    }

}


@media (max-width: 500px) {

    .main {
        padding: 20px;
    }

    .header h1 {
        font-size: 27px;
    }

    .announcement-card {
        padding: 22px;
    }

    .announcement-info {
        flex-direction: column;

        gap: 10px;
    }

}

</style>

</head>


<body>


<!-- =========================
     SIDEBAR
========================= -->

<div class="sidebar">

    <div class="logo">
        🎓 Virtual Classroom
    </div>


    <a href="<%= contextPath %>/student/dashboard.jsp">
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


    <a href="<%= contextPath %>/profile">
        👤 My Profile
    </a>


    <div class="logout">

        <a href="<%= contextPath %>/logout">
            🚪 Logout
        </a>

    </div>

</div>



<!-- =========================
     MAIN CONTENT
========================= -->

<div class="main">


    <div class="header">

        <h1>
            Announcements 📢
        </h1>

        <p>
            Stay updated with important announcements
            from your courses.
        </p>

    </div>



    <!-- =========================
         ANNOUNCEMENTS
    ========================= -->

    <% if (announcements != null &&
           !announcements.isEmpty()) { %>


        <div class="announcements">


            <% for (Announcement announcement :
                    announcements) { %>


                <div class="announcement-card">


                    <div class="announcement-icon">
                        📢
                    </div>


                    <h2>
                        <%= announcement.getTitle() %>
                    </h2>


                    <div class="announcement-message">

                        <%= announcement.getMessage() %>

                    </div>


                    <div class="announcement-info">


                        <div class="info-item">

                            📚

                            <span>
                                Course ID:
                            </span>

                            <strong>
                                <%= announcement.getCourseId() %>
                            </strong>

                        </div>


                        <div class="info-item">

                            🕐

                            <span>
                                Posted:
                            </span>

                            <strong>
                                <%= announcement.getCreatedAt() %>
                            </strong>

                        </div>


                    </div>


                </div>


            <% } %>


        </div>


    <% } else { %>


        <!-- =========================
             EMPTY STATE
        ========================= -->

        <div class="empty">


            <div class="empty-icon">
                📢
            </div>


            <h2>
                No Announcements Yet
            </h2>


            <p>
                There are currently no announcements
                for your enrolled courses.
            </p>


        </div>


    <% } %>


</div>


</body>

</html>