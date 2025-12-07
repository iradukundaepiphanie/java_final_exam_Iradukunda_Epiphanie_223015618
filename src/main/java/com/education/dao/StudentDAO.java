package com.education.dao;

import com.education.model.Student;
import com.education.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for Student operations
 */
public class StudentDAO {

    /**
     * Authenticate student login
     */
    public Student login(String email, String password) {
        String query = "SELECT * FROM student WHERE Email = ? AND Password = ? AND Status = 'Active'";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, email);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return extractStudentFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Get student by ID
     */
    public Student getStudentById(int studentId) {
        String query = "SELECT * FROM student WHERE StudentID = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, studentId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return extractStudentFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Get all students
     */
    public List<Student> getAllStudents() {
        List<Student> students = new ArrayList<>();
        String query = "SELECT * FROM student ORDER BY FirstName, LastName";

        try (Connection conn = DBConnection.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                students.add(extractStudentFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return students;
    }

    /**
     * Create new student
     */
    public boolean createStudent(Student student) {
        String query = "INSERT INTO student (FirstName, LastName, Email, Password, Phone, DateOfBirth, Address, Status) "
                +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, student.getFirstName());
            stmt.setString(2, student.getLastName());
            stmt.setString(3, student.getEmail());
            stmt.setString(4, student.getPassword());
            stmt.setString(5, student.getPhone());
            stmt.setString(6, student.getDateOfBirth());
            stmt.setString(7, student.getAddress());
            stmt.setString(8, student.getStatus() != null ? student.getStatus() : "Active");

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Update student
     */
    public boolean updateStudent(Student student) {
        String query = "UPDATE student SET FirstName = ?, LastName = ?, Email = ?, Phone = ?, " +
                "DateOfBirth = ?, Address = ?, Status = ? WHERE StudentID = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, student.getFirstName());
            stmt.setString(2, student.getLastName());
            stmt.setString(3, student.getEmail());
            stmt.setString(4, student.getPhone());
            stmt.setString(5, student.getDateOfBirth());
            stmt.setString(6, student.getAddress());
            stmt.setString(7, student.getStatus());
            stmt.setInt(8, student.getStudentID());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Delete student
     */
    public boolean deleteStudent(int studentId) {
        String query = "DELETE FROM student WHERE StudentID = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, studentId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Extract Student object from ResultSet
     */
    private Student extractStudentFromResultSet(ResultSet rs) throws SQLException {
        Student student = new Student();
        student.setStudentID(rs.getInt("StudentID"));
        student.setFirstName(rs.getString("FirstName"));
        student.setLastName(rs.getString("LastName"));
        student.setEmail(rs.getString("Email"));
        student.setPassword(rs.getString("Password"));
        student.setPhone(rs.getString("Phone"));
        student.setDateOfBirth(rs.getString("DateOfBirth"));
        student.setAddress(rs.getString("Address"));
        student.setEnrollmentDate(rs.getString("EnrollmentDate"));
        student.setStatus(rs.getString("Status"));
        student.setCreatedAt(rs.getTimestamp("CreatedAt"));
        return student;
    }
}
