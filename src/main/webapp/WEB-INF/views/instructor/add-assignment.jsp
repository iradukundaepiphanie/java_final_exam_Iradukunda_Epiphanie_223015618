<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Assignment</title>
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
        }
        .form-container {
            background: white;
            padding: 35px;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            max-width: 800px;
        }
        .form-group {
            margin-bottom: 25px;
        }
        .form-group label {
            display: block;
            color: #2c3e50;
            font-weight: 600;
            margin-bottom: 8px;
        }
        .form-group input, .form-group select, .form-group textarea {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e9ecef;
            border-radius: 10px;
            font-size: 14px;
            font-family: inherit;
        }
        .form-group textarea {
            min-height: 120px;
            resize: vertical;
        }
        .form-group input:focus, .form-group select:focus, .form-group textarea:focus {
            outline: none;
            border-color: #f093fb;
        }
        .btn-group {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }
        .btn {
            padding: 12px 30px;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-block;
        }
        .btn-primary {
            background: linear-gradient(135deg, #f093fb, #f5576c);
            color: white;
        }
        .btn-primary:hover {
            transform: scale(1.02);
            box-shadow: 0 5px 15px rgba(240, 147, 251, 0.4);
        }
        .btn-secondary {
            background: #e9ecef;
            color: #2c3e50;
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="sidebar-header">
            <h2><i class="fas fa-chalkboard-teacher"></i> Instructor Portal</h2>
        </div>
        <a href="${pageContext.request.contextPath}/instructor/dashboard" class="menu-item">
            <i class="fas fa-home"></i><span>Dashboard</span>
        </a>
        <a href="${pageContext.request.contextPath}/instructor/courses" class="menu-item">
            <i class="fas fa-book"></i><span>My Courses</span>
        </a>
        <a href="${pageContext.request.contextPath}/instructor/assignments" class="menu-item active">
            <i class="fas fa-tasks"></i><span>Assignments</span>
        </a>
        <a href="${pageContext.request.contextPath}/logout" class="menu-item">
            <i class="fas fa-sign-out-alt"></i><span>Logout</span>
        </a>
    </div>
    
    <div class="main-content">
        <div class="top-bar">
            <h1><i class="fas fa-plus-circle"></i> Create New Assignment</h1>
        </div>
        
        <div class="form-container">
            <form action="${pageContext.request.contextPath}/instructor/add-assignment" method="post">
                <div class="form-group">
                    <label><i class="fas fa-book"></i> Select Course *</label>
                    <select name="courseId" required>
                        <option value="">-- Select Course --</option>
                        <c:forEach var="course" items="${courses}">
                            <option value="${course.courseID}">${course.courseCode} - ${course.courseName}</option>
                        </c:forEach>
                    </select>
                </div>
                
                <div class="form-group">
                    <label><i class="fas fa-heading"></i> Assignment Title *</label>
                    <input type="text" name="title" required placeholder="e.g., Java Programming - Week 1">
                </div>
                
                <div class="form-group">
                    <label><i class="fas fa-align-left"></i> Description *</label>
                    <textarea name="description" required placeholder="Describe the assignment requirements..."></textarea>
                </div>
                
                <div class="form-group">
                    <label><i class="fas fa-calendar"></i> Due Date *</label>
                    <input type="date" name="dueDate" required>
                </div>
                
                <div class="form-group">
                    <label><i class="fas fa-star"></i> Maximum Points *</label>
                    <input type="number" name="maxPoints" min="1" max="1000" required placeholder="100">
                </div>
                
                <div class="btn-group">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-check"></i> Create Assignment
                    </button>
                    <a href="${pageContext.request.contextPath}/instructor/assignments" class="btn btn-secondary">
                        <i class="fas fa-times"></i> Cancel
                    </a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
