package com.education.dao;

import com.education.model.Enrollment;
import com.education.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for Enrollment operations
 */
public class EnrollmentDAO {

    /**
     * Get enrollments by student ID
     */
    public List<Enrollment> getEnrollmentsByStudent(int studentId) {
        List<Enrollment> enrollments = new ArrayList<>();
        String query = "SELECT e.*, c.CourseName, CONCAT(s.FirstName, ' ', s.LastName) AS StudentName " +
                "FROM enrollment e " +
                "INNER JOIN course c ON e.CourseID = c.CourseID " +
                "INNER JOIN student s ON e.StudentID = s.StudentID " +
                "WHERE e.StudentID = ? ORDER BY e.EnrollmentDate DESC";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, studentId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                enrollments.add(extractEnrollmentFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return enrollments;
    }

    /**
     * Get enrollments by course ID
     */
    public List<Enrollment> getEnrollmentsByCourse(int courseId) {
        List<Enrollment> enrollments = new ArrayList<>();
        String query = "SELECT e.*, c.CourseName, CONCAT(s.FirstName, ' ', s.LastName) AS StudentName " +
                "FROM enrollment e " +
                "INNER JOIN course c ON e.CourseID = c.CourseID " +
                "INNER JOIN student s ON e.StudentID = s.StudentID " +
                "WHERE e.CourseID = ? ORDER BY s.LastName, s.FirstName";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, courseId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                enrollments.add(extractEnrollmentFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return enrollments;
    }

    /**
     * Get enrollment by ID
     */
    public Enrollment getEnrollmentById(int enrollmentId) {
        String query = "SELECT e.*, c.CourseName, CONCAT(s.FirstName, ' ', s.LastName) AS StudentName " +
                "FROM enrollment e " +
                "INNER JOIN course c ON e.CourseID = c.CourseID " +
                "INNER JOIN student s ON e.StudentID = s.StudentID " +
                "WHERE e.EnrollmentID = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, enrollmentId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return extractEnrollmentFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Create new enrollment
     */
    public boolean createEnrollment(Enrollment enrollment) {
        String query = "INSERT INTO enrollment (StudentID, CourseID, EnrollmentDate, Status) " +
                "VALUES (?, ?, CURDATE(), 'Enrolled')";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, enrollment.getStudentID());
            stmt.setInt(2, enrollment.getCourseID());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Update enrollment status
     */
    public boolean updateEnrollmentStatus(int enrollmentId, String status) {
        String query = "UPDATE enrollment SET Status = ? WHERE EnrollmentID = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, status);
            stmt.setInt(2, enrollmentId);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Extract Enrollment object from ResultSet
     */
    private Enrollment extractEnrollmentFromResultSet(ResultSet rs) throws SQLException {
        Enrollment enrollment = new Enrollment();
        enrollment.setEnrollmentID(rs.getInt("EnrollmentID"));
        enrollment.setStudentID(rs.getInt("StudentID"));
        enrollment.setCourseID(rs.getInt("CourseID"));
        enrollment.setStudentName(rs.getString("StudentName"));
        enrollment.setCourseName(rs.getString("CourseName"));
        enrollment.setEnrollmentDate(rs.getString("EnrollmentDate"));
        enrollment.setStatus(rs.getString("Status"));
        enrollment.setGrade(rs.getString("Grade"));
        enrollment.setCompletionDate(rs.getString("CompletionDate"));
        enrollment.setCreatedAt(rs.getTimestamp("CreatedAt"));
        return enrollment;
    }
}
