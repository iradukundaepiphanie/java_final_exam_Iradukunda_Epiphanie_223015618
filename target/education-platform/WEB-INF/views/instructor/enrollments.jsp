<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Course Enrollments - Instructor</title>
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
            background: linear-gradient(180deg, #f093fb 0%, #f5576c 100%);
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
        
        .course-selector {
            margin-bottom: 30px;
        }
        
        .course-selector select {
            width: 100%;
            max-width: 400px;
            padding: 12px 15px;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            font-size: 14px;
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
        
        .badge-enrolled {
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
            <h2><i class="fas fa-chalkboard-teacher"></i> Instructor Portal</h2>
        </div>
        
        <a href="${pageContext.request.contextPath}/instructor/dashboard" class="menu-item">
            <i class="fas fa-home"></i>
            <span>Dashboard</span>
        </a>
        <a href="${pageContext.request.contextPath}/instructor/courses" class="menu-item">
            <i class="fas fa-book"></i>
            <span>My Courses</span>
        </a>
        <a href="${pageContext.request.contextPath}/instructor/assignments" class="menu-item">
            <i class="fas fa-tasks"></i>
            <span>Assignments</span>
        </a>
        <a href="${pageContext.request.contextPath}/logout" class="menu-item">
            <i class="fas fa-sign-out-alt"></i>
            <span>Logout</span>
        </a>
    </div>
    
    <div class="main-content">
        <div class="top-bar">
            <h1><i class="fas fa-users"></i> Course Enrollments</h1>
            <p style="color: #7f8c8d; margin-top: 5px;">View students enrolled in your courses</p>
        </div>
        
        <div class="section">
            <div class="course-selector">
                <label for="courseSelect"><strong>Select Course:</strong></label><br><br>
                <select id="courseSelect" onchange="window.location.href='${pageContext.request.contextPath}/instructor/enrollments?courseId=' + this.value">
                    <option value="">-- Select a course --</option>
                    <c:forEach var="c" items="${courses}">
                        <option value="${c.courseID}" ${param.courseId == c.courseID ? 'selected' : ''}>
                            ${c.courseCode} - ${c.courseName}
                        </option>
                    </c:forEach>
                </select>
            </div>
            
            <c:if test="${not empty enrollments}">
                <h3>Enrolled Students (${enrollments.size()})</h3><br>
                <table>
                    <thead>
                        <tr>
                            <th>Student ID</th>
                            <th>Student Name</th>
                            <th>Enrollment Date</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="enrollment" items="${enrollments}">
                            <tr>
                                <td>${enrollment.studentID}</td>
                                <td><strong>${enrollment.studentName}</strong></td>
                                <td>${enrollment.enrollmentDate}</td>
                                <td><span class="badge badge-enrolled">${enrollment.status}</span></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
            
            <c:if test="${empty enrollments && not empty param.courseId}">
                <div class="no-data">
                    <i class="fas fa-users"></i>
                    <p>No students enrolled in this course yet.</p>
                </div>
            </c:if>
            
            <c:if test="${empty param.courseId}">
                <div class="no-data">
                    <i class="fas fa-info-circle"></i>
                    <p>Please select a course to view enrollments.</p>
                </div>
            </c:if>
        </div>
    </div>
</body>
</html>
