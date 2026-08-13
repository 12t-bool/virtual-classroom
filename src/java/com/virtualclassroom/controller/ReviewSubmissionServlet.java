package com.virtualclassroom.controller;

import com.virtualclassroom.dao.SubmissionDAO;
import com.virtualclassroom.model.Submission;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/teacher/review-submission")
public class ReviewSubmissionServlet extends HttpServlet {

    private SubmissionDAO submissionDAO;

    @Override
    public void init() {

        submissionDAO = new SubmissionDAO();
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
            !"teacher".equalsIgnoreCase(
                    (String) session.getAttribute("role"))) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/login.jsp"
            );

            return;
        }

        String submissionIdParameter =
                request.getParameter("id");

        if (submissionIdParameter == null ||
            submissionIdParameter.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/teacher/submissions"
            );

            return;
        }

        try {

            int submissionId =
                    Integer.parseInt(
                            submissionIdParameter
                    );

            Submission submission =
                    submissionDAO.getSubmissionById(
                            submissionId
                    );

            if (submission == null) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/teacher/submissions?error=notfound"
                );

                return;
            }

            request.setAttribute(
                    "submission",
                    submission
            );

            request.getRequestDispatcher(
                    "/teacher/review-submission.jsp"
            ).forward(
                    request,
                    response
            );

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