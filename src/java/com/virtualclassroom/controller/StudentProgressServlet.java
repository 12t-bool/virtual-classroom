package com.virtualclassroom.controller;

import com.virtualclassroom.dao.ProgressDAO;
import com.virtualclassroom.model.Progress;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/student/progress")
public class StudentProgressServlet extends HttpServlet {

    private ProgressDAO progressDAO;

    @Override
    public void init() {

        progressDAO = new ProgressDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        // Make sure student is logged in
        if (session == null ||
            session.getAttribute("userId") == null ||
            !"student".equalsIgnoreCase(
                    (String) session.getAttribute("role"))) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );

            return;
        }

        // Get logged-in student's ID
        int studentId =
                (Integer) session.getAttribute("userId");

        // Get progress
        List<Progress> progressList =
                progressDAO.getStudentProgress(studentId);

        // Send progress to JSP
        request.setAttribute(
                "progressList",
                progressList
        );

        // Open progress page
        request.getRequestDispatcher(
                "/student/progress.jsp"
        ).forward(
                request,
                response
        );
    }
}