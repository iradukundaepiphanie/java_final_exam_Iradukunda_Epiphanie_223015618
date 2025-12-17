package com.education.dao;

import com.education.model.AssignmentSubmission;
import com.education.model.StudentAnswer;
import com.education.model.AssignmentQuestion;
import com.education.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Data Access Object for AssignmentSubmission operations
 */
public class AssignmentSubmissionDAO {

    /**
     * Submit an assignment
     */
    public boolean submitAssignment(AssignmentSubmission submission) {
        String query = "INSERT INTO assignmentsubmission (AssignmentID, StudentID, SubmissionDate, EssayAnswer, TimeTaken, Status) "
                +
                "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, submission.getAssignmentID());
            stmt.setInt(2, submission.getStudentID());
            stmt.setTimestamp(3, new Timestamp(submission.getSubmissionDate().getTime()));
            stmt.setString(4, submission.getEssayAnswer());
            stmt.setInt(5, submission.getTimeTaken());
            stmt.setString(6, submission.getStatus());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Create a new assignment submission and return the generated ID
     */
    public int createSubmission(AssignmentSubmission submission) {
        String query = "INSERT INTO assignmentsubmission (AssignmentID, StudentID, SubmissionDate, " +
                "EssayAnswer, EssayContent, TimeTaken, AutoGraded, Score, Status) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, submission.getAssignmentID());
            stmt.setInt(2, submission.getStudentID());
            stmt.setTimestamp(3, new Timestamp(submission.getSubmissionDate().getTime()));
            stmt.setString(4, submission.getEssayAnswer());
            stmt.setString(5, submission.getEssayAnswer()); // Also save to EssayContent
            stmt.setInt(6, submission.getTimeTaken());
            stmt.setBoolean(7, submission.isAutoGraded());
            stmt.setDouble(8, submission.getScore());
            stmt.setString(9, submission.getStatus());

            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                ResultSet rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    /**
     * Save a student's answer to an MCQ question
     */
    public boolean saveStudentAnswer(StudentAnswer answer) {
        String query = "INSERT INTO studentanswer (SubmissionID, QuestionID, SelectedAnswer, IsCorrect, PointsEarned) "
                +
                "VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, answer.getSubmissionID());
            stmt.setInt(2, answer.getQuestionID());
            stmt.setString(3, answer.getSelectedAnswer());
            stmt.setBoolean(4, answer.isCorrect());
            stmt.setBigDecimal(5, answer.getPointsEarned());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Auto-grade an MCQ submission
     */
    public double autoGradeSubmission(int submissionId, Map<Integer, String> studentAnswers,
            List<AssignmentQuestion> questions) {
        double totalScore = 0.0;

        for (AssignmentQuestion question : questions) {
            String selectedAnswer = studentAnswers.get(question.getQuestionID());
            if (selectedAnswer == null) {
                selectedAnswer = "";
            }

            boolean isCorrect = question.getCorrectAnswer().equalsIgnoreCase(selectedAnswer);
            double pointsEarned = isCorrect ? question.getPoints() : 0.0;
            totalScore += pointsEarned;

            // Save individual answer
            StudentAnswer answer = new StudentAnswer();
            answer.setSubmissionID(submissionId);
            answer.setQuestionID(question.getQuestionID());
            answer.setSelectedAnswer(selectedAnswer);
            answer.setCorrect(isCorrect);
            answer.setPointsEarned(new java.math.BigDecimal(pointsEarned));

            saveStudentAnswer(answer);
        }

        // Update submission with score
        updateSubmissionScore(submissionId, totalScore, "GRADED");

        return totalScore;
    }

    /**
     * Update submission score and status
     */
    public boolean updateSubmissionScore(int submissionId, double score, String status) {
        String query = "UPDATE assignmentsubmission SET Score = ?, Status = ? WHERE SubmissionID = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setDouble(1, score);
            stmt.setString(2, status);
            stmt.setInt(3, submissionId);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Get submission by student and assignment
     */
    public AssignmentSubmission getSubmissionByStudentAndAssignment(int studentId, int assignmentId) {
        String query = "SELECT * FROM assignmentsubmission WHERE StudentID = ? AND AssignmentID = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, studentId);
            stmt.setInt(2, assignmentId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                AssignmentSubmission submission = new AssignmentSubmission();
                submission.setSubmissionID(rs.getInt("SubmissionID"));
                submission.setAssignmentID(rs.getInt("AssignmentID"));
                submission.setStudentID(rs.getInt("StudentID"));
                submission.setSubmissionDate(rs.getTimestamp("SubmissionDate"));
                submission.setEssayAnswer(rs.getString("EssayAnswer"));
                submission.setTimeTaken(rs.getInt("TimeTaken"));
                submission.setAutoGraded(rs.getBoolean("AutoGraded"));
                submission.setScore(rs.getDouble("Score"));
                submission.setStatus(rs.getString("Status"));
                submission.setGradedBy(rs.getInt("GradedBy"));
                submission.setGradedDate(rs.getTimestamp("GradedDate"));
                submission.setFeedback(rs.getString("Feedback"));
                return submission;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Update submission grade
     */
    public boolean updateSubmissionGrade(int submissionId, double score, String feedback, int gradedBy) {
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            // Update assignmentsubmission table
            String updateQuery = "UPDATE assignmentsubmission SET Score = ?, Feedback = ?, GradedBy = ?, GradedDate = ?, Status = 'GRADED' "
                    + "WHERE SubmissionID = ?";

            try (PreparedStatement stmt = conn.prepareStatement(updateQuery)) {
                stmt.setDouble(1, score);
                stmt.setString(2, feedback);
                stmt.setInt(3, gradedBy);
                stmt.setTimestamp(4, new Timestamp(System.currentTimeMillis()));
                stmt.setInt(5, submissionId);

                if (stmt.executeUpdate() == 0) {
                    conn.rollback();
                    return false;
                }
            }

            // Sync to grade table (INSERT or UPDATE)
            String syncQuery = "INSERT INTO grade (StudentID, AssignmentID, EnrollmentID, PointsEarned, Feedback, SubmissionDate, GradedDate, Status) "
                    +
                    "SELECT asub.StudentID, asub.AssignmentID, e.EnrollmentID, ?, ?, asub.SubmissionDate, ?, 'Graded' "
                    +
                    "FROM assignmentsubmission asub " +
                    "INNER JOIN assignment a ON asub.AssignmentID = a.AssignmentID " +
                    "INNER JOIN enrollment e ON asub.StudentID = e.StudentID AND a.CourseID = e.CourseID " +
                    "WHERE asub.SubmissionID = ? " +
                    "ON DUPLICATE KEY UPDATE PointsEarned = ?, Feedback = ?, GradedDate = ?, Status = 'Graded'";

            try (PreparedStatement stmt = conn.prepareStatement(syncQuery)) {
                stmt.setDouble(1, score);
                stmt.setString(2, feedback);
                stmt.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
                stmt.setInt(4, submissionId);
                stmt.setDouble(5, score);
                stmt.setString(6, feedback);
                stmt.setTimestamp(7, new Timestamp(System.currentTimeMillis()));

                stmt.executeUpdate();
            }

            conn.commit();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            return false;
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    /**
     * Get all submissions for an assignment (for instructor grading)
     */
    public List<AssignmentSubmission> getSubmissionsByAssignment(int assignmentId) {
        List<AssignmentSubmission> submissions = new ArrayList<>();
        String query = "SELECT asub.*, s.FirstName, s.LastName, s.Email " +
                "FROM assignmentsubmission asub " +
                "INNER JOIN student s ON asub.StudentID = s.StudentID " +
                "WHERE asub.AssignmentID = ? " +
                "ORDER BY asub.SubmittedAt DESC";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, assignmentId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                AssignmentSubmission submission = new AssignmentSubmission();
                submission.setSubmissionID(rs.getInt("SubmissionID"));
                submission.setAssignmentID(rs.getInt("AssignmentID"));
                submission.setStudentID(rs.getInt("StudentID"));
                submission.setSubmissionDate(rs.getTimestamp("SubmittedAt"));
                submission.setEssayAnswer(rs.getString("EssayContent"));
                submission.setTimeTaken(rs.getInt("TimeSpent"));
                submission.setScore(rs.getDouble("Score"));
                submission.setStatus(rs.getString("Status"));
                submission.setFeedback(rs.getString("Feedback"));
                submission.setStudentName(rs.getString("FirstName") + " " + rs.getString("LastName"));
                submission.setStudentEmail(rs.getString("Email"));
                submissions.add(submission);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return submissions;
    }

    /**
     * Get submission details with student answers for MCQ
     */
    public AssignmentSubmission getSubmissionWithAnswers(int submissionId) {
        AssignmentSubmission submission = null;
        String query = "SELECT asub.*, s.FirstName, s.LastName, s.Email " +
                "FROM assignmentsubmission asub " +
                "INNER JOIN student s ON asub.StudentID = s.StudentID " +
                "WHERE asub.SubmissionID = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, submissionId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                submission = new AssignmentSubmission();
                submission.setSubmissionID(rs.getInt("SubmissionID"));
                submission.setAssignmentID(rs.getInt("AssignmentID"));
                submission.setStudentID(rs.getInt("StudentID"));
                submission.setSubmissionDate(rs.getTimestamp("SubmittedAt"));
                submission.setEssayAnswer(rs.getString("EssayContent"));
                submission.setTimeTaken(rs.getInt("TimeSpent"));
                submission.setScore(rs.getDouble("Score"));
                submission.setStatus(rs.getString("Status"));
                submission.setFeedback(rs.getString("Feedback"));
                submission.setStudentName(rs.getString("FirstName") + " " + rs.getString("LastName"));
                submission.setStudentEmail(rs.getString("Email"));

                // Load student answers for MCQ
                List<StudentAnswer> answers = getStudentAnswers(submissionId);
                submission.setStudentAnswers(answers);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return submission;
    }

    /**
     * Get student answers for a submission
     */
    public List<StudentAnswer> getStudentAnswers(int submissionId) {
        List<StudentAnswer> answers = new ArrayList<>();
        String query = "SELECT sa.*, aq.QuestionText, aq.CorrectAnswer " +
                "FROM studentanswer sa " +
                "INNER JOIN assignmentquestion aq ON sa.QuestionID = aq.QuestionID " +
                "WHERE sa.SubmissionID = ? " +
                "ORDER BY aq.QuestionID";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, submissionId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                StudentAnswer answer = new StudentAnswer();
                answer.setAnswerID(rs.getInt("AnswerID"));
                answer.setSubmissionID(rs.getInt("SubmissionID"));
                answer.setQuestionID(rs.getInt("QuestionID"));
                answer.setSelectedAnswer(rs.getString("SelectedAnswer"));
                answer.setCorrect(rs.getBoolean("IsCorrect"));
                answer.setPointsEarned(rs.getBigDecimal("PointsEarned"));
                answer.setQuestionText(rs.getString("QuestionText"));
                answer.setCorrectAnswer(rs.getString("CorrectAnswer"));
                answers.add(answer);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return answers;
    }
}
