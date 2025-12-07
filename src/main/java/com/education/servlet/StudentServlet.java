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
}
