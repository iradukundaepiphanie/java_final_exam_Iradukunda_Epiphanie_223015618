package com.education.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 * Grade Entity Class
 */
public class Grade {
    private int gradeID;
    private int studentID;
    private int assignmentID;
    private int enrollmentID;
    private String studentName;
    private String assignmentTitle;
    private BigDecimal pointsEarned;
    private int maxPoints;
    private String feedback;
    private String submissionDate;
    private String gradedDate;
    private String status;
    private Timestamp createdAt;

    // Constructors
    public Grade() {
    }

    public Grade(int gradeID, int studentID, int assignmentID) {
        this.gradeID = gradeID;
        this.studentID = studentID;
        this.assignmentID = assignmentID;
    }

    // Getters and Setters
    public int getGradeID() {
        return gradeID;
    }

    public void setGradeID(int gradeID) {
        this.gradeID = gradeID;
    }

    public int getStudentID() {
        return studentID;
    }

    public void setStudentID(int studentID) {
        this.studentID = studentID;
    }

    public int getAssignmentID() {
        return assignmentID;
    }

    public void setAssignmentID(int assignmentID) {
        this.assignmentID = assignmentID;
    }

    public int getEnrollmentID() {
        return enrollmentID;
    }

    public void setEnrollmentID(int enrollmentID) {
        this.enrollmentID = enrollmentID;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public String getAssignmentTitle() {
        return assignmentTitle;
    }

    public void setAssignmentTitle(String assignmentTitle) {
        this.assignmentTitle = assignmentTitle;
    }

    public BigDecimal getPointsEarned() {
        return pointsEarned;
    }

    public void setPointsEarned(BigDecimal pointsEarned) {
        this.pointsEarned = pointsEarned;
    }

    public int getMaxPoints() {
        return maxPoints;
    }

    public void setMaxPoints(int maxPoints) {
        this.maxPoints = maxPoints;
    }

    public String getFeedback() {
        return feedback;
    }

    public void setFeedback(String feedback) {
        this.feedback = feedback;
    }

    public String getSubmissionDate() {
        return submissionDate;
    }

    public void setSubmissionDate(String submissionDate) {
        this.submissionDate = submissionDate;
    }

    public String getGradedDate() {
        return gradedDate;
    }

    public void setGradedDate(String gradedDate) {
        this.gradedDate = gradedDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public double getPercentage() {
        if (maxPoints > 0 && pointsEarned != null) {
            return (pointsEarned.doubleValue() / maxPoints) * 100;
        }
        return 0.0;
    }
}
