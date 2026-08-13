package com.virtualclassroom.dao;

import com.virtualclassroom.model.Enrollment;
import com.virtualclassroom.model.Course;
import com.virtualclassroom.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class EnrollmentDAO {

    // Enroll a student in a course
    public boolean enrollStudent(Enrollment enrollment) {

        String sql = "INSERT INTO enrollments (student_id, course_id) "
                   + "VALUES (?, ?)";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, enrollment.getStudentId());
            statement.setInt(2, enrollment.getCourseId());

            int rowsInserted = statement.executeUpdate();

            return rowsInserted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Check whether a student is already enrolled
    public boolean isEnrolled(int studentId, int courseId) {

        String sql = "SELECT id FROM enrollments "
                   + "WHERE student_id = ? AND course_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, studentId);
            statement.setInt(2, courseId);

            ResultSet resultSet = statement.executeQuery();

            return resultSet.next();

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get all courses enrolled by a student
    public List<Course> getStudentCourses(int studentId) {

        List<Course> courses = new ArrayList<>();

        String sql = "SELECT c.id, c.course_name, c.description, c.teacher_id "
                   + "FROM courses c "
                   + "INNER JOIN enrollments e "
                   + "ON c.id = e.course_id "
                   + "WHERE e.student_id = ? "
                   + "ORDER BY e.enrolled_at DESC";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, studentId);

            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {

                Course course = new Course();

                course.setId(resultSet.getInt("id"));

                course.setCourseName(
                        resultSet.getString("course_name")
                );

                course.setDescription(
                        resultSet.getString("description")
                );

                course.setTeacherId(
                        resultSet.getInt("teacher_id")
                );

                courses.add(course);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return courses;
    }

    // Get number of courses enrolled by a student
    public int getEnrollmentCount(int studentId) {

        String sql =
                "SELECT COUNT(*) FROM enrollments "
                + "WHERE student_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, studentId);

            ResultSet resultSet =
                    statement.executeQuery();

            if (resultSet.next()) {
                return resultSet.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }
}