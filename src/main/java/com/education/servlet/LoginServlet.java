package com.education.servlet;

import com.education.dao.AdminDAO;
import com.education.dao.InstructorDAO;
import com.education.dao.StudentDAO;
import com.education.model.Admin;
import com.education.model.Instructor;
import com.education.model.Student;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * Servlet for handling user authentication
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private StudentDAO studentDAO = new StudentDAO();
    private InstructorDAO instructorDAO = new InstructorDAO();
    private AdminDAO adminDAO = new AdminDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward to login page
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String userType = request.getParameter("userType");

        HttpSession session = request.getSession();

        try {
            if ("student".equals(userType)) {
                Student student = studentDAO.login(email, password);
                if (student != null) {
                    session.setAttribute("user", student);
                    session.setAttribute("userType", "student");
                    session.setAttribute("userId", student.getStudentID());
                    response.sendRedirect(request.getContextPath() + "/student/dashboard");
                    return;
                }
            } else if ("instructor".equals(userType)) {
                Instructor instructor = instructorDAO.login(email, password);
                if (instructor != null) {
                    session.setAttribute("user", instructor);
                    session.setAttribute("userType", "instructor");
                    session.setAttribute("userId", instructor.getInstructorID());
                    response.sendRedirect(request.getContextPath() + "/instructor/dashboard");
                    return;
                }
            } else if ("admin".equals(userType)) {
                Admin admin = adminDAO.login(email, password);
                if (admin != null) {
                    session.setAttribute("user", admin);
                    session.setAttribute("userType", "admin");
                    session.setAttribute("userId", admin.getAdminID());
                    response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                    return;
                }
            }

            // Login failed
            request.setAttribute("error", "Invalid email or password");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred during login");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        }
    }
}
