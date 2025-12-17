<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Courses - Student</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f0f2f5;
            display: flex;
            min-height: 100vh;
        }
        
        .sidebar {
            width: 260px;
            background: linear-gradient(180deg, #0D47A1 0%, #1565C0 100%);
            color: white;
            position: fixed;
            height: 100vh;
            overflow-y: auto;
            box-shadow: 2px 0 10px rgba(0,0,0,0.1);
        }
        
        .sidebar-header {
            padding: 25px 20px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }
        
        .sidebar-header h2 {
            font-size: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .menu-item {
            padding: 14px 20px;
            display: flex;
            align-items: center;
            gap: 12px;
            color: white;
            text-decoration: none;
            transition: all 0.3s;
            border-left: 3px solid transparent;
        }
        
        .menu-item:hover {
            background: rgba(255,255,255,0.15);
            border-left-color: white;
        }
        
        .menu-item.active {
            background: rgba(255,255,255,0.2);
            border-left-color: #ffd700;
        }
        
        .menu-item i { width: 20px; }
        
        .main-content {
            margin-left: 260px;
            flex: 1;
            padding: 30px;
        }
        
        .top-bar {
            background: white;
            padding: 25px 30px;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 30px;
        }
        
        .top-bar h1 {
            font-size: 28px;
            color: #2c3e50;
            margin-bottom: 8px;
        }
        
        .section {
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
        }
        
        table th {
            background: #f8f9fa;
            padding: 15px;
            text-align: left;
            font-weight: 600;
            color: #2c3e50;
            border-bottom: 2px solid #e9ecef;
        }
        
        table td {
            padding: 15px;
            border-bottom: 1px solid #e9ecef;
        }
        
        table tr:hover {
            background: #f8f9fa;
        }
        
        .badge {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }
        
        .badge-active {
            background: #d4edda;
            color: #155724;
        }
        
        .no-data {
            text-align: center;
            padding: 60px 20px;
            color: #7f8c8d;
        }
        
        .no-data i {
            font-size: 64px;
            margin-bottom: 20px;
            opacity: 0.3;
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="sidebar-header">
            <h2><i class="fas fa-graduation-cap"></i> Student Portal</h2>
        </div>
        
        <a href="${pageContext.request.contextPath}/student/dashboard" class="menu-item">
            <i class="fas fa-home"></i>
            <span>Dashboard</span>
        </a>
        <a href="${pageContext.request.contextPath}/student/courses" class="menu-item active">
            <i class="fas fa-book"></i>
            <span>My Courses</span>
        </a>
        <a href="${pageContext.request.contextPath}/student/enroll" class="menu-item">
            <i class="fas fa-plus-circle"></i>
            <span>Enroll in Course</span>
        </a>
        <a href="${pageContext.request.contextPath}/student/assignments" class="menu-item">
            <i class="fas fa-tasks"></i>
            <span>Assignments</span>
        </a>
        <a href="${pageContext.request.contextPath}/student/grades" class="menu-item">
            <i class="fas fa-chart-line"></i>
            <span>Grades</span>
        </a>
        <a href="${pageContext.request.contextPath}/logout" class="menu-item">
            <i class="fas fa-sign-out-alt"></i>
            <span>Logout</span>
        </a>
    </div>
    
    <div class="main-content">
        <div class="top-bar">
            <h1><i class="fas fa-book"></i> My Courses</h1>
            <p style="color: #7f8c8d; margin-top: 5px;">View your enrolled courses</p>
        </div>
        
        <div class="section">
            <h2 style="margin-bottom: 25px;">Enrolled Courses (${courses.size()})</h2>
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
                                    <td><span class="badge badge-active">Active</span></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="no-data">
                        <i class="fas fa-book"></i>
                        <p>You are not enrolled in any courses yet.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>

