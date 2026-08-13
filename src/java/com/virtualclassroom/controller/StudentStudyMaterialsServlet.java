package com.virtualclassroom.controller;

import com.virtualclassroom.dao.EnrollmentDAO;
import com.virtualclassroom.dao.StudyMaterialDAO;
import com.virtualclassroom.model.Course;
import com.virtualclassroom.model.StudyMaterial;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/student/study-materials")
public class StudentStudyMaterialsServlet extends HttpServlet {


private EnrollmentDAO enrollmentDAO;
private StudyMaterialDAO studyMaterialDAO;

@Override
public void init() {

    enrollmentDAO = new EnrollmentDAO();
    studyMaterialDAO = new StudyMaterialDAO();
}

@Override
protected void doGet(HttpServletRequest request,
                     HttpServletResponse response)
        throws ServletException, IOException {

    HttpSession session = request.getSession(false);

    // Make sure a student is logged in
    if (session == null ||
        session.getAttribute("userId") == null ||
        !"student".equalsIgnoreCase(
                (String) session.getAttribute("role"))) {

        response.sendRedirect("../login.jsp");
        return;
    }

    // Get logged-in student's ID
    int studentId = (Integer) session.getAttribute("userId");

    // Get courses enrolled by this student
    List<Course> enrolledCourses =
            enrollmentDAO.getStudentCourses(studentId);

    // Store all materials belonging to enrolled courses
    List<StudyMaterial> materials =
            new ArrayList<>();

    for (Course course : enrolledCourses) {

        List<StudyMaterial> courseMaterials =
                studyMaterialDAO.getMaterialsByCourse(
                        course.getId()
                );

        materials.addAll(courseMaterials);
    }

    // Send materials to JSP
    request.setAttribute("materials", materials);

    // Open study materials page
    request.getRequestDispatcher(
            "/student/study-materials.jsp"
    ).forward(request, response);
}


}
