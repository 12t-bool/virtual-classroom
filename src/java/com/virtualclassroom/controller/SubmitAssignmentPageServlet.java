package com.virtualclassroom.controller;

import com.virtualclassroom.dao.AssignmentDAO;
import com.virtualclassroom.model.Assignment;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/student/open-assignment")
public class SubmitAssignmentPageServlet extends HttpServlet {


private AssignmentDAO assignmentDAO;

@Override
public void init() {

    assignmentDAO = new AssignmentDAO();
}

@Override
protected void doGet(HttpServletRequest request,
                      HttpServletResponse response)
        throws ServletException, IOException {

    HttpSession session =
            request.getSession(false);

    // Make sure a student is logged in
    if (session == null ||
        session.getAttribute("userId") == null ||
        !"student".equalsIgnoreCase(
                (String) session.getAttribute("role"))) {

        response.sendRedirect("../login.jsp");
        return;
    }

    String assignmentIdParameter =
            request.getParameter("assignmentId");

    // Check assignment ID
    if (assignmentIdParameter == null ||
        assignmentIdParameter.trim().isEmpty()) {

        response.sendRedirect("assignments?error=invalid");
        return;
    }

    try {

        int assignmentId =
                Integer.parseInt(
                        assignmentIdParameter
                );

        Assignment assignment =
                assignmentDAO.getAssignmentById(
                        assignmentId
                );

        if (assignment == null) {

            response.sendRedirect(
                    "assignments?error=invalid"
            );

            return;
        }

        request.setAttribute(
                "assignment",
                assignment
        );

        request.getRequestDispatcher(
                "submit-assignment.jsp"
        ).forward(request, response);

    } catch (NumberFormatException e) {

        response.sendRedirect(
                "assignments?error=invalid"
        );

    } catch (Exception e) {

        e.printStackTrace();

        response.sendRedirect(
                "assignments?error=failed"
        );
    }
}


}
