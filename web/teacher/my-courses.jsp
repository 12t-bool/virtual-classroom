<%@page import="java.util.List"%>
<%@page import="com.virtualclassroom.model.Course"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
/* =====================================================
   SESSION CHECK
===================================================== */

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


/* =====================================================
   GET COURSES FROM SERVLET
===================================================== */

List<Course> courses =
    (List<Course>) request.getAttribute("courses");

%>

<!DOCTYPE html>

<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>My Courses - Virtual Classroom</title>


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
        5px 0 25px rgba(0,0,0,0.10);

    z-index: 100;
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
        1px solid rgba(255,255,255,0.20);
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
   ACTIVE LINK
===================================================== */

.sidebar a.active {

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

    gap: 20px;

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


/* =====================================================
   CREATE COURSE BUTTON
===================================================== */

.create-btn {

    display: inline-flex;

    align-items: center;

    gap: 8px;

    padding: 13px 20px;

    border-radius: 11px;

    background:
        linear-gradient(
            135deg,
            #4f46e5,
            #7c3aed
        );

    color: white;

    text-decoration: none;

    font-size: 14px;

    font-weight: 700;

    box-shadow:
        0 7px 18px
        rgba(79,70,229,0.25);

    transition:
        transform 0.2s,
        box-shadow 0.2s;
}


.create-btn:hover {

    transform:
        translateY(-2px);

    box-shadow:
        0 10px 25px
        rgba(79,70,229,0.30);
}


/* =====================================================
   COURSES GRID
===================================================== */

.courses-grid {

    display: grid;

    grid-template-columns:
        repeat(3, minmax(0, 1fr));

    gap: 22px;
}


/* =====================================================
   COURSE CARD
===================================================== */

.course-card {

    background: white;

    border-radius: 18px;

    border:
        1px solid #eef0f5;

    box-shadow:
        0 7px 25px
        rgba(0,0,0,0.06);

    padding: 25px;

    position: relative;

    overflow: hidden;

    transition:
        transform 0.25s,
        box-shadow 0.25s;
}


.course-card::before {

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


.course-card:hover {

    transform:
        translateY(-5px);

    box-shadow:
        0 13px 32px
        rgba(0,0,0,0.09);
}


/* =====================================================
   COURSE ICON
===================================================== */

.course-icon {

    width: 55px;
    height: 55px;

    display: flex;

    align-items: center;

    justify-content: center;

    border-radius: 14px;

    background:
        #eef2ff;

    font-size: 27px;

    margin-bottom: 18px;
}


/* =====================================================
   COURSE TITLE
===================================================== */

.course-card h2 {

    color: #312e81;

    font-size: 21px;

    margin-bottom: 10px;

    word-break: break-word;
}


/* =====================================================
   COURSE DESCRIPTION
===================================================== */

.course-card p {

    color: #6b7280;

    font-size: 14px;

    line-height: 1.6;

    min-height: 45px;

    margin-bottom: 18px;
}


/* =====================================================
   COURSE INFO
===================================================== */

.course-info {

    display: flex;

    align-items: center;

    gap: 7px;

    padding-top: 15px;

    border-top:
        1px solid #eef0f5;

    color: #6b7280;

    font-size: 13px;

    margin-bottom: 18px;
}


/* =====================================================
   COURSE ID
===================================================== */

.course-id {

    display: inline-block;

    padding: 5px 9px;

    border-radius: 7px;

    background: #f5f3ff;

    color: #5b21b6;

    font-weight: 600;

    font-size: 12px;
}


/* =====================================================
   CARD BUTTONS
===================================================== */

.course-actions {

    display: flex;

    gap: 9px;
}


.action-btn {

    flex: 1;

    text-align: center;

    padding: 10px 12px;

    border-radius: 9px;

    text-decoration: none;

    font-size: 13px;

    font-weight: 700;

    transition:
        transform 0.2s,
        opacity 0.2s;
}


.action-btn:hover {

    transform:
        translateY(-2px);

    opacity: 0.9;
}


/* EDIT */

.edit-btn {

    background:
        #eef2ff;

    color:
        #4338ca;
}


/* DELETE */

.delete-btn {

    background:
        #fef2f2;

    color:
        #dc2626;
}


/* =====================================================
   NO COURSES
===================================================== */

.no-courses {

    background: white;

    border-radius: 20px;

    padding: 70px 40px;

    text-align: center;

    border:
        1px solid #eef0f5;

    box-shadow:
        0 8px 30px
        rgba(0,0,0,0.06);
}


.no-courses-icon {

    width: 95px;
    height: 95px;

    margin:
        0 auto 22px;

    display: flex;

    align-items: center;

    justify-content: center;

    border-radius: 50%;

    background:
        linear-gradient(
            135deg,
            #eef2ff,
            #e0e7ff
        );

    font-size: 43px;
}


.no-courses h2 {

    color: #312e81;

    font-size: 24px;

    margin-bottom: 10px;
}


.no-courses p {

    color: #6b7280;

    line-height: 1.6;

    max-width: 450px;

    margin:
        0 auto 22px;
}


/* =====================================================
   RESPONSIVE
===================================================== */

@media (max-width: 1100px) {

    .courses-grid {

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


    .header {

        align-items: flex-start;

        flex-direction: column;
    }

}


@media (max-width: 600px) {

    .courses-grid {

        grid-template-columns: 1fr;
    }


    .main {

        padding: 20px;
    }


    .header h1 {

        font-size: 27px;
    }


    .course-actions {

        flex-direction: column;
    }


    .no-courses {

        padding: 50px 25px;
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

    <a href="<%= contextPath %>/teacher/dashboard.jsp">

        🏠 Dashboard

    </a>


    <!-- MY COURSES -->

    <a
        href="<%= contextPath %>/teacher/my-courses"
        class="active">

        📚 My Courses

    </a>


    <!-- STUDY MATERIALS -->

    <a href="<%= contextPath %>/teacher/study-materials">

        📖 Study Materials

    </a>


    <!-- ASSIGNMENTS -->

    <a href="<%= contextPath %>/teacher/assignments">

        📝 Assignments

    </a>


    <!-- SUBMISSIONS -->

    <a href="<%= contextPath %>/teacher/submissions">

        👨‍🎓 Student Submissions

    </a>


    <!-- ANNOUNCEMENTS -->

    <a href="<%= contextPath %>/teacher/announcements">

        📢 Announcements

    </a>


    <!-- PROFILE -->

    <a href="<%= contextPath %>/profile">

        👤 My Profile

    </a>


    <!-- LOGOUT -->

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

                My Courses 📚

            </h1>


            <p>

                View, edit and manage the courses
                you have created.

            </p>

        </div>


        <!-- CREATE COURSE -->

        <a
            href="<%= contextPath %>/teacher/create-course"
            class="create-btn">

            ➕ Create Course

        </a>


    </div>


    <!-- =================================================
         COURSES
    ================================================= -->

    <% if (courses != null && !courses.isEmpty()) { %>


        <div class="courses-grid">


            <% for (Course course : courses) { %>


                <div class="course-card">


                    <!-- COURSE ICON -->

                    <div class="course-icon">

                        📚

                    </div>


                    <!-- COURSE NAME -->

                    <h2>

                        <%= course.getCourseName() %>

                    </h2>


                    <!-- DESCRIPTION -->

                    <p>

                        <%
                        String description =
                            course.getDescription();

                        if (description != null &&
                            !description.trim().isEmpty()) {

                            out.print(description);

                        } else {

                            out.print(
                                "No description available for this course."
                            );

                        }
                        %>

                    </p>


                    <!-- COURSE ID -->

                    <div class="course-info">

                        <span>

                            Course ID:

                        </span>


                        <span class="course-id">

                            <%= course.getId() %>

                        </span>

                    </div>


                    <!-- ACTIONS -->

                    <div class="course-actions">


                        <!-- EDIT -->

                        <a
                            href="<%= contextPath %>/teacher/edit-course?id=<%= course.getId() %>"
                            class="action-btn edit-btn">

                            ✏️ Edit

                        </a>


                        <!-- DELETE -->

                        <a
                            href="<%= contextPath %>/teacher/delete-course?id=<%= course.getId() %>"
                            class="action-btn delete-btn"
                            onclick="return confirm('Are you sure you want to delete this course?');">

                            🗑️ Delete

                        </a>


                    </div>


                </div>


            <% } %>


        </div>


    <% } else { %>


        <!-- =================================================
             NO COURSES
        ================================================= -->

        <div class="no-courses">


            <div class="no-courses-icon">

                📚

            </div>


            <h2>

                No Courses Yet

            </h2>


            <p>

                You haven't created any courses yet.
                Create your first course and it will
                appear here.

            </p>


            <a
                href="<%= contextPath %>/teacher/create-course"
                class="create-btn">

                ➕ Create Your First Course

            </a>


        </div>


    <% } %>


</div>


</body>

</html>