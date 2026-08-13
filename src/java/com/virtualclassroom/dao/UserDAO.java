package com.virtualclassroom.dao;

import com.virtualclassroom.model.User;
import com.virtualclassroom.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

    // Register a new user
    public boolean registerUser(User user) {

        String sql = "INSERT INTO users (fullname, email, password, role) VALUES (?, ?, ?, ?)";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, user.getFullname());
            statement.setString(2, user.getEmail());
            statement.setString(3, user.getPassword());
            statement.setString(4, user.getRole());

            int rowsInserted = statement.executeUpdate();

            return rowsInserted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Check whether an email already exists
    public boolean emailExists(String email) {

        String sql = "SELECT id FROM users WHERE email = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, email);

            ResultSet resultSet = statement.executeQuery();

            return resultSet.next();

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
// Get a user by ID
public com.virtualclassroom.model.User getUserById(int userId) {

    String sql =
            "SELECT id, fullname, email, password, role " +
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

                com.virtualclassroom.model.User user =
                        new com.virtualclassroom.model.User();

                user.setId(
                        resultSet.getInt("id")
                );

                user.setFullname(
                        resultSet.getString("fullname")
                );

                user.setEmail(
                        resultSet.getString("email")
                );

                user.setPassword(
                        resultSet.getString("password")
                );

                user.setRole(
                        resultSet.getString("role")
                );

                return user;
            }
        }

    } catch (SQLException e) {

        e.printStackTrace();
    }

    return null;
}


}