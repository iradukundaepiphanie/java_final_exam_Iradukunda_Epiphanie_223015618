<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
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

        .menu-item i {
            width: 20px;
        }

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

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            color: white;
        }

        .stat-card:nth-child(1) .stat-icon { background: linear-gradient(135deg, #ff6b6b, #ee5a52); }
        .stat-card:nth-child(2) .stat-icon { background: linear-gradient(135deg, #4ecdc4, #44a08d); }
        .stat-card:nth-child(3) .stat-icon { background: linear-gradient(135deg, #45b7d1, #96c93d); }
        .stat-card:nth-child(4) .stat-icon { background: linear-gradient(135deg, #f9ca24, #f0932b); }

        .stat-info h3 {
            font-size: 32px;
            color: #2c3e50;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .stat-info p {
            color: #7f8c8d;
            font-size: 14px;
        }

        .section {
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .section h2 {
            margin-bottom: 20px;
            color: #2c3e50;
            font-size: 24px;
        }

        .recent-students {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
        }

        .student-card {
            border: 1px solid #e9ecef;
            border-radius: 10px;
            padding: 20px;
            transition: box-shadow 0.3s;
        }

        .student-card:hover {
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .student-name {
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 10px;
        }

        .student-detail {
            display: flex;
            justify-content: space-between;
            margin-bottom: 5px;
            font-size: 14px;
        }

        .student-detail span:first-child {
            color: #7f8c8d;
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
            <h2><i class="fas fa-graduation-cap"></i> Admin Portal</h2>
        </div>

        <a href="${pageContext.request.contextPath}/admin/dashboard" class="menu-item active">
            <i class="fas fa-home"></i>
            <span>Dashboard</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/students" class="menu-item">
            <i class="fas fa-user-graduate"></i>
            <span>Students</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/instructors" class="menu-item">
            <i class="fas fa-chalkboard-teacher"></i>
            <span>Instructors</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/courses" class="menu-item">
            <i class="fas fa-book"></i>
            <span>Courses</span>
        </a>
        <a href="${pageContext.request.contextPath}/logout" class="menu-item" style="margin-top: auto;">
            <i class="fas fa-sign-out-alt"></i>
            <span>Logout</span>
        </a>
    </div>

    <div class="main-content">
        <div class="top-bar">
            <h1><i class="fas fa-home"></i> Dashboard</h1>
            <p style="color: #7f8c8d; margin-top: 5px;">Monitor and manage your educational institution</p>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-user-graduate"></i>
                </div>
                <div class="stat-info">
                    <h3>${studentCount}</h3>
                    <p>Total Students</p>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-book"></i>
                </div>
                <div class="stat-info">
                    <h3>${courseCount}</h3>
                    <p>Total Courses</p>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-chalkboard-teacher"></i>
                </div>
                <div class="stat-info">
                    <h3>${instructorCount}</h3>
                    <p>Total Instructors</p>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-tasks"></i>
                </div>
                <div class="stat-info">
                    <h3>${activeAssignments}</h3>
                    <p>Active Assignments</p>
                </div>
            </div>
        </div>

        <div class="section">
            <h2>Recent Students</h2>
            <c:choose>
                <c:when test="${not empty recentStudents}">
                    <div class="recent-students">
                        <c:forEach var="student" items="${recentStudents}">
                            <div class="student-card">
                                <div class="student-name">${student.firstName} ${student.lastName}</div>
                                <div class="student-detail">
                                    <span>Student ID:</span>
                                    <span>${student.studentID}</span>
                                </div>
                                <div class="student-detail">
                                    <span>Email:</span>
                                    <span>${student.email}</span>
                                </div>
                                <div class="student-detail">
                                    <span>Enrollment Date:</span>
                                    <span>${student.enrollmentDate}</span>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="no-data">
                        <i class="fas fa-user-graduate"></i>
                        <p>No students enrolled yet.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>
