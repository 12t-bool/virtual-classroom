package com.virtualclassroom.dao;

import com.virtualclassroom.model.Announcement;
import com.virtualclassroom.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AnnouncementDAO {


// Create a new announcement
public boolean addAnnouncement(
        Announcement announcement) {

    String sql =
            "INSERT INTO announcements " +
            "(teacher_id, course_id, title, message) " +
            "VALUES (?, ?, ?, ?)";

    try (Connection connection =
                 DBConnection.getConnection();
         PreparedStatement statement =
                 connection.prepareStatement(sql)) {

        statement.setInt(
                1,
                announcement.getTeacherId()
        );

        statement.setInt(
                2,
                announcement.getCourseId()
        );

        statement.setString(
                3,
                announcement.getTitle()
        );

        statement.setString(
                4,
                announcement.getMessage()
        );

        int rowsInserted =
                statement.executeUpdate();

        return rowsInserted > 0;

    } catch (SQLException e) {

        e.printStackTrace();
        return false;
    }
}


// Get announcements created by a teacher
public List<Announcement> getAnnouncementsByTeacher(
        int teacherId) {

    List<Announcement> announcements =
            new ArrayList<>();

    String sql =
            "SELECT id, teacher_id, course_id, " +
            "title, message, created_at " +
            "FROM announcements " +
            "WHERE teacher_id = ? " +
            "ORDER BY created_at DESC";

    try (Connection connection =
                 DBConnection.getConnection();
         PreparedStatement statement =
                 connection.prepareStatement(sql)) {

        statement.setInt(1, teacherId);

        try (ResultSet resultSet =
                     statement.executeQuery()) {

            while (resultSet.next()) {

                Announcement announcement =
                        new Announcement();

                announcement.setId(
                        resultSet.getInt("id")
                );

                announcement.setTeacherId(
                        resultSet.getInt("teacher_id")
                );

                announcement.setCourseId(
                        resultSet.getInt("course_id")
                );

                announcement.setTitle(
                        resultSet.getString("title")
                );

                announcement.setMessage(
                        resultSet.getString("message")
                );

                announcement.setCreatedAt(
                        resultSet.getString("created_at")
                );

                announcements.add(
                        announcement
                );
            }
        }

    } catch (SQLException e) {

        e.printStackTrace();
    }

    return announcements;
}


// Get announcements for multiple courses
public List<Announcement> getAnnouncementsByCourses(
        List<Integer> courseIds) {

    List<Announcement> announcements =
            new ArrayList<>();

    if (courseIds == null ||
        courseIds.isEmpty()) {

        return announcements;
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
            "SELECT id, teacher_id, course_id, " +
            "title, message, created_at " +
            "FROM announcements " +
            "WHERE course_id IN (" +
            placeholders +
            ") " +
            "ORDER BY created_at DESC";

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

                Announcement announcement =
                        new Announcement();

                announcement.setId(
                        resultSet.getInt("id")
                );

                announcement.setTeacherId(
                        resultSet.getInt("teacher_id")
                );

                announcement.setCourseId(
                        resultSet.getInt("course_id")
                );

                announcement.setTitle(
                        resultSet.getString("title")
                );

                announcement.setMessage(
                        resultSet.getString("message")
                );

                announcement.setCreatedAt(
                        resultSet.getString("created_at")
                );

                announcements.add(
                        announcement
                );
            }
        }

    } catch (SQLException e) {

        e.printStackTrace();
    }

    return announcements;
}


}
