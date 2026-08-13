package com.virtualclassroom.controller;

import com.virtualclassroom.dao.CourseDAO;
import com.virtualclassroom.dao.StudyMaterialDAO;
import com.virtualclassroom.model.Course;
import com.virtualclassroom.model.StudyMaterial;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/teacher/study-materials")
public class TeacherStudyMaterialServlet extends HttpServlet {


private CourseDAO courseDAO;
private StudyMaterialDAO studyMaterialDAO;

@Override
public void init() {

    courseDAO = new CourseDAO();
    studyMaterialDAO = new StudyMaterialDAO();
}

@Override
protected void doGet(HttpServletRequest request,
                     HttpServletResponse response)
        throws ServletException, IOException {

    HttpSession session = request.getSession(false);

    // Make sure a teacher is logged in
    if (session == null ||
        session.getAttribute("userId") == null ||
        !"teacher".equalsIgnoreCase(
                (String) session.getAttribute("role"))) {

        response.sendRedirect("../login.jsp");
        return;
    }

    // Get logged-in teacher's ID
    int teacherId = (Integer) session.getAttribute("userId");

    // Get courses created by this teacher
    List<Course> courses =
            courseDAO.getCoursesByTeacher(teacherId);

    // Send courses to JSP
    request.setAttribute("courses", courses);

    // Open teacher study materials page
    request.getRequestDispatcher(
            "/teacher/study-materials.jsp"
    ).forward(request, response);
}

@Override
protected void doPost(HttpServletRequest request,
                      HttpServletResponse response)
        throws ServletException, IOException {

    HttpSession session = request.getSession(false);

    // Make sure a teacher is logged in
    if (session == null ||
        session.getAttribute("userId") == null ||
        !"teacher".equalsIgnoreCase(
                (String) session.getAttribute("role"))) {

        response.sendRedirect("../login.jsp");
        return;
    }

    String courseIdParameter =
            request.getParameter("courseId");

    String title =
            request.getParameter("title");

    String description =
            request.getParameter("description");

    String fileUrl =
            request.getParameter("fileUrl");

    // Validate required fields
    if (courseIdParameter == null ||
        courseIdParameter.trim().isEmpty() ||
        title == null ||
        title.trim().isEmpty()) {

        response.sendRedirect(
                "study-materials?error=empty"
        );

        return;
    }

    try {

        int courseId =
                Integer.parseInt(courseIdParameter);

        int teacherId =
                (Integer) session.getAttribute("userId");

        // Verify that the course belongs to this teacher
        List<Course> courses =
                courseDAO.getCoursesByTeacher(teacherId);

        boolean ownsCourse = false;

        for (Course course : courses) {

            if (course.getId() == courseId) {

                ownsCourse = true;
                break;
            }
        }

        if (!ownsCourse) {

            response.sendRedirect(
                    "study-materials?error=unauthorized"
            );

            return;
        }

        // Create study material
        StudyMaterial material =
                new StudyMaterial(
                        courseId,
                        title.trim(),
                        description,
                        fileUrl
                );

        // Save material
        boolean added =
                studyMaterialDAO.addStudyMaterial(material);

        if (added) {

            response.sendRedirect(
                    "study-materials?success=added"
            );

        } else {

            response.sendRedirect(
                    "study-materials?error=failed"
            );
        }

    } catch (NumberFormatException e) {

        response.sendRedirect(
                "study-materials?error=invalid"
        );

    } catch (Exception e) {

        e.printStackTrace();

        response.sendRedirect(
                "study-materials?error=failed"
        );
    }
}


}
