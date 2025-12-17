package com.education.servlet;

import com.education.dao.*;
import com.education.model.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * Servlet for handling student operations
 */
@WebServlet("/student/*")
public class StudentServlet extends HttpServlet {

    private CourseDAO courseDAO = new CourseDAO();
    private AssignmentDAO assignmentDAO = new AssignmentDAO();
    private GradeDAO gradeDAO = new GradeDAO();
    private EnrollmentDAO enrollmentDAO = new EnrollmentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || !"student".equals(session.getAttribute("userType"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String pathInfo = request.getPathInfo();
        int studentId = (Integer) session.getAttribute("userId");

        try {
            if (pathInfo == null || pathInfo.equals("/") || pathInfo.equals("/dashboard")) {
                showDashboard(request, response, studentId);
            } else if (pathInfo.equals("/courses")) {
                showCourses(request, response, studentId);
            } else if (pathInfo.equals("/assignments")) {
                showAssignments(request, response, studentId);
            } else if (pathInfo.equals("/grades")) {
                showGrades(request, response, studentId);
            } else if (pathInfo.equals("/enroll")) {
                showEnrollCourses(request, response, studentId);
            } else if (pathInfo.equals("/take-assignment")) {
                showTakeAssignment(request, response, studentId);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred");
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || !"student".equals(session.getAttribute("userType"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String pathInfo = request.getPathInfo();
        int studentId = (Integer) session.getAttribute("userId");

        try {
            if (pathInfo.equals("/enroll")) {
                handleEnrollment(request, response, studentId);
            } else if (pathInfo.equals("/submit-assignment")) {
                submitAssignment(request, response, studentId);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred");
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        }
    }

    private void showDashboard(HttpServletRequest request, HttpServletResponse response, int studentId)
            throws ServletException, IOException {

        List<Course> courses = courseDAO.getCoursesByStudent(studentId);
        List<Assignment> assignments = assignmentDAO.getAssignmentsByStudent(studentId);
        List<Grade> grades = gradeDAO.getGradesByStudent(studentId);

        request.setAttribute("courses", courses);
        request.setAttribute("assignments", assignments);
        request.setAttribute("grades", grades);

        request.getRequestDispatcher("/WEB-INF/views/student/dashboard.jsp").forward(request, response);
    }

    private void showCourses(HttpServletRequest request, HttpServletResponse response, int studentId)
            throws ServletException, IOException {

        List<Course> courses = courseDAO.getCoursesByStudent(studentId);
        request.setAttribute("courses", courses);

        request.getRequestDispatcher("/WEB-INF/views/student/courses.jsp").forward(request, response);
    }

    private void showAssignments(HttpServletRequest request, HttpServletResponse response, int studentId)
            throws ServletException, IOException {

        List<Assignment> assignments = assignmentDAO.getAssignmentsByStudent(studentId);
        request.setAttribute("assignments", assignments);

        request.getRequestDispatcher("/WEB-INF/views/student/assignments.jsp").forward(request, response);
    }

    private void showGrades(HttpServletRequest request, HttpServletResponse response, int studentId)
            throws ServletException, IOException {

        List<Grade> grades = gradeDAO.getGradesByStudent(studentId);
        request.setAttribute("grades", grades);

        request.getRequestDispatcher("/WEB-INF/views/student/grades.jsp").forward(request, response);
    }

    private void showEnrollCourses(HttpServletRequest request, HttpServletResponse response, int studentId)
            throws ServletException, IOException {

        List<Course> enrolledCourses = courseDAO.getCoursesByStudent(studentId);
        List<Course> allCourses = courseDAO.getAllCourses();

        // Filter out courses the student is already enrolled in and only show active
        // courses
        List<Course> availableCourses = new java.util.ArrayList<>();
        for (Course course : allCourses) {
            boolean isEnrolled = false;
            for (Course enrolled : enrolledCourses) {
                if (enrolled.getCourseID() == course.getCourseID()) {
                    isEnrolled = true;
                    break;
                }
            }
            if (!isEnrolled && "Active".equals(course.getStatus())) {
                availableCourses.add(course);
            }
        }

        request.setAttribute("availableCourses", availableCourses);
        request.getRequestDispatcher("/WEB-INF/views/student/enroll-course.jsp").forward(request, response);
    }

    private void handleEnrollment(HttpServletRequest request, HttpServletResponse response, int studentId)
            throws ServletException, IOException {

        String courseIdStr = request.getParameter("courseId");
        if (courseIdStr != null && !courseIdStr.trim().isEmpty()) {
            try {
                int courseId = Integer.parseInt(courseIdStr);

                // Check if student is already enrolled
                List<Course> enrolledCourses = courseDAO.getCoursesByStudent(studentId);
                boolean alreadyEnrolled = false;
                for (Course course : enrolledCourses) {
                    if (course.getCourseID() == courseId) {
                        alreadyEnrolled = true;
                        break;
                    }
                }

                if (!alreadyEnrolled) {
                    Enrollment enrollment = new Enrollment();
                    enrollment.setStudentID(studentId);
                    enrollment.setCourseID(courseId);

                    if (enrollmentDAO.createEnrollment(enrollment)) {
                        request.setAttribute("success", "Successfully enrolled in the course!");
                    } else {
                        request.setAttribute("error", "Failed to enroll in the course. Please try again.");
                    }
                } else {
                    request.setAttribute("error", "You are already enrolled in this course.");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid course ID.");
            }
        } else {
            request.setAttribute("error", "Course ID is required.");
        }

        // Show the enrollment page again with the message
        showEnrollCourses(request, response, studentId);
    }

    private void showTakeAssignment(HttpServletRequest request, HttpServletResponse response, int studentId)
            throws ServletException, IOException {

        String assignmentIdParam = request.getParameter("assignmentId");
        if (assignmentIdParam == null) {
            assignmentIdParam = request.getParameter("id");
        }
        if (assignmentIdParam != null) {
            try {
                int assignmentId = Integer.parseInt(assignmentIdParam);
                Assignment assignment = assignmentDAO.getAssignmentById(assignmentId);

                if (assignment != null) {
                    // Load assignment questions if it's MCQ type
                    if ("MCQ".equals(assignment.getAssignmentType())) {
                        List<AssignmentQuestion> questions = assignmentDAO.getAssignmentQuestions(assignmentId);
                        assignment.setQuestions(questions);
                    }

                    request.setAttribute("assignment", assignment);
                    request.getRequestDispatcher("/WEB-INF/views/student/take-assignment.jsp").forward(request,
                            response);
                } else {
                    request.setAttribute("error", "Assignment not found.");
                    response.sendRedirect(request.getContextPath() + "/student/assignments");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid assignment ID.");
                response.sendRedirect(request.getContextPath() + "/student/assignments");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/student/assignments");
        }
    }

    private void submitAssignment(HttpServletRequest request, HttpServletResponse response, int studentId)
            throws ServletException, IOException {

        String assignmentIdParam = request.getParameter("assignmentId");
        if (assignmentIdParam != null) {
            try {
                int assignmentId = Integer.parseInt(assignmentIdParam);
                Assignment assignment = assignmentDAO.getAssignmentById(assignmentId);

                if (assignment != null) {
                    AssignmentSubmissionDAO submissionDAO = new AssignmentSubmissionDAO();

                    // Check if already submitted
                    AssignmentSubmission existing = submissionDAO.getSubmissionByStudentAndAssignment(studentId,
                            assignmentId);
                    if (existing != null) {
                        request.getSession().setAttribute("error", "You have already submitted this assignment.");
                        response.sendRedirect(request.getContextPath() + "/student/assignments");
                        return;
                    }

                    // Create submission
                    AssignmentSubmission submission = new AssignmentSubmission();
                    submission.setAssignmentID(assignmentId);
                    submission.setStudentID(studentId);
                    submission.setSubmissionDate(new java.util.Date());
                    submission.setTimeTaken(0); //

                    if ("MCQ".equals(assignment.getAssignmentType())) {
                        // Handle MCQ submission with auto-grading
                        submission.setAutoGraded(true);
                        submission.setStatus("SUBMITTED");
                        submission.setScore(0.0);

                        int submissionId = submissionDAO.createSubmission(submission);

                        if (submissionId > 0) {
                            // Get student answers from form
                            java.util.Map<Integer, String> studentAnswers = new java.util.HashMap<>();
                            java.util.Map<String, String[]> params = request.getParameterMap();

                            for (String paramName : params.keySet()) {
                                if (paramName.startsWith("answer_")) {
                                    int questionId = Integer.parseInt(paramName.substring(7));
                                    String answer = request.getParameter(paramName);
                                    studentAnswers.put(questionId, answer);
                                }
                            }

                            // Load questions and auto-grade
                            List<AssignmentQuestion> questions = assignmentDAO.getAssignmentQuestions(assignmentId);
                            double score = submissionDAO.autoGradeSubmission(submissionId, studentAnswers, questions);

                            request.getSession().setAttribute("success", "Assignment submitted and graded! Score: "
                                    + score + "/" + assignment.getMaxPoints());
                        } else {
                            request.getSession().setAttribute("error", "Failed to submit assignment.");
                        }
                    } else {
                        // Handle ESSAY submission for manual grading
                        String essayAnswer = request.getParameter("essayAnswer");
                        submission.setEssayAnswer(essayAnswer);
                        submission.setAutoGraded(false);
                        submission.setStatus("PENDING");
                        submission.setScore(0.0);

                        int submissionId = submissionDAO.createSubmission(submission);

                        if (submissionId > 0) {
                            request.getSession().setAttribute("success",
                                    "Assignment submitted successfully! Waiting for instructor grading.");
                        } else {
                            request.getSession().setAttribute("error", "Failed to submit assignment.");
                        }
                    }

                    response.sendRedirect(request.getContextPath() + "/student/grades");
                } else {
                    request.setAttribute("error", "Assignment not found.");
                    response.sendRedirect(request.getContextPath() + "/student/assignments");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid assignment ID.");
                response.sendRedirect(request.getContextPath() + "/student/assignments");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/student/assignments");
        }
    }
}
