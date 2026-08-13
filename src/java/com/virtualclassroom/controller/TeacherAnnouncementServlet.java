package com.virtualclassroom.controller;

import com.virtualclassroom.dao.AnnouncementDAO;
import com.virtualclassroom.dao.CourseDAO;
import com.virtualclassroom.model.Announcement;
import com.virtualclassroom.model.Course;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/teacher/announcements")
public class TeacherAnnouncementServlet
extends HttpServlet {


private CourseDAO courseDAO;
private AnnouncementDAO announcementDAO;

@Override
public void init() {

    courseDAO = new CourseDAO();
    announcementDAO = new AnnouncementDAO();
}

@Override
protected void doGet(
        HttpServletRequest request,
        HttpServletResponse response)
        throws ServletException, IOException {

    HttpSession session =
            request.getSession(false);

    // Make sure teacher is logged in
    if (session == null ||
        session.getAttribute("userId") == null ||
        !"teacher".equalsIgnoreCase(
                (String) session.getAttribute("role"))) {

        response.sendRedirect("../login.jsp");
        return;
    }

    int teacherId =
            (Integer) session.getAttribute(
                    "userId"
            );

    // Get courses belonging to this teacher
    List<Course> courses =
            courseDAO.getCoursesByTeacher(
                    teacherId
            );

    // Get announcements created by this teacher
    List<Announcement> announcements =
            announcementDAO
                    .getAnnouncementsByTeacher(
                            teacherId
                    );

    request.setAttribute(
            "courses",
            courses
    );

    request.setAttribute(
            "announcements",
            announcements
    );

    request.getRequestDispatcher(
            "/teacher/announcements.jsp"
    ).forward(
            request,
            response
    );
}

@Override
protected void doPost(
        HttpServletRequest request,
        HttpServletResponse response)
        throws ServletException, IOException {

    HttpSession session =
            request.getSession(false);

    // Make sure teacher is logged in
    if (session == null ||
        session.getAttribute("userId") == null ||
        !"teacher".equalsIgnoreCase(
                (String) session.getAttribute("role"))) {

        response.sendRedirect("../login.jsp");
        return;
    }

    String courseIdParameter =
            request.getParameter("courseId");

    String title =
            request.getParameter("title");

    String message =
            request.getParameter("message");

    // Validate fields
    if (courseIdParameter == null ||
        courseIdParameter.trim().isEmpty() ||
        title == null ||
        title.trim().isEmpty() ||
        message == null ||
        message.trim().isEmpty()) {

        response.sendRedirect(
                "announcements?error=empty"
        );

        return;
    }

    try {

        int courseId =
                Integer.parseInt(
                        courseIdParameter
                );

        int teacherId =
                (Integer) session.getAttribute(
                        "userId"
                );

        // Verify course belongs to teacher
        List<Course> courses =
                courseDAO.getCoursesByTeacher(
                        teacherId
                );

        boolean ownsCourse = false;

        for (Course course : courses) {

            if (course.getId() == courseId) {

                ownsCourse = true;
                break;
            }
        }

        if (!ownsCourse) {

            response.sendRedirect(
                    "announcements?error=unauthorized"
            );

            return;
        }

        // Create announcement
        Announcement announcement =
                new Announcement(
                        teacherId,
                        courseId,
                        title.trim(),
                        message.trim()
                );

        // Save announcement
        boolean added =
                announcementDAO.addAnnouncement(
                        announcement
                );

        if (added) {

            response.sendRedirect(
                    "announcements?success=added"
            );

        } else {

            response.sendRedirect(
                    "announcements?error=failed"
            );
        }

    } catch (NumberFormatException e) {

        response.sendRedirect(
                "announcements?error=invalid"
        );

    } catch (Exception e) {

        e.printStackTrace();

        response.sendRedirect(
                "announcements?error=failed"
        );
    }
}


}
