package com.virtualclassroom.dao;

import com.virtualclassroom.model.Progress;
import com.virtualclassroom.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ProgressDAO {

    public List<Progress> getStudentProgress(int studentId) {

        List<Progress> progressList = new ArrayList<>();

        String sql =
            "SELECT c.id, c.course_name, " +
            "COUNT(DISTINCT a.id) AS total_assignments, " +
            "COUNT(DISTINCT s.assignment_id) AS submitted_assignments " +
            "FROM enrollments e " +
            "INNER JOIN courses c ON e.course_id = c.id " +
            "LEFT JOIN assignments a ON c.id = a.course_id " +
            "LEFT JOIN submissions s " +
            "ON a.id = s.assignment_id " +
            "AND s.student_id = ? " +
            "WHERE e.student_id = ? " +
            "GROUP BY c.id, c.course_name " +
            "ORDER BY c.course_name";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, studentId);
            statement.setInt(2, studentId);

            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {

                int courseId =
                        resultSet.getInt("id");

                String courseName =
                        resultSet.getString("course_name");

                int totalAssignments =
                        resultSet.getInt("total_assignments");

                int submittedAssignments =
                        resultSet.getInt("submitted_assignments");

                Progress progress =
                        new Progress(
                                courseId,
                                courseName,
                                totalAssignments,
                                submittedAssignments
                        );

                progressList.add(progress);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return progressList;
    }
}