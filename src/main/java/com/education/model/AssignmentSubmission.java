package com.education.model;

import java.util.Date;
import java.util.List;

/**
 * Model class representing a student's assignment submission
 */
public class AssignmentSubmission {
    private int submissionID;
    private int assignmentID;
    private int studentID;
    private Date submissionDate;
    private String essayAnswer; // For essay-type assignments
    private int timeTaken; // Time taken in seconds
    private boolean autoGraded;
    private double score;
    private String status; // SUBMITTED, GRADED, PENDING
    private int gradedBy; // Instructor ID
    private Date gradedDate;
    private String feedback;

    // Additional fields for display
    private String studentName;
    private String studentEmail;
    private String assignmentTitle;
    private String courseName;
    private double maxPoints;
    private String assignmentType;
    private List<StudentAnswer> studentAnswers; // For MCQ answers

    // Constructors
    public AssignmentSubmission() {
    }

    public AssignmentSubmission(int assignmentID, int studentID, String essayAnswer) {
        this.assignmentID = assignmentID;
        this.studentID = studentID;
        this.essayAnswer = essayAnswer;
        this.submissionDate = new Date();
        this.status = "SUBMITTED";
    }

    // Getters and Setters
    public int getSubmissionID() {
        return submissionID;
    }

    public void setSubmissionID(int submissionID) {
        this.submissionID = submissionID;
    }

    public int getAssignmentID() {
        return assignmentID;
    }

    public void setAssignmentID(int assignmentID) {
        this.assignmentID = assignmentID;
    }

    public int getStudentID() {
        return studentID;
    }

    public void setStudentID(int studentID) {
        this.studentID = studentID;
    }

    public Date getSubmissionDate() {
        return submissionDate;
    }

    public void setSubmissionDate(Date submissionDate) {
        this.submissionDate = submissionDate;
    }

    public String getEssayAnswer() {
        return essayAnswer;
    }

    public void setEssayAnswer(String essayAnswer) {
        this.essayAnswer = essayAnswer;
    }

    public int getTimeTaken() {
        return timeTaken;
    }

    public void setTimeTaken(int timeTaken) {
        this.timeTaken = timeTaken;
    }

    public boolean isAutoGraded() {
        return autoGraded;
    }

    public void setAutoGraded(boolean autoGraded) {
        this.autoGraded = autoGraded;
    }

    public double getScore() {
        return score;
    }

    public void setScore(double score) {
        this.score = score;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getGradedBy() {
        return gradedBy;
    }

    public void setGradedBy(int gradedBy) {
        this.gradedBy = gradedBy;
    }

    public Date getGradedDate() {
        return gradedDate;
    }

    public void setGradedDate(Date gradedDate) {
        this.gradedDate = gradedDate;
    }

    public String getFeedback() {
        return feedback;
    }

    public void setFeedback(String feedback) {
        this.feedback = feedback;
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

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public double getMaxPoints() {
        return maxPoints;
    }

    public void setMaxPoints(double maxPoints) {
        this.maxPoints = maxPoints;
    }

    public String getAssignmentType() {
        return assignmentType;
    }

    public void setAssignmentType(String assignmentType) {
        this.assignmentType = assignmentType;
    }

    public String getStudentEmail() {
        return studentEmail;
    }

    public void setStudentEmail(String studentEmail) {
        this.studentEmail = studentEmail;
    }

    public List<StudentAnswer> getStudentAnswers() {
        return studentAnswers;
    }

    public void setStudentAnswers(List<StudentAnswer> studentAnswers) {
        this.studentAnswers = studentAnswers;
    }

    @Override
    public String toString() {
        return "AssignmentSubmission{" +
                "submissionID=" + submissionID +
                ", assignmentID=" + assignmentID +
                ", studentID=" + studentID +
                ", status='" + status + '\'' +
                ", score=" + score +
                ", autoGraded=" + autoGraded +
                '}';
    }
}
