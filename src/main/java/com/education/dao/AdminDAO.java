package com.education.dao;

import com.education.model.Admin;
import com.education.util.DBConnection;

import java.sql.*;

/**
 * Data Access Object for Admin operations
 */
public class AdminDAO {

    /**
     * Authenticate admin login
     */
    public Admin login(String email, String password) {
        String query = "SELECT * FROM admin WHERE Email = ? AND Password = ? AND Status = 'Active'";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, email);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return extractAdminFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Get admin by ID
     */
    public Admin getAdminById(int adminId) {
        String query = "SELECT * FROM admin WHERE AdminID = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, adminId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return extractAdminFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Extract Admin object from ResultSet
     */
    private Admin extractAdminFromResultSet(ResultSet rs) throws SQLException {
        Admin admin = new Admin();
        admin.setAdminID(rs.getInt("AdminID"));
        admin.setFirstName(rs.getString("FirstName"));
        admin.setLastName(rs.getString("LastName"));
        admin.setEmail(rs.getString("Email"));
        admin.setPassword(rs.getString("Password"));
        admin.setPhone(rs.getString("Phone"));
        admin.setRole(rs.getString("Role"));
        admin.setStatus(rs.getString("Status"));
        admin.setCreatedAt(rs.getTimestamp("CreatedAt"));
        return admin;
    }
}
