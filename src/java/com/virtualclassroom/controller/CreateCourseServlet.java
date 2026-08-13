package com.virtualclassroom.controller;

import com.virtualclassroom.dao.CourseDAO;
import com.virtualclassroom.model.Course;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/teacher/create-course")
public class CreateCourseServlet extends HttpServlet {

    private CourseDAO courseDAO;

    @Override
    public void init() {

        courseDAO = new CourseDAO();
    }


    // =====================================================
    // GET - OPEN CREATE COURSE PAGE
    // =====================================================

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // ==========================================
        // CHECK TEACHER LOGIN
        // ==========================================

        HttpSession session =
                request.getSession(false);

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


        // ==========================================
        // OPEN CREATE COURSE JSP
        // ==========================================

        request.getRequestDispatcher(
                "/teacher/create-course.jsp"
        ).forward(
                request,
                response
        );
    }


    // =====================================================
    // POST - CREATE COURSE
    // =====================================================

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // ==========================================
        // CHECK TEACHER LOGIN
        // ==========================================

        HttpSession session =
                request.getSession(false);

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


        // ==========================================
        // GET TEACHER ID
        // ==========================================

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


        // ==========================================
        // GET FORM DATA
        // ==========================================

        String courseName =
                request.getParameter("courseName");

        String description =
                request.getParameter("description");


        // ==========================================
        // VALIDATE COURSE NAME
        // ==========================================

        if (courseName == null ||
            courseName.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath() +
                    "/teacher/create-course?error=empty"
            );

            return;
        }


        // ==========================================
        // CLEAN DATA
        // ==========================================

        courseName =
                courseName.trim();

        if (description != null) {

            description =
                    description.trim();

        } else {

            description = "";
        }


        // ==========================================
        // CREATE COURSE OBJECT
        // ==========================================

        Course course =
                new Course();

        course.setCourseName(
                courseName
        );

        course.setDescription(
                description
        );

        course.setTeacherId(
                teacherId
        );


        // ==========================================
        // SAVE COURSE
        // ==========================================

        boolean added =
                courseDAO.addCourse(
                        course
                );


        // ==========================================
        // RESULT
        // ==========================================

        if (added) {

            response.sendRedirect(
                    request.getContextPath() +
                    "/teacher/my-courses?success=created"
            );

        } else {

            response.sendRedirect(
                    request.getContextPath() +
                    "/teacher/create-course?error=failed"
            );
        }
    }
}