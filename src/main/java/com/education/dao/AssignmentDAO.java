package com.education.dao;

import com.education.model.Assignment;
import com.education.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for Assignment operations
 */
public class AssignmentDAO {

    /**
     * Get assignments by course ID
     */
    public List<Assignment> getAssignmentsByCourse(int courseId) {
        List<Assignment> assignments = new ArrayList<>();
        String query = "SELECT a.*, c.CourseName " +
                "FROM assignment a " +
                "INNER JOIN course c ON a.CourseID = c.CourseID " +
                "WHERE a.CourseID = ? ORDER BY a.DueDate";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, courseId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                assignments.add(extractAssignmentFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return assignments;
    }

    /**
     * Get assignments for student (by enrolled courses)
     */
    public List<Assignment> getAssignmentsByStudent(int studentId) {
        List<Assignment> assignments = new ArrayList<>();
        String query = "SELECT a.*, c.CourseName " +
                "FROM assignment a " +
                "INNER JOIN course c ON a.CourseID = c.CourseID " +
                "INNER JOIN enrollment e ON c.CourseID = e.CourseID " +
                "WHERE e.StudentID = ? AND e.Status = 'Enrolled' " +
                "ORDER BY a.DueDate";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, studentId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                assignments.add(extractAssignmentFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return assignments;
    }

    /**
     * Get assignment by ID
     */
    public Assignment getAssignmentById(int assignmentId) {
        String query = "SELECT a.*, c.CourseName " +
                "FROM assignment a " +
                "INNER JOIN course c ON a.CourseID = c.CourseID " +
                "WHERE a.AssignmentID = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, assignmentId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return extractAssignmentFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Create new assignment
     */
    public boolean createAssignment(Assignment assignment) {
        String query = "INSERT INTO assignment (CourseID, Title, Description, DueDate, MaxPoints, Status) " +
                "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, assignment.getCourseID());
            stmt.setString(2, assignment.getTitle());
            stmt.setString(3, assignment.getDescription());
            stmt.setString(4, assignment.getDueDate());
            stmt.setInt(5, assignment.getMaxPoints());
            stmt.setString(6, assignment.getStatus() != null ? assignment.getStatus() : "Active");

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Update assignment
     */
    public boolean updateAssignment(Assignment assignment) {
        String query = "UPDATE assignment SET Title = ?, Description = ?, DueDate = ?, MaxPoints = ?, Status = ? " +
                "WHERE AssignmentID = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, assignment.getTitle());
            stmt.setString(2, assignment.getDescription());
            stmt.setString(3, assignment.getDueDate());
            stmt.setInt(4, assignment.getMaxPoints());
            stmt.setString(5, assignment.getStatus());
            stmt.setInt(6, assignment.getAssignmentID());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Delete assignment
     */
    public boolean deleteAssignment(int assignmentId) {
        String query = "DELETE FROM assignment WHERE AssignmentID = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, assignmentId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Extract Assignment object from ResultSet
     */
    private Assignment extractAssignmentFromResultSet(ResultSet rs) throws SQLException {
        Assignment assignment = new Assignment();
        assignment.setAssignmentID(rs.getInt("AssignmentID"));
        assignment.setCourseID(rs.getInt("CourseID"));
        assignment.setCourseName(rs.getString("CourseName"));
        assignment.setTitle(rs.getString("Title"));
        assignment.setDescription(rs.getString("Description"));
        assignment.setDueDate(rs.getString("DueDate"));
        assignment.setMaxPoints(rs.getInt("MaxPoints"));
        assignment.setStatus(rs.getString("Status"));
        assignment.setCreatedAt(rs.getTimestamp("CreatedAt"));
        return assignment;
    }
}
