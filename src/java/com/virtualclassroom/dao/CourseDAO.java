package com.virtualclassroom.dao;

import com.virtualclassroom.model.Course;
import com.virtualclassroom.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CourseDAO {

    // ==========================================
    // ADD COURSE
    // ==========================================

    public boolean addCourse(Course course) {

        String sql =
                "INSERT INTO courses " +
                "(course_name, description, teacher_id) " +
                "VALUES (?, ?, ?)";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(1, course.getCourseName());
            statement.setString(2, course.getDescription());
            statement.setInt(3, course.getTeacherId());

            int rowsInserted = statement.executeUpdate();

            return rowsInserted > 0;

        } catch (SQLException e) {

            e.printStackTrace();
            return false;
        }
    }


    // ==========================================
    // GET COURSES BY TEACHER
    // ==========================================

    public List<Course> getCoursesByTeacher(int teacherId) {

        List<Course> courses = new ArrayList<>();

        String sql =
                "SELECT id, course_name, description, teacher_id " +
                "FROM courses " +
                "WHERE teacher_id = ? " +
                "ORDER BY created_at DESC";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, teacherId);

            try (ResultSet resultSet =
                    statement.executeQuery()) {

                while (resultSet.next()) {

                    Course course = new Course();

                    course.setId(
                            resultSet.getInt("id")
                    );

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
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return courses;
    }


    // ==========================================
    // GET COURSE BY ID
    // ==========================================

    public Course getCourseById(int courseId) {

        Course course = null;

        String sql =
                "SELECT id, course_name, description, teacher_id " +
                "FROM courses " +
                "WHERE id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, courseId);

            try (ResultSet resultSet =
                    statement.executeQuery()) {

                if (resultSet.next()) {

                    course = new Course();

                    course.setId(
                            resultSet.getInt("id")
                    );

                    course.setCourseName(
                            resultSet.getString("course_name")
                    );

                    course.setDescription(
                            resultSet.getString("description")
                    );

                    course.setTeacherId(
                            resultSet.getInt("teacher_id")
                    );
                }
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return course;
    }


    // ==========================================
    // UPDATE COURSE
    // ==========================================

    public boolean updateCourse(Course course) {

        String sql =
                "UPDATE courses " +
                "SET course_name = ?, description = ? " +
                "WHERE id = ? AND teacher_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(
                    1,
                    course.getCourseName()
            );

            statement.setString(
                    2,
                    course.getDescription()
            );

            statement.setInt(
                    3,
                    course.getId()
            );

            statement.setInt(
                    4,
                    course.getTeacherId()
            );

            int rowsUpdated =
                    statement.executeUpdate();

            return rowsUpdated > 0;

        } catch (SQLException e) {

            e.printStackTrace();
            return false;
        }
    }


    // ==========================================
    // DELETE COURSE
    // ==========================================

    public boolean deleteCourse(
            int courseId,
            int teacherId) {

        String sql =
                "DELETE FROM courses " +
                "WHERE id = ? AND teacher_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, courseId);
            statement.setInt(2, teacherId);

            int rowsDeleted =
                    statement.executeUpdate();

            return rowsDeleted > 0;

        } catch (SQLException e) {

            e.printStackTrace();
            return false;
        }
    }


    // ==========================================
    // GET ALL COURSES
    // ==========================================

    public List<Course> getAllCourses() {

        List<Course> courses = new ArrayList<>();

        String sql =
                "SELECT id, course_name, description, teacher_id " +
                "FROM courses " +
                "ORDER BY created_at DESC";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql);
             ResultSet resultSet =
                     statement.executeQuery()) {

            while (resultSet.next()) {

                Course course = new Course();

                course.setId(
                        resultSet.getInt("id")
                );

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


    // ==========================================
    // GET COURSES ENROLLED BY STUDENT
    // ==========================================

    public List<Course> getEnrolledCourses(int studentId) {

        List<Course> courses = new ArrayList<>();

        String sql =
                "SELECT c.id, c.course_name, " +
                "c.description, c.teacher_id " +
                "FROM courses c " +
                "INNER JOIN enrollments e " +
                "ON c.id = e.course_id " +
                "WHERE e.student_id = ? " +
                "ORDER BY e.enrolled_at DESC";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, studentId);

            try (ResultSet resultSet =
                    statement.executeQuery()) {

                while (resultSet.next()) {

                    Course course = new Course();

                    course.setId(
                            resultSet.getInt("id")
                    );

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
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return courses;
    }
}