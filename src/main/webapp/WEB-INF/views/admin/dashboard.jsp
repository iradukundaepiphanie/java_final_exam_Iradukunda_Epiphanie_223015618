<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f7fa; }
        .navbar { background: linear-gradient(135deg, #fa709a 0%, #fee140 100%); color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; }
        .navbar h1 { font-size: 24px; }
        .navbar-right { display: flex; gap: 20px; align-items: center; }
        .navbar-right a { color: white; text-decoration: none; padding: 8px 15px; border-radius: 5px; transition: background 0.3s; }
        .navbar-right a:hover { background: rgba(255,255,255,0.2); }
        .container { max-width: 1200px; margin: 30px auto; padding: 0 20px; }
        .welcome-card { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); margin-bottom: 30px; }
        .welcome-card h2 { color: #333; margin-bottom: 10px; }
        .dashboard-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 20px; margin-bottom: 30px; }
        .stat-card { background: white; padding: 25px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); text-align: center; }
        .stat-card h3 { color: #fa709a; font-size: 48px; margin-bottom: 10px; }
        .stat-card p { color: #666; font-size: 16px; }
        .quick-actions { background: white; padding: 25px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .quick-actions h3 { color: #333; margin-bottom: 20px; }
        .action-buttons { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 15px; }
        .btn { padding: 12px 20px; text-align: center; background: linear-gradient(135deg, #fa709a 0%, #fee140 100%); color: white; text-decoration: none; border-radius: 5px; font-weight: 600; display: block; transition: transform 0.2s; }
        .btn:hover { transform: translateY(-2px); }
    </style>
</head>
<body>
    <nav class="navbar">
        <h1>🔧 Admin Dashboard</h1>
        <div class="navbar-right">
            <span>Welcome, ${sessionScope.user.firstName}!</span>
            <a href="${pageContext.request.contextPath}/admin/students">Students</a>
            <a href="${pageContext.request.contextPath}/admin/instructors">Instructors</a>
            <a href="${pageContext.request.contextPath}/admin/courses">Courses</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </div>
    </nav>
    
    <div class="container">
        <div class="welcome-card">
            <h2>Welcome back, Administrator!</h2>
            <p>Manage the education platform from here</p>
        </div>
        
        <div class="dashboard-grid">
            <div class="stat-card">
                <h3>${studentCount}</h3>
                <p>Total Students</p>
            </div>
            <div class="stat-card">
                <h3>${instructorCount}</h3>
                <p>Total Instructors</p>
            </div>
            <div class="stat-card">
                <h3>${courseCount}</h3>
                <p>Total Courses</p>
            </div>
        </div>
        
        <div class="quick-actions">
            <h3>Quick Actions</h3>
            <div class="action-buttons">
                <a href="${pageContext.request.contextPath}/admin/add-student" class="btn">➕ Add Student</a>
                <a href="${pageContext.request.contextPath}/admin/add-instructor" class="btn">➕ Add Instructor</a>
                <a href="${pageContext.request.contextPath}/admin/add-course" class="btn">➕ Add Course</a>
                <a href="${pageContext.request.contextPath}/admin/students" class="btn">👨‍🎓 Manage Students</a>
                <a href="${pageContext.request.contextPath}/admin/instructors" class="btn">👨‍🏫 Manage Instructors</a>
                <a href="${pageContext.request.contextPath}/admin/courses" class="btn">📚 Manage Courses</a>
            </div>
        </div>
    </div>
</body>
</html>
