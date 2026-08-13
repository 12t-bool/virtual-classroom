package com.virtualclassroom.controller;

import com.virtualclassroom.dao.AssignmentDAO;
import com.virtualclassroom.dao.CourseDAO;
import com.virtualclassroom.model.Assignment;
import com.virtualclassroom.model.Course;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/teacher/assignments")
public class TeacherAssignmentServlet extends HttpServlet {

    private AssignmentDAO assignmentDAO;
    private CourseDAO courseDAO;


  

    @Override
    public void init() {

        assignmentDAO = new AssignmentDAO();
        courseDAO = new CourseDAO();
    }


   

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {


        

        HttpSession session =
                request.getSession(false);


        if (session == null ||
            session.getAttribute("userId") == null ||
            session.getAttribute("role") == null ||
            !"teacher".equalsIgnoreCase(
                    (String) session.getAttribute("role"))) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/login.jsp"
            );

            return;
        }


        // GET TEACHER ID
        

        int teacherId =
                (Integer) session.getAttribute("userId");


        // GET TEACHER COURSES
        

        List<Course> courses =
                courseDAO.getCoursesByTeacher(teacherId);


        
        // SEND COURSES TO JSP
      

        request.setAttribute(
                "courses",
                courses
        );


        // =================================================
        // FORWARD TO JSP
        // =================================================

        request.getRequestDispatcher(
                "/teacher/assignments.jsp"
        ).forward(
                request,
                response
        );
    }


    // =====================================================
    // POST
    // CREATE ASSIGNMENT
    // =====================================================

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {


        // =================================================
        // CHECK SESSION
        // =================================================

        HttpSession session =
                request.getSession(false);


        if (session == null ||
            session.getAttribute("userId") == null ||
            session.getAttribute("role") == null ||
            !"teacher".equalsIgnoreCase(
                    (String) session.getAttribute("role"))) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/login.jsp"
            );

            return;
        }


        // =================================================
        // GET TEACHER ID
        // =================================================

        int teacherId =
                (Integer) session.getAttribute("userId");


        // =================================================
        // GET FORM VALUES
        // =================================================

        String courseIdString =
                request.getParameter("courseId");

        String title =
                request.getParameter("title");

        String description =
                request.getParameter("description");

        String dueDateString =
                request.getParameter("dueDate");


        // =================================================
        // CHECK COURSE AND TITLE
        // =================================================

        if (courseIdString == null ||
            courseIdString.trim().isEmpty() ||
            title == null ||
            title.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/teacher/assignments?error=empty"
            );

            return;
        }


        // =================================================
        // CONVERT COURSE ID
        // =================================================

        int courseId;

        try {

            courseId =
                    Integer.parseInt(
                            courseIdString
                    );

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/teacher/assignments?error=invalid"
            );

            return;
        }


        // =================================================
        // CONVERT DUE DATE
        // =================================================

        Timestamp dueDate = null;


        if (dueDateString != null &&
            !dueDateString.trim().isEmpty()) {

            try {

                dueDate =
                        Timestamp.valueOf(
                                dueDateString.replace(
                                        "T",
                                        " "
                                )
                        );

            } catch (IllegalArgumentException e) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/teacher/assignments?error=invaliddate"
                );

                return;
            }
        }


        // =================================================
        // CREATE ASSIGNMENT OBJECT
        // =================================================

        Assignment assignment =
                new Assignment(
                        courseId,
                        title.trim(),
                        description,
                        dueDate
                );


        // =================================================
        // ADD ASSIGNMENT
        // =================================================

        boolean success =
                assignmentDAO.addAssignment(
                        assignment
                );


        // =================================================
        // REDIRECT
        // =================================================

        if (success) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/teacher/assignments?success=added"
            );

        } else {

            response.sendRedirect(
                    request.getContextPath()
                    + "/teacher/assignments?error=failed"
            );
        }
    }
}
