package com.virtualclassroom.controller;

import com.virtualclassroom.dao.UserDAO;
import com.virtualclassroom.model.User;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        if (fullname == null || email == null ||
            password == null || role == null ||
            fullname.trim().isEmpty() ||
            email.trim().isEmpty() ||
            password.trim().isEmpty() ||
            role.trim().isEmpty()) {

            response.sendRedirect("register.jsp?error=empty");
            return;
        }

        if (userDAO.emailExists(email)) {
            response.sendRedirect("register.jsp?error=exists");
            return;
        }

        User user = new User(
                fullname,
                email,
                password,
                role
        );

        boolean registered = userDAO.registerUser(user);

        if (registered) {
            response.sendRedirect("login.jsp?success=registered");
        } else {
            response.sendRedirect("register.jsp?error=failed");
        }
    }
}