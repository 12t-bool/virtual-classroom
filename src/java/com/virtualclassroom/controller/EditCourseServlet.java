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

@WebServlet("/teacher/edit-course")
public class EditCourseServlet extends HttpServlet {

    private CourseDAO courseDAO;

    @Override
    public void init() {
        courseDAO = new CourseDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        // Make sure teacher is logged in
        if (session == null ||
            session.getAttribute("userId") == null ||
            !"teacher".equalsIgnoreCase(
                    (String) session.getAttribute("role"))) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );

            return;
        }

        String idParameter =
                request.getParameter("id");

        if (idParameter == null ||
            idParameter.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath() +
                    "/teacher/my-courses.jsp"
            );

            return;
        }

        try {

            int courseId =
                    Integer.parseInt(idParameter);

            int teacherId =
                    (Integer) session.getAttribute("userId");

            Course course =
                    courseDAO.getCourseById(courseId);

            // Course doesn't exist
            if (course == null) {

                response.sendRedirect(
                        request.getContextPath() +
                        "/teacher/my-courses.jsp?error=notfound"
                );

                return;
            }

            // Make sure this course belongs to this teacher
            if (course.getTeacherId() != teacherId) {

                response.sendRedirect(
                        request.getContextPath() +
                        "/teacher/my-courses.jsp?error=unauthorized"
                );

                return;
            }

            request.setAttribute(
                    "course",
                    course
            );

            request.getRequestDispatcher(
                    "/teacher/edit-course.jsp"
            ).forward(
                    request,
                    response
            );

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath() +
                    "/teacher/my-courses.jsp?error=invalid"
            );
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        // Make sure teacher is logged in
        if (session == null ||
            session.getAttribute("userId") == null ||
            !"teacher".equalsIgnoreCase(
                    (String) session.getAttribute("role"))) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );

            return;
        }

        String idParameter =
                request.getParameter("id");

        String courseName =
                request.getParameter("courseName");

        String description =
                request.getParameter("description");

        if (idParameter == null ||
            courseName == null ||
            description == null ||
            courseName.trim().isEmpty() ||
            description.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath() +
                    "/teacher/my-courses.jsp?error=empty"
            );

            return;
        }

        try {

            int courseId =
                    Integer.parseInt(idParameter);

            int teacherId =
                    (Integer) session.getAttribute("userId");

            // Get existing course
            Course course =
                    courseDAO.getCourseById(courseId);

            if (course == null) {

                response.sendRedirect(
                        request.getContextPath() +
                        "/teacher/my-courses.jsp?error=notfound"
                );

                return;
            }

            // Security check
            if (course.getTeacherId() != teacherId) {

                response.sendRedirect(
                        request.getContextPath() +
                        "/teacher/my-courses.jsp?error=unauthorized"
                );

                return;
            }

            // Update course details
            course.setCourseName(
                    courseName.trim()
            );

            course.setDescription(
                    description.trim()
            );

            boolean updated =
                    courseDAO.updateCourse(course);

            if (updated) {

                response.sendRedirect(
                        request.getContextPath() +
                        "/teacher/my-courses.jsp?success=updated"
                );

            } else {

                response.sendRedirect(
                        request.getContextPath() +
                        "/teacher/my-courses.jsp?error=failed"
                );
            }

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath() +
                    "/teacher/my-courses.jsp?error=invalid"
            );
        }
    }
}