package com.virtualclassroom.controller;

import com.virtualclassroom.dao.EnrollmentDAO;
import com.virtualclassroom.model.Enrollment;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/enroll")
public class EnrollmentServlet extends HttpServlet {


private EnrollmentDAO enrollmentDAO;

@Override
public void init() {
    enrollmentDAO = new EnrollmentDAO();
}

@Override
protected void doPost(HttpServletRequest request,
                      HttpServletResponse response)
        throws ServletException, IOException {

    HttpSession session = request.getSession(false);

    // Make sure a student is logged in
    if (session == null ||
        session.getAttribute("userId") == null ||
        !"student".equalsIgnoreCase(
                (String) session.getAttribute("role"))) {

        response.sendRedirect("login.jsp");
        return;
    }

    String courseIdParameter = request.getParameter("courseId");

    // Check course ID
    if (courseIdParameter == null ||
        courseIdParameter.trim().isEmpty()) {

        response.sendRedirect("courses?error=invalid");
        return;
    }

    try {

        int studentId = (Integer) session.getAttribute("userId");
        int courseId = Integer.parseInt(courseIdParameter);

        // Check if already enrolled
        if (enrollmentDAO.isEnrolled(studentId, courseId)) {

            response.sendRedirect(
                    "courses?error=already"
            );

            return;
        }

        // Create enrollment
        Enrollment enrollment =
                new Enrollment(studentId, courseId);

        // Save enrollment
        boolean enrolled =
                enrollmentDAO.enrollStudent(enrollment);

        if (enrolled) {

            response.sendRedirect(
                    "courses?success=enrolled"
            );

        } else {

            response.sendRedirect(
                    "courses?error=failed"
            );
        }

    } catch (NumberFormatException e) {

        response.sendRedirect(
                "courses?error=invalid"
        );

    } catch (Exception e) {

        e.printStackTrace();

        response.sendRedirect(
                "courses?error=failed"
        );
    }
}


}
