
package com.virtualclassroom.controller;

import com.virtualclassroom.dao.EnrollmentDAO;
import com.virtualclassroom.dao.AssignmentDAO;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/student/dashboard")
public class StudentDashboardServlet extends HttpServlet {

    private EnrollmentDAO enrollmentDAO;
    private AssignmentDAO assignmentDAO;


    // =========================================================
    // INITIALIZE DAOs
    // =========================================================

    @Override
    public void init() {

        enrollmentDAO = new EnrollmentDAO();

        assignmentDAO = new AssignmentDAO();
    }


    // =========================================================
    // LOAD STUDENT DASHBOARD
    // =========================================================

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {


        // =====================================================
        // PREVENT BROWSER CACHING
        // =====================================================

        response.setHeader(
                "Cache-Control",
                "no-cache, no-store, must-revalidate"
        );

        response.setHeader(
                "Pragma",
                "no-cache"
        );

        response.setDateHeader(
                "Expires",
                0
        );


        // =====================================================
        // GET EXISTING SESSION
        // =====================================================

        HttpSession session =
                request.getSession(false);


        // =====================================================
        // CHECK LOGIN
        // =====================================================

        if (session == null ||
            session.getAttribute("userId") == null ||
            session.getAttribute("role") == null ||
            !"student".equalsIgnoreCase(
                    String.valueOf(
                            session.getAttribute("role")
                    )
            )) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/login.jsp"
            );

            return;
        }


        // =====================================================
        // GET STUDENT ID
        // =====================================================

        Object userIdObject =
                session.getAttribute("userId");

        int studentId;


        try {

            if (userIdObject instanceof Integer) {

                studentId =
                        (Integer) userIdObject;

            } else {

                studentId =
                        Integer.parseInt(
                                String.valueOf(
                                        userIdObject
                                )
                        );
            }

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/login.jsp"
            );

            return;
        }


        // =====================================================
        // DEBUG INFORMATION
        // =====================================================

        System.out.println(
                "================================="
        );

        System.out.println(
                "STUDENT DASHBOARD"
        );

        System.out.println(
                "Student ID = "
                + studentId
        );

        System.out.println(
                "Student Name = "
                + session.getAttribute("fullname")
        );

        System.out.println(
                "Student Role = "
                + session.getAttribute("role")
        );

        System.out.println(
                "================================="
        );


        // =====================================================
        // GET ENROLLED COURSE COUNT
        // =====================================================

        int enrollmentCount =
                enrollmentDAO.getEnrollmentCount(
                        studentId
                );


        System.out.println(
                "Enrollment Count = "
                + enrollmentCount
        );


        // =====================================================
        // GET TOTAL ASSIGNMENT COUNT
        // =====================================================

        int assignmentCount =
                assignmentDAO.getAssignmentCount(
                        studentId
                );


        System.out.println(
                "Assignment Count = "
                + assignmentCount
        );


        // =====================================================
        // GET COMPLETED ASSIGNMENT COUNT
        // =====================================================

        int completedAssignmentCount =
                assignmentDAO.getCompletedAssignmentCount(
                        studentId
                );


        System.out.println(
                "Completed Assignment Count = "
                + completedAssignmentCount
        );


        // =====================================================
        // GET PENDING ASSIGNMENT COUNT
        // =====================================================

        int pendingAssignmentCount =
                assignmentDAO.getPendingAssignmentCount(
                        studentId
                );


        System.out.println(
                "Pending Assignment Count = "
                + pendingAssignmentCount
        );


        // =====================================================
        // CALCULATE PROGRESS
        // =====================================================

        int progress = 0;


        if (assignmentCount > 0) {

            progress =
                    (completedAssignmentCount * 100)
                    / assignmentCount;
        }


        System.out.println(
                "Progress = "
                + progress
                + "%"
        );


        System.out.println(
                "================================="
        );


        // =====================================================
        // SEND DATA TO JSP
        // =====================================================

        request.setAttribute(
                "enrollmentCount",
                enrollmentCount
        );


        request.setAttribute(
                "assignmentCount",
                assignmentCount
        );


        request.setAttribute(
                "completedAssignmentCount",
                completedAssignmentCount
        );


        request.setAttribute(
                "pendingAssignmentCount",
                pendingAssignmentCount
        );


        request.setAttribute(
                "progress",
                progress
        );


        // =====================================================
        // OPEN DASHBOARD JSP
        // =====================================================

        request.getRequestDispatcher(
                "/student/dashboard.jsp"
        ).forward(
                request,
                response
        );
    }
}

