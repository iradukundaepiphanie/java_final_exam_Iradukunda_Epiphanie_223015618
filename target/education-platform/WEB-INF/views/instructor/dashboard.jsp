<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Instructor Dashboard</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f7fa; }
        .navbar { background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%); color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; }
        .navbar h1 { font-size: 24px; }
        .navbar-right { display: flex; gap: 20px; align-items: center; }
        .navbar-right a { color: white; text-decoration: none; padding: 8px 15px; border-radius: 5px; transition: background 0.3s; }
        .navbar-right a:hover { background: rgba(255,255,255,0.2); }
        .container { max-width: 1200px; margin: 30px auto; padding: 0 20px; }
        .welcome-card { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); margin-bottom: 30px; }
        .welcome-card h2 { color: #333; margin-bottom: 10px; }
        .section { background: white; padding: 25px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); margin-bottom: 20px; }
        .section h3 { color: #333; margin-bottom: 20px; }
        table { width: 100%; border-collapse: collapse; }
        table th, table td { padding: 12px; text-align: left; border-bottom: 1px solid #f0f0f0; }
        table th { background: #f8f9fa; color: #333; font-weight: 600; }
        table tr:hover { background: #f8f9fa; }
        .badge-active { background: #d4edda; color: #155724; padding: 5px 10px; border-radius: 20px; font-size: 12px; }
        .no-data { text-align: center; padding: 40px; color: #999; }
    </style>
</head>
<body>
    <nav class="navbar">
        <h1>👨‍🏫 Instructor Dashboard</h1>
        <div class="navbar-right">
            <span>Welcome, ${sessionScope.user.firstName}!</span>
            <a href="${pageContext.request.contextPath}/instructor/courses">My Courses</a>
            <a href="${pageContext.request.contextPath}/instructor/assignments">Assignments</a>
            <a href="${pageContext.request.contextPath}/instructor/enrollments">Enrollments</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </div>
    </nav>
    
    <div class="container">
        <div class="welcome-card">
            <h2>Welcome back, ${sessionScope.user.firstName} ${sessionScope.user.lastName}!</h2>
            <p>Department: ${sessionScope.user.department} | Specialization: ${sessionScope.user.specialization}</p>
        </div>
        
        <div class="section">
            <h3>My Courses (${courses.size()} courses)</h3>
            <c:choose>
                <c:when test="${not empty courses}">
                    <table>
                        <thead>
                            <tr>
                                <th>Course Code</th>
                                <th>Course Name</th>
                                <th>Credits</th>
                                <th>Start Date</th>
                                <th>End Date</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="course" items="${courses}">
                                <tr>
                                    <td><strong>${course.courseCode}</strong></td>
                                    <td>${course.courseName}</td>
                                    <td>${course.credits}</td>
                                    <td>${course.startDate}</td>
                                    <td>${course.endDate}</td>
                                    <td><span class="badge-active">${course.status}</span></td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/instructor/assignments?courseId=${course.courseID}">View Assignments</a> |
                                        <a href="${pageContext.request.contextPath}/instructor/enrollments?courseId=${course.courseID}">View Students</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="no-data">No courses assigned</div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>
