package com.education.model;

/**
 * Model class representing a student's answer to an MCQ question
 */
public class SubmissionAnswer {
    private int answerID;
    private int submissionID;
    private int questionID;
    private String studentAnswer; // A, B, C, or D
    private boolean isCorrect;
    private double pointsEarned;

    // Additional fields for display
    private String questionText;
    private String correctAnswer;
    private double maxPoints;

    // Constructors
    public SubmissionAnswer() {
    }

    public SubmissionAnswer(int submissionID, int questionID, String studentAnswer) {
        this.submissionID = submissionID;
        this.questionID = questionID;
        this.studentAnswer = studentAnswer;
    }

    // Getters and Setters
    public int getAnswerID() {
        return answerID;
    }

    public void setAnswerID(int answerID) {
        this.answerID = answerID;
    }

    public int getSubmissionID() {
        return submissionID;
    }

    public void setSubmissionID(int submissionID) {
        this.submissionID = submissionID;
    }

    public int getQuestionID() {
        return questionID;
    }

    public void setQuestionID(int questionID) {
        this.questionID = questionID;
    }

    public String getStudentAnswer() {
        return studentAnswer;
    }

    public void setStudentAnswer(String studentAnswer) {
        this.studentAnswer = studentAnswer;
    }

    public boolean isCorrect() {
        return isCorrect;
    }

    public void setCorrect(boolean correct) {
        isCorrect = correct;
    }

    public double getPointsEarned() {
        return pointsEarned;
    }

    public void setPointsEarned(double pointsEarned) {
        this.pointsEarned = pointsEarned;
    }

    public String getQuestionText() {
        return questionText;
    }

    public void setQuestionText(String questionText) {
        this.questionText = questionText;
    }

    public String getCorrectAnswer() {
        return correctAnswer;
    }

    public void setCorrectAnswer(String correctAnswer) {
        this.correctAnswer = correctAnswer;
    }

    public double getMaxPoints() {
        return maxPoints;
    }

    public void setMaxPoints(double maxPoints) {
        this.maxPoints = maxPoints;
    }

    @Override
    public String toString() {
        return "SubmissionAnswer{" +
                "answerID=" + answerID +
                ", questionID=" + questionID +
                ", studentAnswer='" + studentAnswer + '\'' +
                ", isCorrect=" + isCorrect +
                ", pointsEarned=" + pointsEarned +
                '}';
    }
}
