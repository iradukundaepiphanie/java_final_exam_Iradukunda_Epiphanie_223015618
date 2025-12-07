package com.education.dao;

import com.education.model.Grade;
import com.education.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for Grade operations
 */
public class GradeDAO {

    /**
     * Get grades by student ID
     */
    public List<Grade> getGradesByStudent(int studentId) {
        List<Grade> grades = new ArrayList<>();
        String query = "SELECT g.*, a.Title AS AssignmentTitle, a.MaxPoints, " +
                "CONCAT(s.FirstName, ' ', s.LastName) AS StudentName " +
                "FROM grade g " +
                "INNER JOIN assignment a ON g.AssignmentID = a.AssignmentID " +
                "INNER JOIN student s ON g.StudentID = s.StudentID " +
                "WHERE g.StudentID = ? ORDER BY g.GradedDate DESC";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, studentId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                grades.add(extractGradeFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return grades;
    }

    /**
     * Get grades by assignment ID
     */
    public List<Grade> getGradesByAssignment(int assignmentId) {
        List<Grade> grades = new ArrayList<>();
        String query = "SELECT g.*, a.Title AS AssignmentTitle, a.MaxPoints, " +
                "CONCAT(s.FirstName, ' ', s.LastName) AS StudentName " +
                "FROM grade g " +
                "INNER JOIN assignment a ON g.AssignmentID = a.AssignmentID " +
                "INNER JOIN student s ON g.StudentID = s.StudentID " +
                "WHERE g.AssignmentID = ? ORDER BY s.LastName, s.FirstName";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, assignmentId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                grades.add(extractGradeFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return grades;
    }

    /**
     * Get grade by ID
     */
    public Grade getGradeById(int gradeId) {
        String query = "SELECT g.*, a.Title AS AssignmentTitle, a.MaxPoints, " +
                "CONCAT(s.FirstName, ' ', s.LastName) AS StudentName " +
                "FROM grade g " +
                "INNER JOIN assignment a ON g.AssignmentID = a.AssignmentID " +
                "INNER JOIN student s ON g.StudentID = s.StudentID " +
                "WHERE g.GradeID = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, gradeId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return extractGradeFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Submit assignment (create grade entry)
     */
    public boolean submitAssignment(Grade grade) {
        String query = "INSERT INTO grade (StudentID, AssignmentID, EnrollmentID, SubmissionDate, Status) " +
                "VALUES (?, ?, ?, ?, 'Submitted')";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, grade.getStudentID());
            stmt.setInt(2, grade.getAssignmentID());
            stmt.setInt(3, grade.getEnrollmentID());
            stmt.setString(4, grade.getSubmissionDate());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Grade assignment
     */
    public boolean gradeAssignment(Grade grade) {
        String query = "UPDATE grade SET PointsEarned = ?, Feedback = ?, GradedDate = ?, Status = 'Graded' " +
                "WHERE GradeID = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setBigDecimal(1, grade.getPointsEarned());
            stmt.setString(2, grade.getFeedback());
            stmt.setString(3, grade.getGradedDate());
            stmt.setInt(4, grade.getGradeID());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Extract Grade object from ResultSet
     */
    private Grade extractGradeFromResultSet(ResultSet rs) throws SQLException {
        Grade grade = new Grade();
        grade.setGradeID(rs.getInt("GradeID"));
        grade.setStudentID(rs.getInt("StudentID"));
        grade.setAssignmentID(rs.getInt("AssignmentID"));
        grade.setEnrollmentID(rs.getInt("EnrollmentID"));
        grade.setStudentName(rs.getString("StudentName"));
        grade.setAssignmentTitle(rs.getString("AssignmentTitle"));
        grade.setPointsEarned(rs.getBigDecimal("PointsEarned"));
        grade.setMaxPoints(rs.getInt("MaxPoints"));
        grade.setFeedback(rs.getString("Feedback"));
        grade.setSubmissionDate(rs.getString("SubmissionDate"));
        grade.setGradedDate(rs.getString("GradedDate"));
        grade.setStatus(rs.getString("Status"));
        grade.setCreatedAt(rs.getTimestamp("CreatedAt"));
        return grade;
    }
}
