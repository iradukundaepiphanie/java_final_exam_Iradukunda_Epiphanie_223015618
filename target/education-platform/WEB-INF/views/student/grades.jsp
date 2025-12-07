<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Grades - Student</title>
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
        .grade-excellent { color: #28a745; font-weight: bold; }
        .grade-good { color: #17a2b8; font-weight: bold; }
        .grade-average { color: #ffc107; font-weight: bold; }
        .grade-poor { color: #dc3545; font-weight: bold; }
        .no-data { text-align: center; padding: 40px; color: #999; }
    </style>
</head>
<body>
    <nav class="navbar">
        <h1>📊 My Grades</h1>
        <div class="navbar-right">
            <a href="${pageContext.request.contextPath}/student/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/student/courses">Courses</a>
            <a href="${pageContext.request.contextPath}/student/assignments">Assignments</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </div>
    </nav>
    
    <div class="container">
        <div class="section">
            <h2>All Grades</h2>
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
                                <th>Submission Date</th>
                                <th>Graded Date</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="grade" items="${grades}">
                                <tr>
                                    <td><strong>${grade.assignmentTitle}</strong></td>
                                    <td>${grade.pointsEarned}</td>
                                    <td>${grade.maxPoints}</td>
                                    <td>
                                        <c:set var="percentage" value="${grade.percentage}" />
                                        <span class="${percentage >= 90 ? 'grade-excellent' : percentage >= 80 ? 'grade-good' : percentage >= 70 ? 'grade-average' : 'grade-poor'}">
                                            ${String.format("%.1f", percentage)}%
                                        </span>
                                    </td>
                                    <td>${grade.feedback}</td>
                                    <td>${grade.submissionDate}</td>
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
