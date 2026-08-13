package com.virtualclassroom.dao;

import com.virtualclassroom.model.StudyMaterial;
import com.virtualclassroom.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class StudyMaterialDAO {


// Add a study material
public boolean addStudyMaterial(StudyMaterial material) {

    String sql = "INSERT INTO study_materials "
               + "(course_id, title, description, file_url) "
               + "VALUES (?, ?, ?, ?)";

    try (Connection connection = DBConnection.getConnection();
         PreparedStatement statement =
                 connection.prepareStatement(sql)) {

        statement.setInt(1, material.getCourseId());
        statement.setString(2, material.getTitle());
        statement.setString(3, material.getDescription());
        statement.setString(4, material.getFileUrl());

        int rowsInserted = statement.executeUpdate();

        return rowsInserted > 0;

    } catch (SQLException e) {

        e.printStackTrace();
        return false;
    }
}

// Get all study materials for a particular course
public List<StudyMaterial> getMaterialsByCourse(int courseId) {

    List<StudyMaterial> materials = new ArrayList<>();

    String sql = "SELECT id, course_id, title, description, file_url "
               + "FROM study_materials "
               + "WHERE course_id = ? "
               + "ORDER BY created_at DESC";

    try (Connection connection = DBConnection.getConnection();
         PreparedStatement statement =
                 connection.prepareStatement(sql)) {

        statement.setInt(1, courseId);

        try (ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {

                StudyMaterial material =
                        new StudyMaterial();

                material.setId(
                        resultSet.getInt("id")
                );

                material.setCourseId(
                        resultSet.getInt("course_id")
                );

                material.setTitle(
                        resultSet.getString("title")
                );

                material.setDescription(
                        resultSet.getString("description")
                );

                material.setFileUrl(
                        resultSet.getString("file_url")
                );

                materials.add(material);
            }
        }

    } catch (SQLException e) {

        e.printStackTrace();
    }

    return materials;
}


}
