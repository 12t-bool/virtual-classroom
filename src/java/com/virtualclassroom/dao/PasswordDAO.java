package com.virtualclassroom.dao;

import com.virtualclassroom.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class PasswordDAO {

    // ==========================================
    // VERIFY CURRENT PASSWORD
    // ==========================================

    public boolean verifyPassword(
            int userId,
            String password) {

        String sql =
                "SELECT password " +
                "FROM users " +
                "WHERE id = ?";

        try (Connection connection =
                     DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, userId);

            try (ResultSet resultSet =
                         statement.executeQuery()) {

                if (resultSet.next()) {

                    String storedPassword =
                            resultSet.getString("password");

                    return password.equals(
                            storedPassword
                    );
                }
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return false;
    }


    // ==========================================
    // CHANGE PASSWORD
    // ==========================================

    public boolean changePassword(
            int userId,
            String newPassword) {

        String sql =
                "UPDATE users " +
                "SET password = ? " +
                "WHERE id = ?";

        try (Connection connection =
                     DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(
                    1,
                    newPassword
            );

            statement.setInt(
                    2,
                    userId
            );

            int rowsUpdated =
                    statement.executeUpdate();

            return rowsUpdated > 0;

        } catch (SQLException e) {

            e.printStackTrace();

            return false;
        }
    }
}