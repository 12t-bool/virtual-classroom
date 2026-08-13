package com.virtualclassroom.controller;

import com.virtualclassroom.dao.ProfileDAO;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/change-password")
public class ChangePasswordServlet extends HttpServlet {

    private ProfileDAO profileDAO;

    @Override
    public void init() {

        profileDAO = new ProfileDAO();
    }


    // =====================================================
    // GET - OPEN CHANGE PASSWORD PAGE
    // =====================================================

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        // Check login
        if (session == null ||
            session.getAttribute("userId") == null) {

            response.sendRedirect(
                    request.getContextPath() +
                    "/login.jsp"
            );

            return;
        }

        // Open change password page
        request.getRequestDispatcher(
                "/change-password.jsp"
        ).forward(
                request,
                response
        );
    }


    // =====================================================
    // POST - CHANGE PASSWORD
    // =====================================================

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        // Check login
        if (session == null ||
            session.getAttribute("userId") == null) {

            response.sendRedirect(
                    request.getContextPath() +
                    "/login.jsp"
            );

            return;
        }

        // Get user ID
        int userId =
                (Integer) session.getAttribute("userId");


        // =================================================
        // GET FORM VALUES
        // =================================================

        String currentPassword =
                request.getParameter("currentPassword");

        String newPassword =
                request.getParameter("newPassword");

        String confirmPassword =
                request.getParameter("confirmPassword");


        // =================================================
        // CHECK EMPTY FIELDS
        // =================================================

        if (currentPassword == null ||
            newPassword == null ||
            confirmPassword == null ||
            currentPassword.trim().isEmpty() ||
            newPassword.trim().isEmpty() ||
            confirmPassword.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath() +
                    "/change-password.jsp?error=empty"
            );

            return;
        }


        // =================================================
        // CHECK PASSWORD LENGTH
        // =================================================

        if (newPassword.length() < 6) {

            response.sendRedirect(
                    request.getContextPath() +
                    "/change-password.jsp?error=length"
            );

            return;
        }


        // =================================================
        // CHECK PASSWORD MATCH
        // =================================================

        if (!newPassword.equals(confirmPassword)) {

            response.sendRedirect(
                    request.getContextPath() +
                    "/change-password.jsp?error=match"
            );

            return;
        }


        // =================================================
        // GET CURRENT PASSWORD FROM DATABASE
        // =================================================

        String storedPassword =
                profileDAO.getPassword(userId);


        if (storedPassword == null) {

            response.sendRedirect(
                    request.getContextPath() +
                    "/change-password.jsp?error=failed"
            );

            return;
        }


        // =================================================
        // CHECK CURRENT PASSWORD
        // =================================================

        if (!storedPassword.equals(currentPassword)) {

            response.sendRedirect(
                    request.getContextPath() +
                    "/change-password.jsp?error=incorrect"
            );

            return;
        }


        // =================================================
        // UPDATE PASSWORD
        // =================================================

        boolean updated =
                profileDAO.updatePassword(
                        userId,
                        newPassword
                );


        if (updated) {

            response.sendRedirect(
                    request.getContextPath() +
                    "/profile?success=password"
            );

        } else {

            response.sendRedirect(
                    request.getContextPath() +
                    "/change-password.jsp?error=failed"
            );
        }
    }
}