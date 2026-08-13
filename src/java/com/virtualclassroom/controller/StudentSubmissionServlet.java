package com.virtualclassroom.controller;

import com.virtualclassroom.dao.AssignmentDAO;
import com.virtualclassroom.dao.SubmissionDAO;
import com.virtualclassroom.model.Assignment;
import com.virtualclassroom.model.Submission;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/student/submit-assignment")
public class StudentSubmissionServlet extends HttpServlet {

    private AssignmentDAO assignmentDAO;
    private SubmissionDAO submissionDAO;


    // =========================================================
    // INIT
    // =========================================================

    @Override
    public void init() {

        assignmentDAO = new AssignmentDAO();
        submissionDAO = new SubmissionDAO();
    }


    // =========================================================
    // GET
    // OPEN SUBMIT ASSIGNMENT PAGE
    // URL:
    // /student/submit-assignment?id=1
    // =========================================================

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {


        // =====================================================
        // CHECK SESSION
        // =====================================================

        HttpSession session =
                request.getSession(false);


        if (session == null ||
            session.getAttribute("userId") == null ||
            !"student".equalsIgnoreCase(
                    (String) session.getAttribute("role"))) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );

            return;
        }


        // =====================================================
        // GET ASSIGNMENT ID
        // =====================================================

        String idParameter =
                request.getParameter("id");


        if (idParameter == null ||
            idParameter.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/student/assignments?error=invalid"
            );

            return;
        }


        try {

            int assignmentId =
                    Integer.parseInt(
                            idParameter
                    );


            // =================================================
            // GET ASSIGNMENT FROM DATABASE
            // =================================================

            Assignment assignment =
                    assignmentDAO.getAssignmentById(
                            assignmentId
                    );


            // =================================================
            // CHECK ASSIGNMENT
            // =================================================

            if (assignment == null) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/student/assignments?error=invalid"
                );

                return;
            }


            // =================================================
            // SEND ASSIGNMENT TO JSP
            // =================================================

            request.setAttribute(
                    "assignment",
                    assignment
            );


            // =================================================
            // OPEN JSP
            // =================================================

            request.getRequestDispatcher(
                    "/student/submit-assignment.jsp"
            ).forward(
                    request,
                    response
            );


        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/student/assignments?error=invalid"
            );
        }
    }


    // =========================================================
    // POST
    // SUBMIT ASSIGNMENT
    // =========================================================

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {


        // =====================================================
        // CHECK SESSION
        // =====================================================

        HttpSession session =
                request.getSession(false);


        if (session == null ||
            session.getAttribute("userId") == null ||
            !"student".equalsIgnoreCase(
                    (String) session.getAttribute("role"))) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );

            return;
        }


        // =====================================================
        // GET FORM DATA
        // =====================================================

        String assignmentIdParameter =
                request.getParameter("assignmentId");


        String submissionText =
                request.getParameter("submissionText");


        // =====================================================
        // CHECK REQUIRED FIELDS
        // =====================================================

        if (assignmentIdParameter == null ||
            assignmentIdParameter.trim().isEmpty() ||
            submissionText == null ||
            submissionText.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/student/assignments?error=empty"
            );

            return;
        }


        try {

            // =================================================
            // CONVERT ASSIGNMENT ID
            // =================================================

            int assignmentId =
                    Integer.parseInt(
                            assignmentIdParameter
                    );


            // =================================================
            // GET STUDENT ID
            // =================================================

            int studentId =
                    (Integer) session.getAttribute(
                            "userId"
                    );


            // =================================================
            // CHECK ASSIGNMENT EXISTS
            // =================================================

            Assignment assignment =
                    assignmentDAO.getAssignmentById(
                            assignmentId
                    );


            if (assignment == null) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/student/assignments?error=invalid"
                );

                return;
            }


            // =================================================
            // PREVENT DUPLICATE SUBMISSION
            // =================================================

            if (submissionDAO.hasSubmitted(
                    assignmentId,
                    studentId)) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/student/assignments?error=already"
                );

                return;
            }


            // =================================================
            // CREATE SUBMISSION OBJECT
            // =================================================

            Submission submission =
                    new Submission(
                            assignmentId,
                            studentId,
                            submissionText.trim()
                    );


            // =================================================
            // SAVE SUBMISSION
            // =================================================

            boolean submitted =
                    submissionDAO.submitAssignment(
                            submission
                    );


            // =================================================
            // RESULT
            // =================================================

            if (submitted) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/student/assignments?success=submitted"
                );

            } else {

                response.sendRedirect(
                        request.getContextPath()
                        + "/student/assignments?error=failed"
                );
            }


        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/student/assignments?error=invalid"
            );


        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                    + "/student/assignments?error=failed"
            );
        }
    }
}