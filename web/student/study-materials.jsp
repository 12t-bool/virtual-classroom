<%@page import="java.util.List"%>
<%@page import="com.virtualclassroom.model.StudyMaterial"%>
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

List<StudyMaterial> materials =
    (List<StudyMaterial>) request.getAttribute("materials");

String contextPath = request.getContextPath();

int materialCount = 0;

if (materials != null) {
    materialCount = materials.size();
}
%>

<!DOCTYPE html>

<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>Study Materials - Virtual Classroom</title>

<style>

/* =========================================
   RESET
========================================= */

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}


/* =========================================
   BODY
========================================= */

body {
    font-family: Arial, sans-serif;
    background: #f5f7fb;
    color: #1f2937;
}


/* =========================================
   SIDEBAR
========================================= */

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
        5px 0 20px rgba(0,0,0,0.08);
}


.logo {
    font-size: 21px;

    font-weight: bold;

    text-align: center;

    margin-bottom: 35px;

    padding-bottom: 20px;

    border-bottom:
        1px solid rgba(255,255,255,0.2);
}


.sidebar a {
    display: flex;

    align-items: center;

    gap: 8px;

    color: white;

    text-decoration: none;

    padding: 13px 15px;

    margin-bottom: 7px;

    border-radius: 10px;

    transition: 0.25s;
}


.sidebar a:hover {
    background:
        rgba(255,255,255,0.15);

    transform:
        translateX(3px);
}


/* =========================================
   LOGOUT
========================================= */

.logout {
    margin-top: 25px;

    padding-top: 20px;

    border-top:
        1px solid rgba(255,255,255,0.2);
}


.logout a {
    background: #dc2626;
}


.logout a:hover {
    background: #b91c1c;
}


/* =========================================
   MAIN
========================================= */

.main {
    margin-left: 245px;

    padding: 40px;
}


/* =========================================
   HEADER
========================================= */

.header {
    margin-bottom: 30px;
}


.header h1 {
    font-size: 32px;

    color: #312e81;

    margin-bottom: 8px;
}


.header p {
    color: #6b7280;

    font-size: 15px;
}


/* =========================================
   STAT BOX
========================================= */

.stat-box {
    display: flex;

    align-items: center;

    gap: 18px;

    background: white;

    padding: 20px 24px;

    border-radius: 16px;

    max-width: 280px;

    margin-bottom: 30px;

    box-shadow:
        0 6px 25px rgba(0,0,0,0.06);
}


.stat-icon {
    width: 55px;

    height: 55px;

    display: flex;

    align-items: center;

    justify-content: center;

    background: #eef2ff;

    border-radius: 14px;

    font-size: 28px;
}


.stat-number {
    font-size: 25px;

    font-weight: bold;

    color: #312e81;
}


.stat-label {
    color: #6b7280;

    font-size: 13px;

    margin-top: 3px;
}


/* =========================================
   MATERIAL GRID
========================================= */

.materials {
    display: grid;

    grid-template-columns:
        repeat(3, minmax(0, 1fr));

    gap: 24px;
}


/* =========================================
   MATERIAL CARD
========================================= */

.material-card {
    background: white;

    padding: 25px;

    border-radius: 18px;

    border:
        1px solid #eef0f5;

    box-shadow:
        0 6px 25px rgba(0,0,0,0.06);

    position: relative;

    overflow: hidden;

    transition:
        transform 0.25s,
        box-shadow 0.25s;
}


.material-card::before {
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


.material-card:hover {
    transform:
        translateY(-6px);

    box-shadow:
        0 15px 35px rgba(0,0,0,0.10);
}


/* =========================================
   MATERIAL ICON
========================================= */

.material-icon {
    width: 60px;

    height: 60px;

    display: flex;

    align-items: center;

    justify-content: center;

    background: #eef2ff;

    border-radius: 15px;

    font-size: 30px;

    margin-bottom: 18px;
}


/* =========================================
   TITLE
========================================= */

.material-card h2 {
    color: #312e81;

    font-size: 20px;

    line-height: 1.3;

    margin-bottom: 10px;
}


/* =========================================
   DESCRIPTION
========================================= */

.material-card p {
    color: #6b7280;

    line-height: 1.6;

    font-size: 14px;

    min-height: 70px;
}


/* =========================================
   MATERIAL INFO
========================================= */

.material-info {
    margin-top: 18px;

    padding-top: 15px;

    border-top:
        1px solid #edf0f5;

    color: #9ca3af;

    font-size: 13px;
}


.material-info strong {
    color: #4f46e5;
}


/* =========================================
   OPEN BUTTON
========================================= */

.open-btn {
    display: block;

    margin-top: 18px;

    padding: 12px;

    background: #4f46e5;

    color: white;

    text-align: center;

    text-decoration: none;

    border-radius: 9px;

    font-weight: bold;

    font-size: 14px;

    transition: 0.2s;
}


.open-btn:hover {
    background: #4338ca;

    transform:
        translateY(-2px);
}


/* =========================================
   NO FILE
========================================= */

.no-link {
    margin-top: 18px;

    padding: 12px;

    background: #f3f4f6;

    color: #9ca3af;

    text-align: center;

    border-radius: 9px;

    font-size: 14px;
}


/* =========================================
   EMPTY STATE
========================================= */

.empty {
    background: white;

    padding: 70px 40px;

    border-radius: 18px;

    text-align: center;

    box-shadow:
        0 6px 25px rgba(0,0,0,0.06);
}


.empty-icon {
    width: 85px;

    height: 85px;

    margin:
        0 auto 20px;

    border-radius: 50%;

    background: #eef2ff;

    display: flex;

    align-items: center;

    justify-content: center;

    font-size: 40px;
}


.empty h2 {
    color: #312e81;

    margin-bottom: 10px;
}


.empty p {
    color: #777;

    line-height: 1.6;

    max-width: 500px;

    margin: auto;
}


/* =========================================
   RESPONSIVE
========================================= */

@media (max-width: 1100px) {

    .materials {
        grid-template-columns:
            repeat(2, minmax(0, 1fr));
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

}


@media (max-width: 600px) {

    .materials {
        grid-template-columns: 1fr;
    }

    .main {
        padding: 20px;
    }

    .header h1 {
        font-size: 27px;
    }

    .stat-box {
        max-width: 100%;
    }

}

</style>

</head>


<body>


<!-- =========================================
     SIDEBAR
========================================= -->

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


<!-- =========================================
     MAIN CONTENT
========================================= -->

<div class="main">


    <!-- HEADER -->

    <div class="header">

        <h1>
            Study Materials 📖
        </h1>

        <p>
            Access learning materials for your enrolled courses.
        </p>

    </div>


    <!-- =========================================
         MATERIAL COUNT
    ========================================= -->

    <div class="stat-box">

        <div class="stat-icon">
            📖
        </div>

        <div>

            <div class="stat-number">
                <%= materialCount %>
            </div>

            <div class="stat-label">
                Available Materials
            </div>

        </div>

    </div>


    <!-- =========================================
         MATERIALS
    ========================================= -->

    <% if (materials != null &&
           !materials.isEmpty()) { %>


        <div class="materials">


            <% for (StudyMaterial material : materials) { %>


                <div class="material-card">


                    <div class="material-icon">
                        📖
                    </div>


                    <h2>
                        <%= material.getTitle() %>
                    </h2>


                    <p>

                        <%= material.getDescription() != null
                            ? material.getDescription()
                            : "No description available." %>

                    </p>


                    <div class="material-info">

                        Course ID:

                        <strong>
                            #<%= material.getCourseId() %>
                        </strong>

                    </div>


                    <% if (material.getFileUrl() != null &&
                           !material.getFileUrl().trim().isEmpty()) { %>


                        <a
                            href="<%= material.getFileUrl() %>"
                            target="_blank"
                            class="open-btn">

                            📂 Open Material

                        </a>


                    <% } else { %>


                        <div class="no-link">

                            📄 No file available

                        </div>


                    <% } %>


                </div>


            <% } %>


        </div>


    <% } else { %>


        <!-- =========================================
             EMPTY STATE
        ========================================= -->

        <div class="empty">


            <div class="empty-icon">
                📖
            </div>


            <h2>
                No Study Materials Yet
            </h2>


            <p>
                There are currently no study materials
                available for your enrolled courses.
            </p>


        </div>


    <% } %>


</div>


</body>

</html>