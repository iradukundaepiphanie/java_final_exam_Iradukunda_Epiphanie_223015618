package com.education.model;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

/**
 * Assignment Entity Class - Enhanced with MCQ and Auto-grading support
 */
public class Assignment {
    private int assignmentID;
    private int courseID;
    private String courseName;
    private String title;
    private String description;
    private String dueDate;
    private int maxPoints;
    private String status;
    private Timestamp createdAt;
    private boolean submitted;
    private int submissionCount; // Number of student submissions for this assignment

    // New fields for enhanced assignment features
    private String assignmentType; // MCQ or ESSAY
    private boolean timed;
    private int timeLimit; // in minutes
    private Date availableFrom;
    private Date availableUntil;
    private boolean autoGraded;

    // Related entities
    private List<AssignmentQuestion> questions;

    // Constructors
    public Assignment() {
    }

    public Assignment(int assignmentID, String title, String dueDate) {
        this.assignmentID = assignmentID;
        this.title = title;
        this.dueDate = dueDate;
    }

    // Getters and Setters
    public int getAssignmentID() {
        return assignmentID;
    }

    public void setAssignmentID(int assignmentID) {
        this.assignmentID = assignmentID;
    }

    public int getCourseID() {
        return courseID;
    }

    public void setCourseID(int courseID) {
        this.courseID = courseID;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDueDate() {
        return dueDate;
    }

    public void setDueDate(String dueDate) {
        this.dueDate = dueDate;
    }

    public int getMaxPoints() {
        return maxPoints;
    }

    public void setMaxPoints(int maxPoints) {
        this.maxPoints = maxPoints;
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

    public String getAssignmentType() {
        return assignmentType;
    }

    public void setAssignmentType(String assignmentType) {
        this.assignmentType = assignmentType;
    }

    public boolean isTimed() {
        return timed;
    }

    public void setTimed(boolean timed) {
        this.timed = timed;
    }

    public int getTimeLimit() {
        return timeLimit;
    }

    public void setTimeLimit(int timeLimit) {
        this.timeLimit = timeLimit;
    }

    public Date getAvailableFrom() {
        return availableFrom;
    }

    public void setAvailableFrom(Date availableFrom) {
        this.availableFrom = availableFrom;
    }

    public Date getAvailableUntil() {
        return availableUntil;
    }

    public void setAvailableUntil(Date availableUntil) {
        this.availableUntil = availableUntil;
    }

    public boolean isAutoGraded() {
        return autoGraded;
    }

    public void setAutoGraded(boolean autoGraded) {
        this.autoGraded = autoGraded;
    }

    public List<AssignmentQuestion> getQuestions() {
        return questions;
    }

    public void setQuestions(List<AssignmentQuestion> questions) {
        this.questions = questions;
    }

    public boolean isSubmitted() {
        return submitted;
    }

    public void setSubmitted(boolean submitted) {
        this.submitted = submitted;
    }

    public int getSubmissionCount() {
        return submissionCount;
    }

    public void setSubmissionCount(int submissionCount) {
        this.submissionCount = submissionCount;
    }
}
