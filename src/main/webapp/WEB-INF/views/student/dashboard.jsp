<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard - Education Platform</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f7fa;
        }
        
        .navbar {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .navbar h1 {
            font-size: 24px;
        }
        
        .navbar-right {
            display: flex;
            gap: 20px;
            align-items: center;
        }
        
        .navbar-right a {
            color: white;
            text-decoration: none;
            padding: 8px 15px;
            border-radius: 5px;
            transition: background 0.3s;
        }
        
        .navbar-right a:hover {
            background: rgba(255,255,255,0.2);
        }
        
        .container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 20px;
        }
        
        .welcome-card {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }
        
        .welcome-card h2 {
            color: #333;
            margin-bottom: 10px;
        }
        
        .welcome-card p {
            color: #666;
        }
        
        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .stat-card h3 {
            color: #667eea;
            font-size: 36px;
            margin-bottom: 10px;
        }
        
        .stat-card p {
            color: #666;
            font-size: 14px;
        }
        
        .section {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        
        .section h3 {
            color: #333;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #f0f0f0;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
        }
        
        table th,
        table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #f0f0f0;
        }
        
        table th {
            background: #f8f9fa;
            color: #333;
            font-weight: 600;
        }
        
        table tr:hover {
            background: #f8f9fa;
        }
        
        .badge {
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }
        
        .badge-active {
            background: #d4edda;
            color: #155724;
        }
        
        .badge-enrolled {
            background: #cce5ff;
            color: #004085;
        }
        
        .badge-graded {
            background: #d1ecf1;
            color: #0c5460;
        }
        
        .no-data {
            text-align: center;
            padding: 40px;
            color: #999;
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <h1>📚 Education Platform - Student</h1>
        <div class="navbar-right">
            <span>Welcome, ${sessionScope.user.firstName}!</span>
            <a href="${pageContext.request.contextPath}/student/courses">Courses</a>
            <a href="${pageContext.request.contextPath}/student/assignments">Assignments</a>
            <a href="${pageContext.request.contextPath}/student/grades">Grades</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </div>
    </nav>
    
    <div class="container">
        <div class="welcome-card">
            <h2>Welcome back, ${sessionScope.user.firstName} ${sessionScope.user.lastName}!</h2>
            <p>Here's an overview of your academic progress</p>
        </div>
        
        <div class="dashboard-grid">
            <div class="stat-card">
                <h3>${courses.size()}</h3>
                <p>Enrolled Courses</p>
            </div>
            <div class="stat-card">
                <h3>${assignments.size()}</h3>
                <p>Total Assignments</p>
            </div>
            <div class="stat-card">
                <h3>${grades.size()}</h3>
                <p>Graded Assignments</p>
            </div>
        </div>
        
        <div class="section">
            <h3>My Courses</h3>
            <c:choose>
                <c:when test="${not empty courses}">
                    <table>
                        <thead>
                            <tr>
                                <th>Course Code</th>
                                <th>Course Name</th>
                                <th>Instructor</th>
                                <th>Credits</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="course" items="${courses}">
                                <tr>
                                    <td><strong>${course.courseCode}</strong></td>
                                    <td>${course.courseName}</td>
                                    <td>${course.instructorName}</td>
                                    <td>${course.credits}</td>
                                    <td><span class="badge badge-active">${course.status}</span></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="no-data">No courses enrolled yet</div>
                </c:otherwise>
            </c:choose>
        </div>
        
        <div class="section">
            <h3>Recent Assignments</h3>
            <c:choose>
                <c:when test="${not empty assignments}">
                    <table>
                        <thead>
                            <tr>
                                <th>Assignment</th>
                                <th>Course</th>
                                <th>Due Date</th>
                                <th>Max Points</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="assignment" items="${assignments}" end="4">
                                <tr>
                                    <td><strong>${assignment.title}</strong></td>
                                    <td>${assignment.courseName}</td>
                                    <td>${assignment.dueDate}</td>
                                    <td>${assignment.maxPoints}</td>
                                    <td><span class="badge badge-active">${assignment.status}</span></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="no-data">No assignments available</div>
                </c:otherwise>
            </c:choose>
        </div>
        
        <div class="section">
            <h3>Recent Grades</h3>
            <c:choose>
                <c:when test="${not empty grades}">
                    <table>
                        <thead>
                            <tr>
                                <th>Assignment</th>
                                <th>Points Earned</th>
                                <th>Max Points</th>
                                <th>Percentage</th>
                                <th>Feedback</th>
                                <th>Graded Date</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="grade" items="${grades}" end="4">
                                <tr>
                                    <td><strong>${grade.assignmentTitle}</strong></td>
                                    <td>${grade.pointsEarned}</td>
                                    <td>${grade.maxPoints}</td>
                                    <td><strong>${String.format("%.1f", grade.percentage)}%</strong></td>
                                    <td>${grade.feedback}</td>
                                    <td>${grade.gradedDate}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="no-data">No grades available yet</div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>
