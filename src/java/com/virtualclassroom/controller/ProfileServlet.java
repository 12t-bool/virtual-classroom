package com.virtualclassroom.controller;

import com.virtualclassroom.dao.UserDAO;
import com.virtualclassroom.model.User;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {

        userDAO = new UserDAO();
    }

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
            session.getAttribute("userId") == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/login.jsp"
            );

            return;
        }


        // =====================================================
        // GET USER ID
        // =====================================================

        Object userIdObject =
                session.getAttribute("userId");

        int userId;


        try {

            if (userIdObject instanceof Integer) {

                userId =
                        (Integer) userIdObject;

            } else {

                userId =
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
        // GET USER FROM DATABASE
        // =====================================================

        User user =
                userDAO.getUserById(userId);


        // =====================================================
        // USER NOT FOUND
        // =====================================================

        if (user == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/login.jsp"
            );

            return;
        }


        // =====================================================
        // SEND USER TO JSP
        // =====================================================

        request.setAttribute(
                "user",
                user
        );


        // =====================================================
        // OPEN PROFILE JSP
        // =====================================================

        request.getRequestDispatcher(
                "/profile.jsp"
        ).forward(
                request,
                response
        );
    }
}