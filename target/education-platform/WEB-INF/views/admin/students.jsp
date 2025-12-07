<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Students</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f7fa; }
        .navbar { background: linear-gradient(135deg, #fa709a 0%, #fee140 100%); color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; }
        .navbar h1 { font-size: 24px; }
        .navbar-right { display: flex; gap: 20px; align-items: center; }
        .navbar-right a { color: white; text-decoration: none; padding: 8px 15px; border-radius: 5px; }
        .navbar-right a:hover { background: rgba(255,255,255,0.2); }
        .container { max-width: 1200px; margin: 30px auto; padding: 0 20px; }
        .section { background: white; padding: 25px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .section h2 { color: #333; margin-bottom: 20px; }
        table { width: 100%; border-collapse: collapse; }
        table th, table td { padding: 12px; text-align: left; border-bottom: 1px solid #f0f0f0; }
        table th { background: #f8f9fa; color: #333; font-weight: 600; }
        table tr:hover { background: #f8f9fa; }
        .btn-delete { background: #dc3545; color: white; padding: 6px 12px; border: none; border-radius: 4px; cursor: pointer; }
        .btn-delete:hover { background: #c82333; }
        .btn-add { background: #28a745; color: white; padding: 10px 20px; border: none; border-radius: 5px; text-decoration: none; display: inline-block; margin-bottom: 20px; }
        .btn-add:hover { background: #218838; }
    </style>
</head>
<body>
    <nav class="navbar">
        <h1>👨‍🎓 Manage Students</h1>
        <div class="navbar-right">
            <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin/instructors">Instructors</a>
            <a href="${pageContext.request.contextPath}/admin/courses">Courses</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </div>
    </nav>
    
    <div class="container">
        <div class="section">
            <a href="${pageContext.request.contextPath}/admin/add-student" class="btn-add">➕ Add New Student</a>
            <h2>All Students (${students.size()})</h2>
            <c:choose>
                <c:when test="${not empty students}">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Date of Birth</th>
                                <th>Enrollment Date</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="student" items="${students}">
                                <tr>
                                    <td>${student.studentID}</td>
                                    <td><strong>${student.fullName}</strong></td>
                                    <td>${student.email}</td>
                                    <td>${student.phone}</td>
                                    <td>${student.dateOfBirth}</td>
                                    <td>${student.enrollmentDate}</td>
                                    <td>${student.status}</td>
                                    <td>
                                        <form action="${pageContext.request.contextPath}/admin/delete-student" method="post" style="display:inline;">
                                            <input type="hidden" name="studentId" value="${student.studentID}">
                                            <button type="submit" class="btn-delete" onclick="return confirm('Delete this student?')">Delete</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <p style="text-align:center; padding:40px; color:#999;">No students found</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>
