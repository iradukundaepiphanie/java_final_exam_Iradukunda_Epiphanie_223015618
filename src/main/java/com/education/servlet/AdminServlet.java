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
 * Servlet for handling admin operations
 */
@WebServlet("/admin/*")
public class AdminServlet extends HttpServlet {

    private StudentDAO studentDAO = new StudentDAO();
    private InstructorDAO instructorDAO = new InstructorDAO();
    private CourseDAO courseDAO = new CourseDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("userType"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String pathInfo = request.getPathInfo();

        try {
            if (pathInfo == null || pathInfo.equals("/") || pathInfo.equals("/dashboard")) {
                showDashboard(request, response);
            } else if (pathInfo.equals("/students")) {
                showStudents(request, response);
            } else if (pathInfo.equals("/instructors")) {
                showInstructors(request, response);
            } else if (pathInfo.equals("/courses")) {
                showCourses(request, response);
            } else if (pathInfo.equals("/add-student")) {
                request.getRequestDispatcher("/WEB-INF/views/admin/add-student.jsp").forward(request, response);
            } else if (pathInfo.equals("/add-instructor")) {
                request.getRequestDispatcher("/WEB-INF/views/admin/add-instructor.jsp").forward(request, response);
            } else if (pathInfo.equals("/add-course")) {
                List<Instructor> instructors = instructorDAO.getAllInstructors();
                request.setAttribute("instructors", instructors);
                request.getRequestDispatcher("/WEB-INF/views/admin/add-course.jsp").forward(request, response);
            } else if (pathInfo.equals("/edit-student")) {
                showEditStudent(request, response);
            } else if (pathInfo.equals("/edit-instructor")) {
                showEditInstructor(request, response);
            } else if (pathInfo.equals("/edit-course")) {
                showEditCourse(request, response);
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
        if (session == null || !"admin".equals(session.getAttribute("userType"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String pathInfo = request.getPathInfo();

        try {
            if (pathInfo.equals("/add-student")) {
                addStudent(request, response);
            } else if (pathInfo.equals("/add-instructor")) {
                addInstructor(request, response);
            } else if (pathInfo.equals("/add-course")) {
                addCourse(request, response);
            } else if (pathInfo.equals("/delete-student")) {
                deleteStudent(request, response);
            } else if (pathInfo.equals("/delete-instructor")) {
                deleteInstructor(request, response);
            } else if (pathInfo.equals("/delete-course")) {
                deleteCourse(request, response);
            } else if (pathInfo.equals("/edit-student")) {
                updateStudent(request, response);
            } else if (pathInfo.equals("/edit-instructor")) {
                updateInstructor(request, response);
            } else if (pathInfo.equals("/edit-course")) {
                updateCourse(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred");
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        }
    }

    private void showDashboard(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Student> students = studentDAO.getAllStudents();
        List<Instructor> instructors = instructorDAO.getAllInstructors();
        List<Course> courses = courseDAO.getAllCourses();

        request.setAttribute("studentCount", students.size());
        request.setAttribute("instructorCount", instructors.size());
        request.setAttribute("courseCount", courses.size());
        request.setAttribute("activeAssignments", 0); // Placeholder

        // Get recent students (last 5)
        List<Student> recentStudents = students.size() > 5 ? students.subList(students.size() - 5, students.size())
                : students;
        request.setAttribute("recentStudents", recentStudents);

        request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
    }

    private void showStudents(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Student> students = studentDAO.getAllStudents();
        request.setAttribute("students", students);

        request.getRequestDispatcher("/WEB-INF/views/admin/students.jsp").forward(request, response);
    }

    private void showInstructors(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Instructor> instructors = instructorDAO.getAllInstructors();
        request.setAttribute("instructors", instructors);

        request.getRequestDispatcher("/WEB-INF/views/admin/instructors.jsp").forward(request, response);
    }

    private void showCourses(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Course> courses = courseDAO.getAllCourses();
        request.setAttribute("courses", courses);

        request.getRequestDispatcher("/WEB-INF/views/admin/courses.jsp").forward(request, response);
    }

    private void addStudent(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Student student = new Student();
        student.setFirstName(request.getParameter("firstName"));
        student.setLastName(request.getParameter("lastName"));
        student.setEmail(request.getParameter("email"));
        student.setPassword(request.getParameter("password"));
        student.setPhone(request.getParameter("phone"));
        student.setDateOfBirth(request.getParameter("dateOfBirth"));
        student.setAddress(request.getParameter("address"));
        student.setStatus("Active");

        boolean success = studentDAO.createStudent(student);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/admin/students");
        } else {
            request.setAttribute("error", "Failed to add student");
            request.getRequestDispatcher("/WEB-INF/views/admin/add-student.jsp").forward(request, response);
        }
    }

    private void addInstructor(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Instructor instructor = new Instructor();
        instructor.setFirstName(request.getParameter("firstName"));
        instructor.setLastName(request.getParameter("lastName"));
        instructor.setEmail(request.getParameter("email"));
        instructor.setPassword(request.getParameter("password"));
        instructor.setPhone(request.getParameter("phone"));
        instructor.setDepartment(request.getParameter("department"));
        instructor.setSpecialization(request.getParameter("specialization"));
        instructor.setHireDate(request.getParameter("hireDate"));
        instructor.setStatus("Active");

        boolean success = instructorDAO.createInstructor(instructor);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/admin/instructors");
        } else {
            request.setAttribute("error", "Failed to add instructor");
            request.getRequestDispatcher("/WEB-INF/views/admin/add-instructor.jsp").forward(request, response);
        }
    }

    private void addCourse(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Course course = new Course();
        course.setCourseName(request.getParameter("courseName"));
        course.setCourseCode(request.getParameter("courseCode"));
        course.setDescription(request.getParameter("description"));
        course.setCredits(Integer.parseInt(request.getParameter("credits")));
        course.setInstructorID(Integer.parseInt(request.getParameter("instructorId")));
        course.setStartDate(request.getParameter("startDate"));
        course.setEndDate(request.getParameter("endDate"));
        course.setStatus("Active");

        boolean success = courseDAO.createCourse(course);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/admin/courses");
        } else {
            request.setAttribute("error", "Failed to add course");
            doGet(request, response);
        }
    }

    private void deleteStudent(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int studentId = Integer.parseInt(request.getParameter("studentId"));
        studentDAO.deleteStudent(studentId);
        response.sendRedirect(request.getContextPath() + "/admin/students");
    }

    private void deleteInstructor(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int instructorId = Integer.parseInt(request.getParameter("instructorId"));
        instructorDAO.deleteInstructor(instructorId);
        response.sendRedirect(request.getContextPath() + "/admin/instructors");
    }

    private void deleteCourse(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int courseId = Integer.parseInt(request.getParameter("courseId"));
        courseDAO.deleteCourse(courseId);
        response.sendRedirect(request.getContextPath() + "/admin/courses");
    }

    private void showEditStudent(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int studentId = Integer.parseInt(request.getParameter("id"));
        Student student = studentDAO.getStudentById(studentId);
        request.setAttribute("student", student);
        request.getRequestDispatcher("/WEB-INF/views/admin/edit-student.jsp").forward(request, response);
    }

    private void showEditInstructor(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int instructorId = Integer.parseInt(request.getParameter("id"));
        Instructor instructor = instructorDAO.getInstructorById(instructorId);
        request.setAttribute("instructor", instructor);
        request.getRequestDispatcher("/WEB-INF/views/admin/edit-instructor.jsp").forward(request, response);
    }

    private void showEditCourse(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int courseId = Integer.parseInt(request.getParameter("id"));
        Course course = courseDAO.getCourseById(courseId);
        List<Instructor> instructors = instructorDAO.getAllInstructors();
        request.setAttribute("course", course);
        request.setAttribute("instructors", instructors);
        request.getRequestDispatcher("/WEB-INF/views/admin/edit-course.jsp").forward(request, response);
    }

    private void updateStudent(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Student student = new Student();
        student.setStudentID(Integer.parseInt(request.getParameter("studentId")));
        student.setFirstName(request.getParameter("firstName"));
        student.setLastName(request.getParameter("lastName"));
        student.setEmail(request.getParameter("email"));
        student.setPhone(request.getParameter("phone"));
        student.setDateOfBirth(request.getParameter("dateOfBirth"));
        student.setAddress(request.getParameter("address"));
        student.setStatus(request.getParameter("status"));

        boolean success = studentDAO.updateStudent(student);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/admin/students");
        } else {
            request.setAttribute("error", "Failed to update student");
            showEditStudent(request, response);
        }
    }

    private void updateInstructor(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Instructor instructor = new Instructor();
        instructor.setInstructorID(Integer.parseInt(request.getParameter("instructorId")));
        instructor.setFirstName(request.getParameter("firstName"));
        instructor.setLastName(request.getParameter("lastName"));
        instructor.setEmail(request.getParameter("email"));
        instructor.setPhone(request.getParameter("phone"));
        instructor.setDepartment(request.getParameter("department"));
        instructor.setSpecialization(request.getParameter("specialization"));
        instructor.setStatus(request.getParameter("status"));

        boolean success = instructorDAO.updateInstructor(instructor);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/admin/instructors");
        } else {
            request.setAttribute("error", "Failed to update instructor");
            showEditInstructor(request, response);
        }
    }

    private void updateCourse(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Course course = new Course();
        course.setCourseID(Integer.parseInt(request.getParameter("courseId")));
        course.setCourseName(request.getParameter("courseName"));
        course.setCourseCode(request.getParameter("courseCode"));
        course.setDescription(request.getParameter("description"));
        course.setCredits(Integer.parseInt(request.getParameter("credits")));
        course.setInstructorID(Integer.parseInt(request.getParameter("instructorId")));
        course.setStatus(request.getParameter("status"));

        boolean success = courseDAO.updateCourse(course);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/admin/courses");
        } else {
            request.setAttribute("error", "Failed to update course");
            showEditCourse(request, response);
        }
    }
}
