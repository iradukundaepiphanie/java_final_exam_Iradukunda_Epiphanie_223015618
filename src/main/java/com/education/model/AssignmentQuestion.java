package com.education.model;

import java.util.Date;

/**
 * Model class representing an assignment question for MCQ assignments
 */
public class AssignmentQuestion {
    private int questionID;
    private int assignmentID;
    private String questionText;
    private String optionA;
    private String optionB;
    private String optionC;
    private String optionD;
    private String correctAnswer; // A, B, C, or D
    private double points;
    private int questionOrder;
    private Date createdAt;

    // Constructors
    public AssignmentQuestion() {
    }

    public AssignmentQuestion(int assignmentID, String questionText, String optionA,
            String optionB, String optionC, String optionD,
            String correctAnswer, double points, int questionOrder) {
        this.assignmentID = assignmentID;
        this.questionText = questionText;
        this.optionA = optionA;
        this.optionB = optionB;
        this.optionC = optionC;
        this.optionD = optionD;
        this.correctAnswer = correctAnswer;
        this.points = points;
        this.questionOrder = questionOrder;
    }

    // Getters and Setters
    public int getQuestionID() {
        return questionID;
    }

    public void setQuestionID(int questionID) {
        this.questionID = questionID;
    }

    public int getAssignmentID() {
        return assignmentID;
    }

    public void setAssignmentID(int assignmentID) {
        this.assignmentID = assignmentID;
    }

    public String getQuestionText() {
        return questionText;
    }

    public void setQuestionText(String questionText) {
        this.questionText = questionText;
    }

    public String getOptionA() {
        return optionA;
    }

    public void setOptionA(String optionA) {
        this.optionA = optionA;
    }

    public String getOptionB() {
        return optionB;
    }

    public void setOptionB(String optionB) {
        this.optionB = optionB;
    }

    public String getOptionC() {
        return optionC;
    }

    public void setOptionC(String optionC) {
        this.optionC = optionC;
    }

    public String getOptionD() {
        return optionD;
    }

    public void setOptionD(String optionD) {
        this.optionD = optionD;
    }

    public String getCorrectAnswer() {
        return correctAnswer;
    }

    public void setCorrectAnswer(String correctAnswer) {
        this.correctAnswer = correctAnswer;
    }

    public double getPoints() {
        return points;
    }

    public void setPoints(double points) {
        this.points = points;
    }

    public int getQuestionOrder() {
        return questionOrder;
    }

    public void setQuestionOrder(int questionOrder) {
        this.questionOrder = questionOrder;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "AssignmentQuestion{" +
                "questionID=" + questionID +
                ", assignmentID=" + assignmentID +
                ", questionText='" + questionText + '\'' +
                ", correctAnswer='" + correctAnswer + '\'' +
                ", points=" + points +
                '}';
    }
}
