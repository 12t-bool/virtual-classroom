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

@WebServlet("/teacher/delete-course")
public class DeleteCourseServlet extends HttpServlet {

    private CourseDAO courseDAO;

    @Override
    public void init() {
        courseDAO = new CourseDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        // ==========================================
        // CHECK TEACHER LOGIN
        // ==========================================

        if (session == null ||
            session.getAttribute("userId") == null ||
            !"teacher".equalsIgnoreCase(
                    (String) session.getAttribute("role"))) {

            response.sendRedirect(
                    request.getContextPath() +
                    "/login.jsp"
            );

            return;
        }

        // ==========================================
        // GET COURSE ID
        // ==========================================

        String idParameter =
                request.getParameter("id");

        if (idParameter == null ||
            idParameter.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath() +
                    "/my-courses?error=invalid"
            );

            return;
        }

        try {

            int courseId =
                    Integer.parseInt(idParameter);

            int teacherId =
                    (Integer) session.getAttribute("userId");

            // ==========================================
            // FIND COURSE
            // ==========================================

            Course course =
                    courseDAO.getCourseById(courseId);

            if (course == null) {

                response.sendRedirect(
                        request.getContextPath() +
                        "/my-courses?error=notfound"
                );

                return;
            }

            // ==========================================
            // SECURITY CHECK
            // ==========================================

            if (course.getTeacherId() != teacherId) {

                response.sendRedirect(
                        request.getContextPath() +
                        "/my-courses?error=unauthorized"
                );

                return;
            }

            // ==========================================
            // DELETE COURSE
            // ==========================================

            boolean deleted =
                    courseDAO.deleteCourse(
                            courseId,
                            teacherId
                    );

            if (deleted) {

                response.sendRedirect(
                        request.getContextPath() +
                        "/my-courses?success=deleted"
                );

            } else {

                response.sendRedirect(
                        request.getContextPath() +
                        "/my-courses?error=failed"
                );
            }

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath() +
                    "/my-courses?error=invalid"
            );
        }
    }
}