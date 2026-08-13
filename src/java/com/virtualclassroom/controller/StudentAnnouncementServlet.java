package com.virtualclassroom.controller;

import com.virtualclassroom.dao.AnnouncementDAO;
import com.virtualclassroom.dao.EnrollmentDAO;
import com.virtualclassroom.model.Announcement;
import com.virtualclassroom.model.Course;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/student/announcements")
public class StudentAnnouncementServlet
extends HttpServlet {


private EnrollmentDAO enrollmentDAO;
private AnnouncementDAO announcementDAO;

@Override
public void init() {

    enrollmentDAO = new EnrollmentDAO();
    announcementDAO = new AnnouncementDAO();
}

@Override
protected void doGet(
        HttpServletRequest request,
        HttpServletResponse response)
        throws ServletException, IOException {

    HttpSession session =
            request.getSession(false);

    // Make sure student is logged in
    if (session == null ||
        session.getAttribute("userId") == null ||
        !"student".equalsIgnoreCase(
                (String) session.getAttribute("role"))) {

        response.sendRedirect("../login.jsp");
        return;
    }

    int studentId =
            (Integer) session.getAttribute(
                    "userId"
            );

    // Get courses enrolled by the student
    List<Course> enrolledCourses =
            enrollmentDAO.getStudentCourses(
                    studentId
            );

    List<Integer> courseIds =
            new ArrayList<>();

    if (enrolledCourses != null) {

        for (Course course :
                enrolledCourses) {

            courseIds.add(
                    course.getId()
            );
        }
    }

    // Get announcements for enrolled courses
    List<Announcement> announcements =
            announcementDAO
                    .getAnnouncementsByCourses(
                            courseIds
                    );

    request.setAttribute(
            "announcements",
            announcements
    );

    request.getRequestDispatcher(
            "/student/announcements.jsp"
    ).forward(
            request,
            response
    );
}


}
