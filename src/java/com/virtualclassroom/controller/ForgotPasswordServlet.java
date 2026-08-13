package com.virtualclassroom.controller;

import com.virtualclassroom.dao.ProfileDAO;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {

    private ProfileDAO profileDAO;

    @Override
    public void init() {

        profileDAO = new ProfileDAO();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.sendRedirect(
                request.getContextPath() +
                "/forgot-password.jsp"
        );
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String email =
                request.getParameter("email");

        // Check empty email
        if (email == null ||
            email.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath() +
                    "/forgot-password.jsp?error=empty"
            );

            return;
        }

        email = email.trim();

        // Check whether email exists
        boolean exists =
                profileDAO.emailExists(email);

        if (!exists) {

            response.sendRedirect(
                    request.getContextPath() +
                    "/forgot-password.jsp?error=notfound"
            );

            return;
        }

        /*
         * Email exists.
         *
         * For now we redirect to the
         * reset-password page.
         *
         * We will create that page next.
         */

        response.sendRedirect(
                request.getContextPath() +
                "/reset-password.jsp?email=" +
                java.net.URLEncoder.encode(
                        email,
                        "UTF-8"
                )
        );
    }
}