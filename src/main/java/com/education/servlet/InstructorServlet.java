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
            } else if (pathInfo.equals("/grade-assignment")) {
                gradeAssignment(request, response);
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
        request.setAttribute("courses", courses);

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

        boolean success = assignmentDAO.createAssignment(assignment);

        if (success) {
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
}
