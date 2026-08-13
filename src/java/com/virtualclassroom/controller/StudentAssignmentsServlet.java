package com.virtualclassroom.controller;

import com.virtualclassroom.dao.AssignmentDAO;
import com.virtualclassroom.dao.CourseDAO;
import com.virtualclassroom.dao.SubmissionDAO;
import com.virtualclassroom.model.Assignment;
import com.virtualclassroom.model.Course;
import com.virtualclassroom.model.Submission;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/student/assignments")
public class StudentAssignmentsServlet extends HttpServlet {


private AssignmentDAO assignmentDAO;
private CourseDAO courseDAO;
private SubmissionDAO submissionDAO;

@Override
public void init() {

    assignmentDAO = new AssignmentDAO();
    courseDAO = new CourseDAO();
    submissionDAO = new SubmissionDAO();
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

        response.sendRedirect("../login.jsp");
        return;
    }

    int studentId =
            (Integer) session.getAttribute("userId");

    // Get courses the student is enrolled in
    List<Course> courses =
            courseDAO.getEnrolledCourses(studentId);

    List<Integer> courseIds =
            new ArrayList<>();

    if (courses != null) {

        for (Course course : courses) {

            courseIds.add(
                    course.getId()
            );
        }
    }

    // Get assignments from enrolled courses
    List<Assignment> assignments =
            assignmentDAO.getAssignmentsByCourses(
                    courseIds
            );

    // Get student's submissions
    List<Submission> submissions =
            submissionDAO.getSubmissionsByStudent(
                    studentId
            );

    // Send data to JSP
    request.setAttribute(
            "assignments",
            assignments
    );

    request.setAttribute(
            "submissions",
            submissions
    );

    request.getRequestDispatcher(
            "/student/assignments.jsp"
    ).forward(request, response);
}


}
