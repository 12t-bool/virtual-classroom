package com.virtualclassroom.controller;

import com.virtualclassroom.dao.ProfileDAO;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/reset-password")
public class ResetPasswordServlet extends HttpServlet {

    private ProfileDAO profileDAO;

    @Override
    public void init() {

        profileDAO = new ProfileDAO();
    }

    // ==========================================
    // OPEN RESET PASSWORD PAGE
    // ==========================================

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String email =
                request.getParameter("email");

        if (email == null ||
            email.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath() +
                    "/forgot-password.jsp?error=empty"
            );

            return;
        }

        response.sendRedirect(
                request.getContextPath() +
                "/reset-password.jsp?email=" +
                java.net.URLEncoder.encode(
                        email,
                        "UTF-8"
                )
        );
    }

    // ==========================================
    // RESET PASSWORD
    // ==========================================

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String email =
                request.getParameter("email");

        String password =
                request.getParameter("password");

        String confirmPassword =
                request.getParameter("confirmPassword");


        // ==========================================
        // CHECK EMPTY FIELDS
        // ==========================================

        if (email == null ||
            password == null ||
            confirmPassword == null ||
            email.trim().isEmpty() ||
            password.trim().isEmpty() ||
            confirmPassword.trim().isEmpty()) {

            redirectWithError(
                    request,
                    response,
                    email,
                    "empty"
            );

            return;
        }


        email = email.trim();


        // ==========================================
        // CHECK PASSWORD LENGTH
        // ==========================================

        if (password.length() < 6) {

            redirectWithError(
                    request,
                    response,
                    email,
                    "short"
            );

            return;
        }


        // ==========================================
        // CHECK PASSWORD MATCH
        // ==========================================

        if (!password.equals(confirmPassword)) {

            redirectWithError(
                    request,
                    response,
                    email,
                    "mismatch"
            );

            return;
        }


        // ==========================================
        // GET USER ID
        // ==========================================

        int userId =
                profileDAO.getUserIdByEmail(email);


        // ==========================================
        // USER NOT FOUND
        // ==========================================

        if (userId == -1) {

            response.sendRedirect(
                    request.getContextPath() +
                    "/forgot-password.jsp?error=notfound"
            );

            return;
        }


        // ==========================================
        // UPDATE PASSWORD
        // ==========================================

        boolean updated =
                profileDAO.updatePassword(
                        userId,
                        password
                );


        // ==========================================
        // SUCCESS
        // ==========================================

        if (updated) {

            response.sendRedirect(
                    request.getContextPath() +
                    "/login.jsp?success=reset"
            );

        } else {

            redirectWithError(
                    request,
                    response,
                    email,
                    "failed"
            );
        }
    }


    // ==========================================
    // REDIRECT WITH ERROR
    // ==========================================

    private void redirectWithError(
            HttpServletRequest request,
            HttpServletResponse response,
            String email,
            String error)
            throws IOException {

        String encodedEmail = "";

        if (email != null) {

            encodedEmail =
                    java.net.URLEncoder.encode(
                            email,
                            "UTF-8"
                    );
        }

        response.sendRedirect(
                request.getContextPath() +
                "/reset-password.jsp?email=" +
                encodedEmail +
                "&error=" +
                error
        );
    }
}