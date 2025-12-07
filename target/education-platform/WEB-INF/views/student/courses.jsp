<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Courses - Student</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f7fa; }
        .navbar { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; }
        .navbar h1 { font-size: 24px; }
        .navbar-right { display: flex; gap: 20px; align-items: center; }
        .navbar-right a { color: white; text-decoration: none; padding: 8px 15px; border-radius: 5px; transition: background 0.3s; }
        .navbar-right a:hover { background: rgba(255,255,255,0.2); }
        .container { max-width: 1200px; margin: 30px auto; padding: 0 20px; }
        .section { background: white; padding: 25px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .section h2 { color: #333; margin-bottom: 20px; }
        table { width: 100%; border-collapse: collapse; }
        table th, table td { padding: 12px; text-align: left; border-bottom: 1px solid #f0f0f0; }
        table th { background: #f8f9fa; color: #333; font-weight: 600; }
        table tr:hover { background: #f8f9fa; }
        .badge { padding: 5px 10px; border-radius: 20px; font-size: 12px; font-weight: 600; }
        .badge-active { background: #d4edda; color: #155724; }
        .no-data { text-align: center; padding: 40px; color: #999; }
    </style>
</head>
<body>
    <nav class="navbar">
        <h1>📚 My Courses</h1>
        <div class="navbar-right">
            <a href="${pageContext.request.contextPath}/student/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/student/assignments">Assignments</a>
            <a href="${pageContext.request.contextPath}/student/grades">Grades</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </div>
    </nav>
    
    <div class="container">
        <div class="section">
            <h2>Enrolled Courses</h2>
            <c:choose>
                <c:when test="${not empty courses}">
                    <table>
                        <thead>
                            <tr>
                                <th>Course Code</th>
                                <th>Course Name</th>
                                <th>Description</th>
                                <th>Instructor</th>
                                <th>Credits</th>
                                <th>Start Date</th>
                                <th>End Date</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="course" items="${courses}">
                                <tr>
                                    <td><strong>${course.courseCode}</strong></td>
                                    <td><strong>${course.courseName}</strong></td>
                                    <td>${course.description}</td>
                                    <td>${course.instructorName}</td>
                                    <td>${course.credits}</td>
                                    <td>${course.startDate}</td>
                                    <td>${course.endDate}</td>
                                    <td><span class="badge badge-active">${course.status}</span></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="no-data">You are not enrolled in any courses yet</div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>
