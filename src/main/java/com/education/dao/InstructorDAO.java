package com.education.dao;

import com.education.model.Instructor;
import com.education.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for Instructor operations
 */
public class InstructorDAO {

    /**
     * Authenticate instructor login
     */
    public Instructor login(String email, String password) {
        String query = "SELECT * FROM instructor WHERE Email = ? AND Password = ? AND Status = 'Active'";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, email);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return extractInstructorFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Get instructor by ID
     */
    public Instructor getInstructorById(int instructorId) {
        String query = "SELECT * FROM instructor WHERE InstructorID = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, instructorId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return extractInstructorFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Get all instructors
     */
    public List<Instructor> getAllInstructors() {
        List<Instructor> instructors = new ArrayList<>();
        String query = "SELECT * FROM instructor ORDER BY FirstName, LastName";

        try (Connection conn = DBConnection.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                instructors.add(extractInstructorFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return instructors;
    }

    /**
     * Create new instructor
     */
    public boolean createInstructor(Instructor instructor) {
        String query = "INSERT INTO instructor (FirstName, LastName, Email, Password, Phone, Department, Specialization, HireDate, Status) "
                +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, instructor.getFirstName());
            stmt.setString(2, instructor.getLastName());
            stmt.setString(3, instructor.getEmail());
            stmt.setString(4, instructor.getPassword());
            stmt.setString(5, instructor.getPhone());
            stmt.setString(6, instructor.getDepartment());
            stmt.setString(7, instructor.getSpecialization());
            stmt.setString(8, instructor.getHireDate());
            stmt.setString(9, instructor.getStatus() != null ? instructor.getStatus() : "Active");

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Update instructor
     */
    public boolean updateInstructor(Instructor instructor) {
        String query = "UPDATE instructor SET FirstName = ?, LastName = ?, Email = ?, Phone = ?, " +
                "Department = ?, Specialization = ?, Status = ? WHERE InstructorID = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, instructor.getFirstName());
            stmt.setString(2, instructor.getLastName());
            stmt.setString(3, instructor.getEmail());
            stmt.setString(4, instructor.getPhone());
            stmt.setString(5, instructor.getDepartment());
            stmt.setString(6, instructor.getSpecialization());
            stmt.setString(7, instructor.getStatus());
            stmt.setInt(8, instructor.getInstructorID());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Delete instructor
     */
    public boolean deleteInstructor(int instructorId) {
        String query = "DELETE FROM instructor WHERE InstructorID = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, instructorId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Extract Instructor object from ResultSet
     */
    private Instructor extractInstructorFromResultSet(ResultSet rs) throws SQLException {
        Instructor instructor = new Instructor();
        instructor.setInstructorID(rs.getInt("InstructorID"));
        instructor.setFirstName(rs.getString("FirstName"));
        instructor.setLastName(rs.getString("LastName"));
        instructor.setEmail(rs.getString("Email"));
        instructor.setPassword(rs.getString("Password"));
        instructor.setPhone(rs.getString("Phone"));
        instructor.setDepartment(rs.getString("Department"));
        instructor.setSpecialization(rs.getString("Specialization"));
        instructor.setHireDate(rs.getString("HireDate"));
        instructor.setStatus(rs.getString("Status"));
        instructor.setCreatedAt(rs.getTimestamp("CreatedAt"));
        return instructor;
    }
}
