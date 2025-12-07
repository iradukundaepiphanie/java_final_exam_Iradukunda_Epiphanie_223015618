package com.education.dao;

import com.education.model.Course;
import com.education.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for Course operations
 */
public class CourseDAO {

    /**
     * Get all courses
     */
    public List<Course> getAllCourses() {
        List<Course> courses = new ArrayList<>();
        String query = "SELECT c.*, CONCAT(i.FirstName, ' ', i.LastName) AS InstructorName " +
                "FROM course c " +
                "LEFT JOIN instructor i ON c.InstructorID = i.InstructorID " +
                "ORDER BY c.CourseName";

        try (Connection conn = DBConnection.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                courses.add(extractCourseFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return courses;
    }

    /**
     * Get courses by instructor ID
     */
    public List<Course> getCoursesByInstructor(int instructorId) {
        List<Course> courses = new ArrayList<>();
        String query = "SELECT c.*, CONCAT(i.FirstName, ' ', i.LastName) AS InstructorName " +
                "FROM course c " +
                "LEFT JOIN instructor i ON c.InstructorID = i.InstructorID " +
                "WHERE c.InstructorID = ? ORDER BY c.CourseName";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, instructorId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                courses.add(extractCourseFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return courses;
    }

    /**
     * Get courses enrolled by student
     */
    public List<Course> getCoursesByStudent(int studentId) {
        List<Course> courses = new ArrayList<>();
        String query = "SELECT c.*, CONCAT(i.FirstName, ' ', i.LastName) AS InstructorName " +
                "FROM course c " +
                "INNER JOIN enrollment e ON c.CourseID = e.CourseID " +
                "LEFT JOIN instructor i ON c.InstructorID = i.InstructorID " +
                "WHERE e.StudentID = ? AND e.Status = 'Enrolled' " +
                "ORDER BY c.CourseName";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, studentId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                courses.add(extractCourseFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return courses;
    }

    /**
     * Get course by ID
     */
    public Course getCourseById(int courseId) {
        String query = "SELECT c.*, CONCAT(i.FirstName, ' ', i.LastName) AS InstructorName " +
                "FROM course c " +
                "LEFT JOIN instructor i ON c.InstructorID = i.InstructorID " +
                "WHERE c.CourseID = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, courseId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return extractCourseFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Create new course
     */
    public boolean createCourse(Course course) {
        String query = "INSERT INTO course (CourseName, CourseCode, Description, Credits, InstructorID, StartDate, EndDate, Status) "
                +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, course.getCourseName());
            stmt.setString(2, course.getCourseCode());
            stmt.setString(3, course.getDescription());
            stmt.setInt(4, course.getCredits());
            stmt.setInt(5, course.getInstructorID());
            stmt.setString(6, course.getStartDate());
            stmt.setString(7, course.getEndDate());
            stmt.setString(8, course.getStatus() != null ? course.getStatus() : "Active");

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Update course
     */
    public boolean updateCourse(Course course) {
        String query = "UPDATE course SET CourseName = ?, CourseCode = ?, Description = ?, Credits = ?, " +
                "InstructorID = ?, StartDate = ?, EndDate = ?, Status = ? WHERE CourseID = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, course.getCourseName());
            stmt.setString(2, course.getCourseCode());
            stmt.setString(3, course.getDescription());
            stmt.setInt(4, course.getCredits());
            stmt.setInt(5, course.getInstructorID());
            stmt.setString(6, course.getStartDate());
            stmt.setString(7, course.getEndDate());
            stmt.setString(8, course.getStatus());
            stmt.setInt(9, course.getCourseID());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Delete course
     */
    public boolean deleteCourse(int courseId) {
        String query = "DELETE FROM course WHERE CourseID = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, courseId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Extract Course object from ResultSet
     */
    private Course extractCourseFromResultSet(ResultSet rs) throws SQLException {
        Course course = new Course();
        course.setCourseID(rs.getInt("CourseID"));
        course.setCourseName(rs.getString("CourseName"));
        course.setCourseCode(rs.getString("CourseCode"));
        course.setDescription(rs.getString("Description"));
        course.setCredits(rs.getInt("Credits"));
        course.setInstructorID(rs.getInt("InstructorID"));
        course.setInstructorName(rs.getString("InstructorName"));
        course.setStartDate(rs.getString("StartDate"));
        course.setEndDate(rs.getString("EndDate"));
        course.setStatus(rs.getString("Status"));
        course.setCreatedAt(rs.getTimestamp("CreatedAt"));
        return course;
    }
}
