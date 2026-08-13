package com.virtualclassroom.controller;

import com.virtualclassroom.dao.SubmissionDAO;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/teacher/grade-submission")
public class GradeSubmissionServlet extends HttpServlet {

    private SubmissionDAO submissionDAO;

    @Override
    public void init() {

        submissionDAO = new SubmissionDAO();
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
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
                    request.getContextPath()
                    + "/login.jsp"
            );

            return;
        }

        // ==========================================
        // GET FORM DATA
        // ==========================================

        String submissionIdParameter =
                request.getParameter("submissionId");

        String marksParameter =
                request.getParameter("marks");

        String feedback =
                request.getParameter("feedback");

        // ==========================================
        // VALIDATE
        // ==========================================

        if (submissionIdParameter == null ||
            marksParameter == null ||
            submissionIdParameter.trim().isEmpty() ||
            marksParameter.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/teacher/submissions?error=invalid"
            );

            return;
        }

        try {

            int submissionId =
                    Integer.parseInt(
                            submissionIdParameter
                    );

            int marks =
                    Integer.parseInt(
                            marksParameter
                    );

            // ==========================================
            // MARKS 0 - 100
            // ==========================================

            if (marks < 0 || marks > 100) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/teacher/submissions?error=marks"
                );

                return;
            }

            if (feedback == null) {
                feedback = "";
            }

            // ==========================================
            // UPDATE DATABASE
            // ==========================================

            boolean updated =
                    submissionDAO.updateGrade(
                            submissionId,
                            marks,
                            feedback
                    );

            if (updated) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/teacher/submissions?success=graded"
                );

            } else {

                response.sendRedirect(
                        request.getContextPath()
                        + "/teacher/submissions?error=failed"
                );
            }

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/teacher/submissions?error=invalid"
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                    + "/teacher/submissions?error=failed"
            );
        }
    }
}