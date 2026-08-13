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

@WebServlet("/teacher/my-courses")
public class TeacherMyCoursesServlet extends HttpServlet {

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

        // =========================================
        // CHECK TEACHER SESSION
        // =========================================

        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("userId") == null ||
            session.getAttribute("role") == null ||
            !"teacher".equalsIgnoreCase(
                    String.valueOf(
                            session.getAttribute("role")))) {

            response.sendRedirect(
                    request.getContextPath() +
                    "/login.jsp"
            );

            return;
        }


        // =========================================
        // GET TEACHER ID
        // =========================================

        Object userIdObject =
                session.getAttribute("userId");

        int teacherId;

        try {

            teacherId =
                    Integer.parseInt(
                            String.valueOf(userIdObject)
                    );

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath() +
                    "/login.jsp"
            );

            return;
        }


        // =========================================
        // GET TEACHER COURSES
        // =========================================

        List<Course> courses =
                courseDAO.getCoursesByTeacher(
                        teacherId
                );


        // =========================================
        // SEND COURSES TO JSP
        // =========================================

        request.setAttribute(
                "courses",
                courses
        );


        // =========================================
        // OPEN JSP
        // =========================================

        request.getRequestDispatcher(
                "/teacher/my-courses.jsp"
        ).forward(
                request,
                response
        );
    }
}