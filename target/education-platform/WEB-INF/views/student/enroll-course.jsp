<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Enroll in Courses</title>
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
            background: linear-gradient(180deg, #a855f7 0%, #ec4899 100%);
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
        .course-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 25px;
        }
        .course-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            transition: transform 0.3s;
        }
        .course-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }
        .course-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 15px;
        }
        .course-code {
            background: linear-gradient(135deg, #a855f7, #ec4899);
            color: white;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }
        .course-card h3 {
            color: #2c3e50;
            margin-bottom: 10px;
            font-size: 20px;
        }
        .course-info {
            color: #7f8c8d;
            font-size: 14px;
            margin-bottom: 15px;
        }
        .course-info p {
            margin: 5px 0;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .btn-enroll {
            width: 100%;
            padding: 12px;
            background: linear-gradient(135deg, #a855f7, #ec4899);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }
        .btn-enroll:hover {
            transform: scale(1.02);
            box-shadow: 0 5px 15px rgba(168, 85, 247, 0.4);
        }
        .btn-enrolled {
            background: #95a5a6;
            cursor: not-allowed;
        }
        .no-courses {
            text-align: center;
            padding: 60px 20px;
            color: #7f8c8d;
        }
        .no-courses i {
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
            <i class="fas fa-home"></i><span>Dashboard</span>
        </a>
        <a href="${pageContext.request.contextPath}/student/courses" class="menu-item">
            <i class="fas fa-book"></i><span>My Courses</span>
        </a>
        <a href="${pageContext.request.contextPath}/student/enroll" class="menu-item active">
            <i class="fas fa-plus-circle"></i><span>Enroll in Course</span>
        </a>
        <a href="${pageContext.request.contextPath}/student/assignments" class="menu-item">
            <i class="fas fa-tasks"></i><span>Assignments</span>
        </a>
        <a href="${pageContext.request.contextPath}/student/grades" class="menu-item">
            <i class="fas fa-chart-line"></i><span>Grades</span>
        </a>
        <a href="${pageContext.request.contextPath}/logout" class="menu-item">
            <i class="fas fa-sign-out-alt"></i><span>Logout</span>
        </a>
    </div>
    
    <div class="main-content">
        <div class="top-bar">
            <h1><i class="fas fa-plus-circle"></i> Available Courses</h1>
            <p style="color: #7f8c8d; margin-top: 5px;">Browse and enroll in available courses</p>

            <c:if test="${not empty success}">
                <div style="background: #d4edda; color: #155724; padding: 10px; border-radius: 5px; margin-top: 10px; border: 1px solid #c3e6cb;">
                    <i class="fas fa-check-circle"></i> ${success}
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div style="background: #f8d7da; color: #721c24; padding: 10px; border-radius: 5px; margin-top: 10px; border: 1px solid #f5c6cb;">
                    <i class="fas fa-exclamation-triangle"></i> ${error}
                </div>
            </c:if>
        </div>
        
        <c:choose>
            <c:when test="${not empty availableCourses}">
                <div class="course-grid">
                    <c:forEach var="course" items="${availableCourses}">
                        <div class="course-card">
                            <div class="course-header">
                                <span class="course-code">${course.courseCode}</span>
                                <span style="color: #7f8c8d; font-size: 14px;">${course.credits} Credits</span>
                            </div>
                            <h3>${course.courseName}</h3>
                            <div class="course-info">
                                <p><i class="fas fa-chalkboard-teacher"></i> ${course.instructorName}</p>
                                <p><i class="fas fa-calendar"></i> ${course.startDate} - ${course.endDate}</p>
                                <p><i class="fas fa-info-circle"></i> ${course.description}</p>
                            </div>
                            <form action="${pageContext.request.contextPath}/student/enroll" method="post">
                                <input type="hidden" name="courseId" value="${course.courseID}">
                                <button type="submit" class="btn-enroll">
                                    <i class="fas fa-check"></i> Enroll Now
                                </button>
                            </form>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="no-courses">
                    <i class="fas fa-book"></i>
                    <p>No available courses to enroll in at this time.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
