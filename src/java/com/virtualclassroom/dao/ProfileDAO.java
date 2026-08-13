package com.virtualclassroom.dao;

import com.virtualclassroom.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ProfileDAO {

    // =====================================================
    // GET PROFILE
    //
    // profile[0] = fullname
    // profile[1] = email
    // profile[2] = role
    // =====================================================

    public String[] getProfile(int userId) {

        String[] profile = null;

        String sql =
                "SELECT fullname, email, role " +
                "FROM users " +
                "WHERE id = ?";

        try (
                Connection con =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        con.prepareStatement(sql)
        ) {

            ps.setInt(1, userId);

            try (ResultSet rs =
                    ps.executeQuery()) {

                if (rs.next()) {

                    profile = new String[3];

                    profile[0] =
                            rs.getString("fullname");

                    profile[1] =
                            rs.getString("email");

                    profile[2] =
                            rs.getString("role");
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return profile;
    }


    // =====================================================
    // UPDATE PROFILE
    // =====================================================

    public boolean updateProfile(
            int userId,
            String fullname,
            String email) {

        String sql =
                "UPDATE users " +
                "SET fullname = ?, email = ? " +
                "WHERE id = ?";

        try (
                Connection con =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        con.prepareStatement(sql)
        ) {

            ps.setString(1, fullname);
            ps.setString(2, email);
            ps.setInt(3, userId);

            int rows =
                    ps.executeUpdate();

            return rows > 0;

        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }


    // =====================================================
    // GET PASSWORD
    // Used by ChangePasswordServlet
    // =====================================================

    public String getPassword(int userId) {

        String password = null;

        String sql =
                "SELECT password " +
                "FROM users " +
                "WHERE id = ?";

        try (
                Connection con =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        con.prepareStatement(sql)
        ) {

            ps.setInt(1, userId);

            try (ResultSet rs =
                    ps.executeQuery()) {

                if (rs.next()) {

                    password =
                            rs.getString("password");
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return password;
    }


    // =====================================================
    // UPDATE PASSWORD
    // Used by ChangePasswordServlet
    // =====================================================

    public boolean updatePassword(
            int userId,
            String newPassword) {

        String sql =
                "UPDATE users " +
                "SET password = ? " +
                "WHERE id = ?";

        try (
                Connection con =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        con.prepareStatement(sql)
        ) {

            ps.setString(1, newPassword);
            ps.setInt(2, userId);

            int rows =
                    ps.executeUpdate();

            return rows > 0;

        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }


    // =====================================================
    // GET USER ID BY EMAIL
    // Used by ForgotPasswordServlet
    // and ResetPasswordServlet
    // =====================================================

    public int getUserIdByEmail(String email) {

        int userId = -1;

        String sql =
                "SELECT id " +
                "FROM users " +
                "WHERE email = ?";

        try (
                Connection con =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        con.prepareStatement(sql)
        ) {

            ps.setString(1, email);

            try (ResultSet rs =
                    ps.executeQuery()) {

                if (rs.next()) {

                    userId =
                            rs.getInt("id");
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return userId;
    }


    // =====================================================
    // CHECK WHETHER EMAIL EXISTS
    // =====================================================

    public boolean emailExists(String email) {

        String sql =
                "SELECT id " +
                "FROM users " +
                "WHERE email = ?";

        try (
                Connection con =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        con.prepareStatement(sql)
        ) {

            ps.setString(1, email);

            try (ResultSet rs =
                    ps.executeQuery()) {

                return rs.next();
            }

        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }


    // =====================================================
    // UPDATE PASSWORD BY EMAIL
    // Used by ResetPasswordServlet
    // =====================================================

    public boolean updatePasswordByEmail(
            String email,
            String newPassword) {

        String sql =
                "UPDATE users " +
                "SET password = ? " +
                "WHERE email = ?";

        try (
                Connection con =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        con.prepareStatement(sql)
        ) {

            ps.setString(1, newPassword);
            ps.setString(2, email);

            int rows =
                    ps.executeUpdate();

            return rows > 0;

        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }


    // =====================================================
    // GET USERNAME/FULL NAME BY EMAIL
    // Useful for Forgot Password
    // =====================================================

    public String getFullnameByEmail(String email) {

        String fullname = null;

        String sql =
                "SELECT fullname " +
                "FROM users " +
                "WHERE email = ?";

        try (
                Connection con =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        con.prepareStatement(sql)
        ) {

            ps.setString(1, email);

            try (ResultSet rs =
                    ps.executeQuery()) {

                if (rs.next()) {

                    fullname =
                            rs.getString("fullname");
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return fullname;
    }
}