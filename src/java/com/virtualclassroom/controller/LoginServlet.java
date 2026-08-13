package com.virtualclassroom.controller;

import com.virtualclassroom.util.DBConnection;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // =====================================================
        // GET LOGIN DATA
        // =====================================================

        String email =
                request.getParameter("email");

        String password =
                request.getParameter("password");


        // =====================================================
        // CHECK EMPTY FIELDS
        // =====================================================

        if (email == null ||
            password == null ||
            email.trim().isEmpty() ||
            password.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath() +
                    "/login.jsp?error=empty"
            );

            return;
        }


        // =====================================================
        // LOGIN SQL
        // =====================================================

        String sql =
                "SELECT id, fullname, email, role " +
                "FROM users " +
                "WHERE email = ? AND password = ?";


        // =====================================================
        // DATABASE CONNECTION
        // =====================================================

        try (Connection connection =
                     DBConnection.getConnection();

             PreparedStatement statement =
                     connection.prepareStatement(sql)) {


            statement.setString(
                    1,
                    email
            );

            statement.setString(
                    2,
                    password
            );


            // =================================================
            // EXECUTE LOGIN
            // =================================================

            try (ResultSet resultSet =
                         statement.executeQuery()) {


                if (resultSet.next()) {


                    // =========================================
                    // CREATE SESSION
                    // =========================================

                    HttpSession session =
                            request.getSession();

                    session.setAttribute(
                            "userId",
                            resultSet.getInt("id")
                    );

                    session.setAttribute(
                            "fullname",
                            resultSet.getString("fullname")
                    );

                    session.setAttribute(
                            "email",
                            resultSet.getString("email")
                    );

                    session.setAttribute(
                            "role",
                            resultSet.getString("role")
                    );


                    // =========================================
                    // GET ROLE
                    // =========================================

                    String role =
                            resultSet.getString("role");


                    // =========================================
                    // REDIRECT BASED ON ROLE
                    // =========================================

                    if ("student".equalsIgnoreCase(role)) {


                        // IMPORTANT:
                        // Go through StudentDashboardServlet
                        // NOT directly to dashboard.jsp

                        response.sendRedirect(
                                request.getContextPath() +
                                "/student/dashboard"
                        );


                    } else if ("teacher".equalsIgnoreCase(role)) {


                        response.sendRedirect(
                                request.getContextPath() +
                                "/teacher/dashboard.jsp"
                        );


                    } else if ("admin".equalsIgnoreCase(role)) {


                        response.sendRedirect(
                                request.getContextPath() +
                                "/admin/dashboard.jsp"
                        );


                    } else {


                        response.sendRedirect(
                                request.getContextPath() +
                                "/login.jsp?error=invalid"
                        );
                    }


                } else {


                    // =========================================
                    // INVALID LOGIN
                    // =========================================

                    response.sendRedirect(
                            request.getContextPath() +
                            "/login.jsp?error=invalid"
                    );
                }
            }


        } catch (Exception e) {


            e.printStackTrace();


            response.sendRedirect(
                    request.getContextPath() +
                    "/login.jsp?error=failed"
            );
        }
    }
}