package com.virtualclassroom.controller;

import com.virtualclassroom.dao.ProfileDAO;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/edit-profile")
public class EditProfileServlet extends HttpServlet {

    private ProfileDAO profileDAO;

    @Override
    public void init() {
        profileDAO = new ProfileDAO();
    }

    // ==========================================
    // OPEN EDIT PROFILE PAGE
    // ==========================================

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

        // Get logged-in user ID
        int userId =
                (Integer) session.getAttribute("userId");

        // Get profile information from database
        String[] profile =
                profileDAO.getProfile(userId);

        // Profile not found
        if (profile == null) {

            response.sendRedirect(
                    request.getContextPath() +
                    "/profile?error=notfound"
            );

            return;
        }

        // Send profile information to JSP
        request.setAttribute(
                "profile",
                profile
        );

        // Open edit profile page
        request.getRequestDispatcher(
                "/edit-profile.jsp"
        ).forward(
                request,
                response
        );
    }


    // ==========================================
    // SAVE PROFILE CHANGES
    // ==========================================

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

        // Get logged-in user ID
        int userId =
                (Integer) session.getAttribute("userId");

        // Get values from form
        String fullname =
                request.getParameter("fullname");

        String email =
                request.getParameter("email");

        // ==========================================
        // VALIDATION
        // ==========================================

        if (fullname == null ||
            email == null ||
            fullname.trim().isEmpty() ||
            email.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath() +
                    "/edit-profile.jsp?error=empty"
            );

            return;
        }

        fullname = fullname.trim();
        email = email.trim();


        // ==========================================
        // UPDATE DATABASE
        // ==========================================

        boolean updated =
                profileDAO.updateProfile(
                        userId,
                        fullname,
                        email
                );


        // ==========================================
        // IF UPDATE SUCCESSFUL
        // ==========================================

        if (updated) {

            // Update fullname in session
            session.setAttribute(
                    "fullname",
                    fullname
            );

            // Update email in session
            session.setAttribute(
                    "email",
                    email
            );

            // Go back to profile
            response.sendRedirect(
                    request.getContextPath() +
                    "/profile?success=updated"
            );

        } else {

            // Update failed
            response.sendRedirect(
                    request.getContextPath() +
                    "/edit-profile.jsp?error=failed"
            );
        }
    }
}