<%@page import="com.virtualclassroom.model.Course"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String fullname =
            (String) session.getAttribute("fullname");

    String role =
            (String) session.getAttribute("role");

    if (fullname == null ||
        role == null ||
        !"teacher".equalsIgnoreCase(role)) {

        response.sendRedirect(
                request.getContextPath() + "/login.jsp"
        );

        return;
    }

    Course course =
            (Course) request.getAttribute("course");

    if (course == null) {

        response.sendRedirect(
                request.getContextPath() +
                "/teacher/my-courses.jsp?error=notfound"
        );

        return;
    }

    String contextPath =
            request.getContextPath();
%>

<!DOCTYPE html>

<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>Edit Course - Virtual Classroom</title>


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
            #4f46e5 0%,
            #3730a3 100%
        );

    color: white;

    padding: 25px 18px;

    box-shadow:
        5px 0 25px rgba(0,0,0,0.10);

    z-index: 100;
}


/* =========================================
   LOGO
========================================= */

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


/* =========================================
   SIDEBAR LINKS
========================================= */

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


/* =========================================
   ACTIVE LINK
========================================= */

.sidebar a.active {

    background:
        rgba(255,255,255,0.18);

    box-shadow:
        inset 3px 0 0 white;
}


/* =========================================
   LOGOUT
========================================= */

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


/* =========================================
   HEADER ICON
========================================= */

.header-icon {

    width: 62px;
    height: 62px;

    display: flex;

    align-items: center;
    justify-content: center;

    border-radius: 16px;

    background:
        linear-gradient(
            135deg,
            #eef2ff,
            #e0e7ff
        );

    font-size: 29px;

    box-shadow:
        0 8px 20px
        rgba(79,70,229,0.10);
}


/* =========================================
   FORM CARD
========================================= */

.form-card {

    width: 100%;

    max-width: 760px;

    background: white;

    padding: 38px;

    border-radius: 20px;

    border:
        1px solid #eef0f5;

    box-shadow:
        0 8px 30px
        rgba(0,0,0,0.06);

    position: relative;

    overflow: hidden;
}


/* =========================================
   TOP ACCENT
========================================= */

.form-card::before {

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


/* =========================================
   COURSE ID
========================================= */

.course-id {

    display: flex;

    align-items: center;

    gap: 10px;

    margin-bottom: 30px;

    padding: 14px 17px;

    background:
        linear-gradient(
            135deg,
            #eef2ff,
            #f5f3ff
        );

    color: #4338ca;

    border:
        1px solid #e0e7ff;

    border-radius: 11px;

    font-size: 14px;

    font-weight: 700;
}


.course-id::before {

    content: "📚";

    font-size: 19px;
}


/* =========================================
   FORM GROUP
========================================= */

.form-group {

    margin-bottom: 24px;
}


/* =========================================
   LABEL
========================================= */

.form-group label {

    display: block;

    margin-bottom: 9px;

    color: #374151;

    font-size: 14px;

    font-weight: 700;
}


/* =========================================
   INPUT + TEXTAREA
========================================= */

.form-group input,
.form-group textarea {

    width: 100%;

    padding: 14px 15px;

    border:
        1px solid #d1d5db;

    border-radius: 11px;

    background: #f9fafb;

    color: #111827;

    font-size: 15px;

    font-family:
        "Segoe UI",
        Arial,
        sans-serif;

    transition:
        border-color 0.2s,
        box-shadow 0.2s,
        background 0.2s;
}


.form-group input:hover,
.form-group textarea:hover {

    border-color: #a5b4fc;
}


.form-group input:focus,
.form-group textarea:focus {

    outline: none;

    background: white;

    border-color: #4f46e5;

    box-shadow:
        0 0 0 4px
        rgba(79,70,229,0.10);
}


/* =========================================
   TEXTAREA
========================================= */

.form-group textarea {

    min-height: 170px;

    resize: vertical;

    line-height: 1.6;
}


/* =========================================
   BUTTON AREA
========================================= */

.buttons {

    display: flex;

    gap: 12px;

    margin-top: 30px;

    padding-top: 25px;

    border-top:
        1px solid #eef0f5;
}


/* =========================================
   COMMON BUTTON
========================================= */

.btn {

    display: inline-flex;

    align-items: center;

    justify-content: center;

    gap: 7px;

    padding: 13px 22px;

    border: none;

    border-radius: 10px;

    font-size: 14px;

    font-weight: 700;

    text-decoration: none;

    cursor: pointer;

    transition:
        transform 0.2s,
        box-shadow 0.2s,
        background 0.2s;
}


/* =========================================
   SAVE BUTTON
========================================= */

.save-btn {

    flex: 1;

    background:
        linear-gradient(
            135deg,
            #4f46e5,
            #6366f1
        );

    color: white;

    box-shadow:
        0 7px 18px
        rgba(79,70,229,0.20);
}


.save-btn:hover {

    transform:
        translateY(-2px);

    box-shadow:
        0 11px 25px
        rgba(79,70,229,0.28);
}


/* =========================================
   CANCEL BUTTON
========================================= */

.cancel-btn {

    flex: 1;

    background: #f3f4f6;

    color: #374151;

    border:
        1px solid #e5e7eb;
}


.cancel-btn:hover {

    background: #e5e7eb;

    transform:
        translateY(-2px);
}


/* =========================================
   FORM FOOTER
========================================= */

.form-footer {

    margin-top: 22px;

    text-align: center;

    color: #9ca3af;

    font-size: 12px;
}


/* =========================================
   RESPONSIVE
========================================= */

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
    }


    .form-card {

        max-width: 100%;
    }

}


@media (max-width: 600px) {

    .main {

        padding: 20px;
    }


    .header h1 {

        font-size: 26px;
    }


    .header-icon {

        width: 52px;
        height: 52px;

        font-size: 24px;
    }


    .form-card {

        padding: 28px 22px;

        border-radius: 16px;
    }


    .buttons {

        flex-direction: column;
    }


    .btn {

        width: 100%;
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


    <a href="<%= contextPath %>/teacher/dashboard.jsp">
        🏠 Dashboard
    </a>


    <a
        href="<%= contextPath %>/teacher/my-courses.jsp"
        class="active">

        📚 My Courses

    </a>


    <a href="<%= contextPath %>/teacher/study-materials">
        📖 Study Materials
    </a>


    <a href="<%= contextPath %>/teacher/assignments.jsp">
        📝 Assignments
    </a>


    <a href="<%= contextPath %>/teacher/announcements">
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


        <div>

            <h1>
                ✏️ Edit Course
            </h1>

            <p>
                Update your course information and keep
                your content up to date.
            </p>

        </div>


        <div class="header-icon">
            📚
        </div>


    </div>


    <!-- =========================================
         FORM CARD
    ========================================= -->

    <div class="form-card">


        <!-- COURSE ID -->

        <div class="course-id">

            Course ID:
            #<%= course.getId() %>

        </div>


        <form
            action="<%= contextPath %>/teacher/edit-course"
            method="post">


            <!-- HIDDEN COURSE ID -->

            <input
                type="hidden"
                name="id"
                value="<%= course.getId() %>">


            <!-- COURSE NAME -->

            <div class="form-group">

                <label for="courseName">

                    Course Name

                </label>


                <input
                    type="text"
                    id="courseName"
                    name="courseName"
                    value="<%= course.getCourseName() %>"
                    placeholder="Enter course name"
                    required>

            </div>


            <!-- DESCRIPTION -->

            <div class="form-group">

                <label for="description">

                    Course Description

                </label>


                <textarea
                    id="description"
                    name="description"
                    placeholder="Enter course description"
                    required><%= course.getDescription() %></textarea>

            </div>


            <!-- BUTTONS -->

            <div class="buttons">


                <button
                    type="submit"
                    class="btn save-btn">

                    💾 Save Changes

                </button>


                <a
                    href="<%= contextPath %>/teacher/my-courses.jsp"
                    class="btn cancel-btn">

                    ← Cancel

                </a>


            </div>


        </form>


        <div class="form-footer">

            🔒 Your course changes will be saved securely.

        </div>


    </div>


</div>


</body>

</html>