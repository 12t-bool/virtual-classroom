package com.virtualclassroom.controller;

import com.virtualclassroom.dao.CourseDAO;
import com.virtualclassroom.model.Course;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/courses")
public class BrowseCoursesServlet extends HttpServlet {

private CourseDAO courseDAO;

@Override
public void init() {
    courseDAO = new CourseDAO();
}

@Override
protected void doGet(
        HttpServletRequest request,
        HttpServletResponse response)
        throws ServletException, IOException {

    HttpSession session =
            request.getSession(false);

    // Make sure a student is logged in
    if (session == null ||
        session.getAttribute("userId") == null ||
        !"student".equalsIgnoreCase(
                (String) session.getAttribute("role"))) {

        response.sendRedirect(
                request.getContextPath() + "/login.jsp"
        );

        return;
    }

    // Get all available courses
    List<Course> courses =
            courseDAO.getAllCourses();

    // Send courses to JSP
    request.setAttribute(
            "courses",
            courses
    );

    // Open Browse Courses page
    request.getRequestDispatcher(
            "/student/courses.jsp"
    ).forward(
            request,
            response
    );
}


}
