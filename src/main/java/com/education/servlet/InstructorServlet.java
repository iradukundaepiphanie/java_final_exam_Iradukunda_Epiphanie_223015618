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
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

/**
 * Servlet for handling instructor operations
 */
@WebServlet("/instructor/*")
public class InstructorServlet extends HttpServlet {

    private CourseDAO courseDAO = new CourseDAO();
    private AssignmentDAO assignmentDAO = new AssignmentDAO();
    private GradeDAO gradeDAO = new GradeDAO();
    private EnrollmentDAO enrollmentDAO = new EnrollmentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || !"instructor".equals(session.getAttribute("userType"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String pathInfo = request.getPathInfo();
        int instructorId = (Integer) session.getAttribute("userId");

        try {
            if (pathInfo == null || pathInfo.equals("/") || pathInfo.equals("/dashboard")) {
                showDashboard(request, response, instructorId);
            } else if (pathInfo.equals("/courses")) {
                showCourses(request, response, instructorId);
            } else if (pathInfo.equals("/assignments")) {
                showAssignments(request, response, instructorId);
            } else if (pathInfo.equals("/grade-assignment")) {
                showGradeAssignmentForm(request, response);
            } else if (pathInfo.equals("/enrollments")) {
                showEnrollments(request, response, instructorId);
            } else if (pathInfo.equals("/create-assignment")) {
                showCreateAssignmentForm(request, response, instructorId);
            } else if (pathInfo.equals("/my-assignments")) {
                showMyAssignments(request, response, instructorId);
            } else if (pathInfo.equals("/grade-submissions")) {
                showGradeSubmissions(request, response, instructorId);
            } else if (pathInfo.equals("/view-submissions")) {
                showAssignmentSubmissions(request, response);
            } else if (pathInfo.equals("/grade-submission")) {
                showGradeSubmissionForm(request, response);
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
        if (session == null || !"instructor".equals(session.getAttribute("userType"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String pathInfo = request.getPathInfo();

        try {
            if (pathInfo.equals("/add-assignment")) {
                addAssignment(request, response);
            } else if (pathInfo.equals("/create-assignment")) {
                createAssignment(request, response);
            } else if (pathInfo.equals("/grade-assignment")) {
                gradeAssignment(request, response);
            } else if (pathInfo.equals("/submit-grade")) {
                submitGrade(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred");
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        }
    }

    private void showDashboard(HttpServletRequest request, HttpServletResponse response, int instructorId)
            throws ServletException, IOException {

        List<Course> courses = courseDAO.getCoursesByInstructor(instructorId);
        List<Assignment> assignments = assignmentDAO.getAssignmentsByInstructor(instructorId);

        request.setAttribute("courses", courses);
        request.setAttribute("assignments", assignments);

        request.getRequestDispatcher("/WEB-INF/views/instructor/dashboard.jsp").forward(request, response);
    }

    private void showCourses(HttpServletRequest request, HttpServletResponse response, int instructorId)
            throws ServletException, IOException {

        List<Course> courses = courseDAO.getCoursesByInstructor(instructorId);
        request.setAttribute("courses", courses);

        request.getRequestDispatcher("/WEB-INF/views/instructor/courses.jsp").forward(request, response);
    }

    private void showAssignments(HttpServletRequest request, HttpServletResponse response, int instructorId)
            throws ServletException, IOException {

        String courseIdParam = request.getParameter("courseId");
        if (courseIdParam != null) {
            int courseId = Integer.parseInt(courseIdParam);
            List<Assignment> assignments = assignmentDAO.getAssignmentsByCourse(courseId);
            Course course = courseDAO.getCourseById(courseId);
            request.setAttribute("assignments", assignments);
            request.setAttribute("course", course);
        }

        List<Course> courses = courseDAO.getCoursesByInstructor(instructorId);
        request.setAttribute("courses", courses);

        request.getRequestDispatcher("/WEB-INF/views/instructor/assignments.jsp").forward(request, response);
    }

    private void addAssignment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int courseId = Integer.parseInt(request.getParameter("courseId"));
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String dueDate = request.getParameter("dueDate");
        int maxPoints = Integer.parseInt(request.getParameter("maxPoints"));

        Assignment assignment = new Assignment();
        assignment.setCourseID(courseId);
        assignment.setTitle(title);
        assignment.setDescription(description);
        assignment.setDueDate(dueDate);
        assignment.setMaxPoints(maxPoints);
        assignment.setStatus("Active");

        int assignmentId = assignmentDAO.createAssignment(assignment);

        if (assignmentId > 0) {
            response.sendRedirect(request.getContextPath() + "/instructor/assignments?courseId=" + courseId);
        } else {
            request.setAttribute("error", "Failed to create assignment");
            doGet(request, response);
        }
    }

    private void showGradeAssignmentForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String assignmentIdParam = request.getParameter("assignmentId");
        if (assignmentIdParam != null) {
            int assignmentId = Integer.parseInt(assignmentIdParam);
            List<Grade> grades = gradeDAO.getGradesByAssignment(assignmentId);
            Assignment assignment = assignmentDAO.getAssignmentById(assignmentId);
            request.setAttribute("grades", grades);
            request.setAttribute("assignment", assignment);
        }

        request.getRequestDispatcher("/WEB-INF/views/instructor/grade-assignment.jsp").forward(request, response);
    }

    private void gradeAssignment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int gradeId = Integer.parseInt(request.getParameter("gradeId"));
        BigDecimal pointsEarned = new BigDecimal(request.getParameter("pointsEarned"));
        String feedback = request.getParameter("feedback");

        Grade grade = new Grade();
        grade.setGradeID(gradeId);
        grade.setPointsEarned(pointsEarned);
        grade.setFeedback(feedback);
        grade.setGradedDate(LocalDate.now().toString());

        boolean success = gradeDAO.gradeAssignment(grade);

        if (success) {
            int assignmentId = Integer.parseInt(request.getParameter("assignmentId"));
            response.sendRedirect(
                    request.getContextPath() + "/instructor/grade-assignment?assignmentId=" + assignmentId);
        } else {
            request.setAttribute("error", "Failed to grade assignment");
            doGet(request, response);
        }
    }

    private void showEnrollments(HttpServletRequest request, HttpServletResponse response, int instructorId)
            throws ServletException, IOException {

        String courseIdParam = request.getParameter("courseId");
        if (courseIdParam != null) {
            int courseId = Integer.parseInt(courseIdParam);
            List<Enrollment> enrollments = enrollmentDAO.getEnrollmentsByCourse(courseId);
            Course course = courseDAO.getCourseById(courseId);
            request.setAttribute("enrollments", enrollments);
            request.setAttribute("course", course);
        }

        List<Course> courses = courseDAO.getCoursesByInstructor(instructorId);
        request.setAttribute("courses", courses);

        request.getRequestDispatcher("/WEB-INF/views/instructor/enrollments.jsp").forward(request, response);
    }

    private void showCreateAssignmentForm(HttpServletRequest request, HttpServletResponse response, int instructorId)
            throws ServletException, IOException {

        List<Course> courses = courseDAO.getCoursesByInstructor(instructorId);
        request.setAttribute("courses", courses);

        // Pre-select course if courseId parameter is provided
        String courseIdParam = request.getParameter("courseId");
        if (courseIdParam != null) {
            try {
                int selectedCourseId = Integer.parseInt(courseIdParam);
                request.setAttribute("selectedCourseId", selectedCourseId);
            } catch (NumberFormatException e) {
                // Invalid courseId, ignore
            }
        }

        request.getRequestDispatcher("/WEB-INF/views/instructor/create-assignment.jsp").forward(request, response);
    }

    private void createAssignment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Get basic assignment data
            int courseId = Integer.parseInt(request.getParameter("courseId"));
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String assignmentType = request.getParameter("assignmentType");

            // Parse totalPoints with null check
            String totalPointsStr = request.getParameter("totalPoints");
            int totalPoints = (totalPointsStr != null && !totalPointsStr.isEmpty())
                    ? Integer.parseInt(totalPointsStr)
                    : 100; // default to 100 if not provided

            // Get due date
            String dueDateStr = request.getParameter("dueDate");
            String dueDate = null;
            if (dueDateStr != null && !dueDateStr.isEmpty()) {
                // Convert from datetime-local format (yyyy-MM-ddThh:mm) to date (yyyy-MM-dd)
                dueDate = dueDateStr.substring(0, 10);
            }

            // Get timing data
            boolean timed = "true".equals(request.getParameter("timed"));
            int timeLimit = 0;
            if (timed && request.getParameter("timeLimit") != null && !request.getParameter("timeLimit").isEmpty()) {
                timeLimit = Integer.parseInt(request.getParameter("timeLimit"));
            }

            // Get availability window
            String availableFromStr = request.getParameter("availableFrom");
            String availableUntilStr = request.getParameter("availableUntil");

            java.util.Date availableFrom = null;
            java.util.Date availableUntil = null;

            if (availableFromStr != null && !availableFromStr.isEmpty()) {
                availableFrom = java.sql.Timestamp.valueOf(availableFromStr.replace("T", " ") + ":00");
            }
            if (availableUntilStr != null && !availableUntilStr.isEmpty()) {
                availableUntil = java.sql.Timestamp.valueOf(availableUntilStr.replace("T", " ") + ":00");
            }

            // Create assignment object
            Assignment assignment = new Assignment();
            assignment.setCourseID(courseId);
            assignment.setTitle(title);
            assignment.setDescription(description);
            assignment.setDueDate(dueDate);
            assignment.setAssignmentType(assignmentType);
            assignment.setMaxPoints(totalPoints);
            assignment.setStatus("Active");
            assignment.setTimed(timed);
            assignment.setTimeLimit(timeLimit);
            assignment.setAvailableFrom(availableFrom);
            assignment.setAvailableUntil(availableUntil);
            assignment.setAutoGraded("MCQ".equals(assignmentType));

            // Create assignment and get generated ID
            int assignmentId = assignmentDAO.createAssignment(assignment);

            if (assignmentId > 0 && "MCQ".equals(assignmentType)) {
                // Process MCQ questions
                java.util.Map<String, String[]> params = request.getParameterMap();

                // Collect question data from parameters like questions[1].questionText,
                // questions[1].points, etc.
                java.util.Map<Integer, AssignmentQuestion> questionsMap = new java.util.HashMap<>();

                for (String paramName : params.keySet()) {
                    if (paramName.startsWith("questions[")) {
                        // Extract question number and field name
                        int startIdx = paramName.indexOf('[') + 1;
                        int endIdx = paramName.indexOf(']');
                        int questionNum = Integer.parseInt(paramName.substring(startIdx, endIdx));

                        String fieldName = paramName.substring(endIdx + 2); // Skip "]."

                        // Get or create question object
                        AssignmentQuestion question = questionsMap.computeIfAbsent(questionNum, k -> {
                            AssignmentQuestion q = new AssignmentQuestion();
                            q.setAssignmentID(assignmentId);
                            q.setQuestionOrder(questionNum);
                            return q;
                        });

                        // Set field value
                        String value = request.getParameter(paramName);
                        if (value != null && !value.trim().isEmpty()) {
                            switch (fieldName) {
                                case "questionText":
                                    question.setQuestionText(value);
                                    break;
                                case "points":
                                    question.setPoints(Integer.parseInt(value));
                                    break;
                                case "optionA":
                                    question.setOptionA(value);
                                    break;
                                case "optionB":
                                    question.setOptionB(value);
                                    break;
                                case "optionC":
                                    question.setOptionC(value);
                                    break;
                                case "optionD":
                                    question.setOptionD(value);
                                    break;
                                case "correctAnswer":
                                    question.setCorrectAnswer(value);
                                    break;
                            }
                        }
                    }
                }

                // Save all questions
                for (AssignmentQuestion question : questionsMap.values()) {
                    if (question.getQuestionText() != null && !question.getQuestionText().isEmpty()) {
                        assignmentDAO.createAssignmentQuestion(question);
                    }
                }
            }

            if (assignmentId > 0) {
                response.sendRedirect(request.getContextPath() + "/instructor/my-assignments?success=created");
            } else {
                request.setAttribute("error", "Failed to create assignment");
                showCreateAssignmentForm(request, response, (Integer) request.getSession().getAttribute("userId"));
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error creating assignment: " + e.getMessage());
            showCreateAssignmentForm(request, response, (Integer) request.getSession().getAttribute("userId"));
        }
    }

    private void showGradeSubmissions(HttpServletRequest request, HttpServletResponse response, int instructorId)
            throws ServletException, IOException {

        List<Assignment> assignments = assignmentDAO.getAssignmentsByInstructor(instructorId);
        request.setAttribute("assignments", assignments);

        request.getRequestDispatcher("/WEB-INF/views/instructor/grade-submissions.jsp").forward(request, response);
    }

    private void showAssignmentSubmissions(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String assignmentIdParam = request.getParameter("assignmentId");
        if (assignmentIdParam != null) {
            int assignmentId = Integer.parseInt(assignmentIdParam);
            Assignment assignment = assignmentDAO.getAssignmentById(assignmentId);
            AssignmentSubmissionDAO submissionDAO = new AssignmentSubmissionDAO();
            List<AssignmentSubmission> submissions = submissionDAO.getSubmissionsByAssignment(assignmentId);

            request.setAttribute("assignment", assignment);
            request.setAttribute("submissions", submissions);
            request.getRequestDispatcher("/WEB-INF/views/instructor/view-submissions.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/instructor/grade-submissions");
        }
    }

    private void showGradeSubmissionForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String submissionIdParam = request.getParameter("submissionId");
        if (submissionIdParam != null) {
            int submissionId = Integer.parseInt(submissionIdParam);
            AssignmentSubmissionDAO submissionDAO = new AssignmentSubmissionDAO();
            AssignmentSubmission submission = submissionDAO.getSubmissionWithAnswers(submissionId);

            if (submission != null) {
                Assignment assignment = assignmentDAO.getAssignmentById(submission.getAssignmentID());
                submission.setAssignmentTitle(assignment.getTitle());
                submission.setMaxPoints(assignment.getMaxPoints());
                submission.setAssignmentType(assignment.getAssignmentType());

                request.setAttribute("submission", submission);
                request.setAttribute("assignment", assignment);
                request.getRequestDispatcher("/WEB-INF/views/instructor/grade-submission.jsp").forward(request,
                        response);
            } else {
                response.sendRedirect(request.getContextPath() + "/instructor/grade-submissions");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/instructor/grade-submissions");
        }
    }

    private void submitGrade(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int submissionId = Integer.parseInt(request.getParameter("submissionId"));
        double score = Double.parseDouble(request.getParameter("score"));
        String feedback = request.getParameter("feedback");
        int instructorId = (Integer) request.getSession().getAttribute("userId");

        AssignmentSubmissionDAO submissionDAO = new AssignmentSubmissionDAO();
        boolean success = submissionDAO.updateSubmissionGrade(submissionId, score, feedback, instructorId);

        if (success) {
            response.sendRedirect(request.getContextPath()
                    + "/instructor/view-submissions?assignmentId=" + request.getParameter("assignmentId")
                    + "&success=graded");
        } else {
            request.setAttribute("error", "Failed to submit grade");
            showGradeSubmissionForm(request, response);
        }
    }

    /**
     * Show all assignments created by this instructor
     */
    private void showMyAssignments(HttpServletRequest request, HttpServletResponse response, int instructorId)
            throws ServletException, IOException {

        AssignmentDAO assignmentDAO = new AssignmentDAO();
        List<Assignment> assignments = assignmentDAO.getAssignmentsByInstructor(instructorId);

        request.setAttribute("assignments", assignments);
        request.getRequestDispatcher("/WEB-INF/views/instructor/my-assignments.jsp").forward(request, response);
    }
}
