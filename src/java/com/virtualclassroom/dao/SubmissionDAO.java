package com.virtualclassroom.dao;

import com.virtualclassroom.model.Submission;
import com.virtualclassroom.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SubmissionDAO {

// Submit an assignment
public boolean addSubmission(Submission submission) {

    String sql =
            "INSERT INTO submissions " +
            "(assignment_id, student_id, submission_text) " +
            "VALUES (?, ?, ?)";

    try (Connection connection =
                 DBConnection.getConnection();
         PreparedStatement statement =
                 connection.prepareStatement(sql)) {

        statement.setInt(
                1,
                submission.getAssignmentId()
        );

        statement.setInt(
                2,
                submission.getStudentId()
        );

        statement.setString(
                3,
                submission.getSubmissionText()
        );

        int rowsInserted =
                statement.executeUpdate();

        return rowsInserted > 0;

    } catch (SQLException e) {

        e.printStackTrace();
        return false;
    }
}


// Compatibility method used by StudentSubmissionServlet
public boolean submitAssignment(Submission submission) {

    return addSubmission(submission);
}


// Check whether a student already submitted
public boolean hasSubmitted(
        int assignmentId,
        int studentId) {

    String sql =
            "SELECT id FROM submissions " +
            "WHERE assignment_id = ? " +
            "AND student_id = ?";

    try (Connection connection =
                 DBConnection.getConnection();
         PreparedStatement statement =
                 connection.prepareStatement(sql)) {

        statement.setInt(1, assignmentId);
        statement.setInt(2, studentId);

        try (ResultSet resultSet =
                     statement.executeQuery()) {

            return resultSet.next();
        }

    } catch (SQLException e) {

        e.printStackTrace();
        return false;
    }
}


// Get all submissions made by a student
public List<Submission> getSubmissionsByStudent(
        int studentId) {

    List<Submission> submissions =
            new ArrayList<>();

    String sql =
            "SELECT id, assignment_id, student_id, " +
            "submission_text, submitted_at, " +
            "marks, feedback " +
            "FROM submissions " +
            "WHERE student_id = ? " +
            "ORDER BY submitted_at DESC";

    try (Connection connection =
                 DBConnection.getConnection();
         PreparedStatement statement =
                 connection.prepareStatement(sql)) {

        statement.setInt(1, studentId);

        try (ResultSet resultSet =
                     statement.executeQuery()) {

            while (resultSet.next()) {

                Submission submission =
                        new Submission();

                submission.setId(
                        resultSet.getInt("id")
                );

                submission.setAssignmentId(
                        resultSet.getInt("assignment_id")
                );

                submission.setStudentId(
                        resultSet.getInt("student_id")
                );

                submission.setSubmissionText(
                        resultSet.getString(
                                "submission_text"
                        )
                );

                submission.setSubmittedAt(
                        resultSet.getTimestamp(
                                "submitted_at"
                        )
                );

                int marks =
                        resultSet.getInt("marks");

                if (resultSet.wasNull()) {
                    submission.setMarks(null);
                } else {
                    submission.setMarks(marks);
                }

                submission.setFeedback(
                        resultSet.getString("feedback")
                );

                submissions.add(submission);
            }
        }

    } catch (SQLException e) {

        e.printStackTrace();
    }

    return submissions;
}


// Get all submissions for a teacher
public List<Submission> getSubmissionsByTeacher(
        int teacherId) {

    List<Submission> submissions =
            new ArrayList<>();

    String sql =
            "SELECT s.id, s.assignment_id, s.student_id, " +
            "s.submission_text, s.submitted_at, " +
            "s.marks, s.feedback, " +
            "u.fullname AS student_name, " +
            "a.title AS assignment_title, " +
            "c.course_name AS course_name " +
            "FROM submissions s " +
            "INNER JOIN users u " +
            "ON s.student_id = u.id " +
            "INNER JOIN assignments a " +
            "ON s.assignment_id = a.id " +
            "INNER JOIN courses c " +
            "ON a.course_id = c.id " +
            "WHERE c.teacher_id = ? " +
            "ORDER BY s.submitted_at DESC";

    try (Connection connection =
                 DBConnection.getConnection();
         PreparedStatement statement =
                 connection.prepareStatement(sql)) {

        statement.setInt(1, teacherId);

        try (ResultSet resultSet =
                     statement.executeQuery()) {

            while (resultSet.next()) {

                Submission submission =
                        new Submission();

                submission.setId(
                        resultSet.getInt("id")
                );

                submission.setAssignmentId(
                        resultSet.getInt("assignment_id")
                );

                submission.setStudentId(
                        resultSet.getInt("student_id")
                );

                submission.setSubmissionText(
                        resultSet.getString(
                                "submission_text"
                        )
                );

                submission.setSubmittedAt(
                        resultSet.getTimestamp(
                                "submitted_at"
                        )
                );

                int marks =
                        resultSet.getInt("marks");

                if (resultSet.wasNull()) {
                    submission.setMarks(null);
                } else {
                    submission.setMarks(marks);
                }

                submission.setFeedback(
                        resultSet.getString("feedback")
                );

                submission.setStudentName(
                        resultSet.getString(
                                "student_name"
                        )
                );

                submission.setAssignmentTitle(
                        resultSet.getString(
                                "assignment_title"
                        )
                );

                submission.setCourseName(
                        resultSet.getString(
                                "course_name"
                        )
                );

                submissions.add(submission);
            }
        }

    } catch (SQLException e) {

        e.printStackTrace();
    }

    return submissions;
}


// Get a single submission
public Submission getSubmissionById(
        int submissionId) {

    String sql =
            "SELECT id, assignment_id, student_id, " +
            "submission_text, submitted_at, " +
            "marks, feedback " +
            "FROM submissions " +
            "WHERE id = ?";

    try (Connection connection =
                 DBConnection.getConnection();
         PreparedStatement statement =
                 connection.prepareStatement(sql)) {

        statement.setInt(1, submissionId);

        try (ResultSet resultSet =
                     statement.executeQuery()) {

            if (resultSet.next()) {

                Submission submission =
                        new Submission();

                submission.setId(
                        resultSet.getInt("id")
                );

                submission.setAssignmentId(
                        resultSet.getInt("assignment_id")
                );

                submission.setStudentId(
                        resultSet.getInt("student_id")
                );

                submission.setSubmissionText(
                        resultSet.getString(
                                "submission_text"
                        )
                );

                submission.setSubmittedAt(
                        resultSet.getTimestamp(
                                "submitted_at"
                        )
                );

                int marks =
                        resultSet.getInt("marks");

                if (resultSet.wasNull()) {
                    submission.setMarks(null);
                } else {
                    submission.setMarks(marks);
                }

                submission.setFeedback(
                        resultSet.getString("feedback")
                );

                return submission;
            }
        }

    } catch (SQLException e) {

        e.printStackTrace();
    }

    return null;
}


// Save marks and feedback
public boolean updateGrade(
        int submissionId,
        int marks,
        String feedback) {

    String sql =
            "UPDATE submissions " +
            "SET marks = ?, feedback = ? " +
            "WHERE id = ?";

    try (Connection connection =
                 DBConnection.getConnection();
         PreparedStatement statement =
                 connection.prepareStatement(sql)) {

        statement.setInt(1, marks);
        statement.setString(2, feedback);
        statement.setInt(3, submissionId);

        int rowsUpdated =
                statement.executeUpdate();

        return rowsUpdated > 0;

    } catch (SQLException e) {

        e.printStackTrace();
        return false;
    }
}


}
