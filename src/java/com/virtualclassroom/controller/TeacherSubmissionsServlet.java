package com.virtualclassroom.controller;

import com.virtualclassroom.dao.SubmissionDAO;
import com.virtualclassroom.model.Submission;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/teacher/submissions")
public class TeacherSubmissionsServlet extends HttpServlet {

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

        int teacherId =
                (Integer) session.getAttribute("userId");

        List<Submission> submissions =
                submissionDAO.getSubmissionsByTeacher(
                        teacherId
                );

        request.setAttribute(
                "submissions",
                submissions
        );

        request.getRequestDispatcher(
                "/teacher/submissions.jsp"
        ).forward(
                request,
                response
        );
    }
}