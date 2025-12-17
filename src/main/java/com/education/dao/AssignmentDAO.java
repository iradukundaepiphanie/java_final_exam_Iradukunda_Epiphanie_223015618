package com.education.dao;

import com.education.model.Assignment;
import com.education.model.AssignmentQuestion;
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
        String query = "SELECT a.*, c.CourseName, " +
                "CASE WHEN asub.SubmissionID IS NOT NULL THEN 1 ELSE 0 END as Submitted " +
                "FROM assignment a " +
                "INNER JOIN course c ON a.CourseID = c.CourseID " +
                "INNER JOIN enrollment e ON c.CourseID = e.CourseID " +
                "LEFT JOIN assignmentsubmission asub ON a.AssignmentID = asub.AssignmentID AND asub.StudentID = ? " +
                "WHERE e.StudentID = ? AND e.Status = 'Enrolled' " +
                "ORDER BY a.DueDate";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, studentId);
            stmt.setInt(2, studentId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Assignment assignment = extractAssignmentFromResultSet(rs);
                assignment.setSubmitted(rs.getBoolean("Submitted"));
                assignments.add(assignment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return assignments;
    }

    /**
     * Get assignments by instructor ID
     */
    public List<Assignment> getAssignmentsByInstructor(int instructorId) {
        List<Assignment> assignments = new ArrayList<>();
        String query = "SELECT a.*, c.CourseName, " +
                "COUNT(DISTINCT asub.SubmissionID) as SubmissionCount " +
                "FROM assignment a " +
                "INNER JOIN course c ON a.CourseID = c.CourseID " +
                "LEFT JOIN assignmentsubmission asub ON a.AssignmentID = asub.AssignmentID " +
                "WHERE c.InstructorID = ? " +
                "GROUP BY a.AssignmentID " +
                "ORDER BY a.CreatedAt DESC, a.DueDate";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, instructorId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Assignment assignment = extractAssignmentFromResultSet(rs);
                assignment.setSubmissionCount(rs.getInt("SubmissionCount"));
                assignments.add(assignment);
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
     * Create new assignment with enhanced fields
     */
    public int createAssignment(Assignment assignment) {
        String query = "INSERT INTO assignment (CourseID, Title, Description, DueDate, MaxPoints, Status, " +
                "AssignmentType, Timed, TimeLimit, AvailableFrom, AvailableUntil, AutoGraded) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, assignment.getCourseID());
            stmt.setString(2, assignment.getTitle());
            stmt.setString(3, assignment.getDescription());
            stmt.setString(4, assignment.getDueDate());
            stmt.setInt(5, assignment.getMaxPoints());
            stmt.setString(6, assignment.getStatus() != null ? assignment.getStatus() : "Active");
            stmt.setString(7, assignment.getAssignmentType() != null ? assignment.getAssignmentType() : "ESSAY");
            stmt.setBoolean(8, assignment.isTimed());
            stmt.setObject(9, assignment.getTimeLimit() > 0 ? assignment.getTimeLimit() : null);

            if (assignment.getAvailableFrom() != null) {
                stmt.setTimestamp(10, new Timestamp(assignment.getAvailableFrom().getTime()));
            } else {
                stmt.setNull(10, Types.TIMESTAMP);
            }

            if (assignment.getAvailableUntil() != null) {
                stmt.setTimestamp(11, new Timestamp(assignment.getAvailableUntil().getTime()));
            } else {
                stmt.setNull(11, Types.TIMESTAMP);
            }

            stmt.setBoolean(12, assignment.isAutoGraded());

            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        return generatedKeys.getInt(1); // Return the generated assignmentID
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0; // Return 0 if failed
    }

    /**
     * Create assignment question for MCQ assignments
     */
    public boolean createAssignmentQuestion(AssignmentQuestion question) {
        String query = "INSERT INTO assignmentquestion (AssignmentID, QuestionText, QuestionOrder, Points, " +
                "OptionA, OptionB, OptionC, OptionD, CorrectAnswer) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, question.getAssignmentID());
            stmt.setString(2, question.getQuestionText());
            stmt.setInt(3, question.getQuestionOrder());
            stmt.setInt(4, (int) question.getPoints());
            stmt.setString(5, question.getOptionA());
            stmt.setString(6, question.getOptionB());
            stmt.setString(7, question.getOptionC());
            stmt.setString(8, question.getOptionD());
            stmt.setString(9, question.getCorrectAnswer());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Get all questions for an assignment
     */
    public List<AssignmentQuestion> getAssignmentQuestions(int assignmentId) {
        List<AssignmentQuestion> questions = new ArrayList<>();
        String query = "SELECT * FROM assignmentquestion WHERE AssignmentID = ? ORDER BY QuestionOrder";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, assignmentId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                AssignmentQuestion question = new AssignmentQuestion();
                question.setQuestionID(rs.getInt("QuestionID"));
                question.setAssignmentID(rs.getInt("AssignmentID"));
                question.setQuestionText(rs.getString("QuestionText"));
                question.setQuestionOrder(rs.getInt("QuestionOrder"));
                question.setPoints(rs.getInt("Points"));
                question.setOptionA(rs.getString("OptionA"));
                question.setOptionB(rs.getString("OptionB"));
                question.setOptionC(rs.getString("OptionC"));
                question.setOptionD(rs.getString("OptionD"));
                question.setCorrectAnswer(rs.getString("CorrectAnswer"));
                question.setCreatedAt(rs.getTimestamp("CreatedAt"));
                questions.add(question);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return questions;
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
