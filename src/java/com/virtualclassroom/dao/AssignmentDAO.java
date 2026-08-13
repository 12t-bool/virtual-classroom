package com.virtualclassroom.dao;

import com.virtualclassroom.model.Assignment;
import com.virtualclassroom.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AssignmentDAO {

    // =========================================================
    // CREATE A NEW ASSIGNMENT
    // =========================================================

    public boolean addAssignment(Assignment assignment) {

        String sql =
                "INSERT INTO assignments " +
                "(course_id, title, description, due_date) " +
                "VALUES (?, ?, ?, ?)";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(
                    1,
                    assignment.getCourseId()
            );

            statement.setString(
                    2,
                    assignment.getTitle()
            );

            statement.setString(
                    3,
                    assignment.getDescription()
            );

            if (assignment.getDueDate() != null) {

                statement.setTimestamp(
                        4,
                        assignment.getDueDate()
                );

            } else {

                statement.setNull(
                        4,
                        java.sql.Types.TIMESTAMP
                );
            }

            int rowsInserted =
                    statement.executeUpdate();

            return rowsInserted > 0;

        } catch (SQLException e) {

            e.printStackTrace();

            return false;
        }
    }


    // =========================================================
    // GET ASSIGNMENTS BY COURSE
    // =========================================================

    public List<Assignment> getAssignmentsByCourse(
            int courseId) {

        List<Assignment> assignments =
                new ArrayList<>();

        String sql =
                "SELECT id, course_id, title, " +
                "description, due_date " +
                "FROM assignments " +
                "WHERE course_id = ? " +
                "ORDER BY due_date ASC";

        try (Connection connection =
                     DBConnection.getConnection();

             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(
                    1,
                    courseId
            );

            try (ResultSet resultSet =
                         statement.executeQuery()) {

                while (resultSet.next()) {

                    Assignment assignment =
                            new Assignment();

                    assignment.setId(
                            resultSet.getInt("id")
                    );

                    assignment.setCourseId(
                            resultSet.getInt("course_id")
                    );

                    assignment.setTitle(
                            resultSet.getString("title")
                    );

                    assignment.setDescription(
                            resultSet.getString("description")
                    );

                    assignment.setDueDate(
                            resultSet.getTimestamp("due_date")
                    );

                    assignments.add(assignment);
                }
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return assignments;
    }


    // =========================================================
    // GET ASSIGNMENTS BY MULTIPLE COURSES
    // =========================================================

    public List<Assignment> getAssignmentsByCourses(
            List<Integer> courseIds) {

        List<Assignment> assignments =
                new ArrayList<>();

        if (courseIds == null ||
            courseIds.isEmpty()) {

            return assignments;
        }

        StringBuilder placeholders =
                new StringBuilder();

        for (int i = 0;
             i < courseIds.size();
             i++) {

            placeholders.append("?");

            if (i < courseIds.size() - 1) {

                placeholders.append(",");
            }
        }

        String sql =
                "SELECT id, course_id, title, " +
                "description, due_date " +
                "FROM assignments " +
                "WHERE course_id IN (" +
                placeholders +
                ") " +
                "ORDER BY due_date ASC";

        try (Connection connection =
                     DBConnection.getConnection();

             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            for (int i = 0;
                 i < courseIds.size();
                 i++) {

                statement.setInt(
                        i + 1,
                        courseIds.get(i)
                );
            }

            try (ResultSet resultSet =
                         statement.executeQuery()) {

                while (resultSet.next()) {

                    Assignment assignment =
                            new Assignment();

                    assignment.setId(
                            resultSet.getInt("id")
                    );

                    assignment.setCourseId(
                            resultSet.getInt("course_id")
                    );

                    assignment.setTitle(
                            resultSet.getString("title")
                    );

                    assignment.setDescription(
                            resultSet.getString("description")
                    );

                    assignment.setDueDate(
                            resultSet.getTimestamp("due_date")
                    );

                    assignments.add(assignment);
                }
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return assignments;
    }


    // =========================================================
    // GET ONE ASSIGNMENT BY ID
    // =========================================================

    public Assignment getAssignmentById(
            int assignmentId) {

        String sql =
                "SELECT id, course_id, title, " +
                "description, due_date " +
                "FROM assignments " +
                "WHERE id = ?";

        try (Connection connection =
                     DBConnection.getConnection();

             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(
                    1,
                    assignmentId
            );

            try (ResultSet resultSet =
                         statement.executeQuery()) {

                if (resultSet.next()) {

                    Assignment assignment =
                            new Assignment();

                    assignment.setId(
                            resultSet.getInt("id")
                    );

                    assignment.setCourseId(
                            resultSet.getInt("course_id")
                    );

                    assignment.setTitle(
                            resultSet.getString("title")
                    );

                    assignment.setDescription(
                            resultSet.getString("description")
                    );

                    assignment.setDueDate(
                            resultSet.getTimestamp("due_date")
                    );

                    return assignment;
                }
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return null;
    }


    // =========================================================
    // GET TOTAL ASSIGNMENTS FOR A STUDENT
    // =========================================================

    public int getAssignmentCount(
            int studentId) {

        String sql =
                "SELECT COUNT(*) " +
                "FROM assignments a " +
                "INNER JOIN enrollments e " +
                "ON a.course_id = e.course_id " +
                "WHERE e.student_id = ?";

        try (Connection connection =
                     DBConnection.getConnection();

             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(
                    1,
                    studentId
            );

            try (ResultSet resultSet =
                         statement.executeQuery()) {

                if (resultSet.next()) {

                    return resultSet.getInt(1);
                }
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return 0;
    }


    // =========================================================
    // GET COMPLETED ASSIGNMENTS FOR A STUDENT
    // =========================================================

    public int getCompletedAssignmentCount(
            int studentId) {

        String sql =
                "SELECT COUNT(DISTINCT s.assignment_id) " +
                "FROM submissions s " +
                "INNER JOIN assignments a " +
                "ON s.assignment_id = a.id " +
                "INNER JOIN enrollments e " +
                "ON a.course_id = e.course_id " +
                "AND s.student_id = e.student_id " +
                "WHERE s.student_id = ?";

        try (Connection connection =
                     DBConnection.getConnection();

             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(
                    1,
                    studentId
            );

            try (ResultSet resultSet =
                         statement.executeQuery()) {

                if (resultSet.next()) {

                    return resultSet.getInt(1);
                }
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return 0;
    }


    // =========================================================
    // GET PENDING ASSIGNMENTS
    // =========================================================

    public int getPendingAssignmentCount(
            int studentId) {

        String sql =
                "SELECT COUNT(*) " +
                "FROM assignments a " +
                "INNER JOIN enrollments e " +
                "ON a.course_id = e.course_id " +
                "WHERE e.student_id = ? " +
                "AND NOT EXISTS (" +
                "SELECT 1 " +
                "FROM submissions s " +
                "WHERE s.assignment_id = a.id " +
                "AND s.student_id = ?" +
                ")";

        try (Connection connection =
                     DBConnection.getConnection();

             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(
                    1,
                    studentId
            );

            statement.setInt(
                    2,
                    studentId
            );

            try (ResultSet resultSet =
                         statement.executeQuery()) {

                if (resultSet.next()) {

                    return resultSet.getInt(1);
                }
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return 0;
    }
}