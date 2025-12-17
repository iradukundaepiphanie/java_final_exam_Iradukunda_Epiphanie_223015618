<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Submit Assignment</title>
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
        .assignment-details {
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 25px;
        }
        .assignment-details h2 {
            color: #2c3e50;
            margin-bottom: 15px;
        }
        .detail-row {
            display: flex;
            padding: 12px 0;
            border-bottom: 1px solid #e9ecef;
        }
        .detail-label {
            font-weight: 600;
            color: #2c3e50;
            width: 150px;
        }
        .detail-value {
            color: #7f8c8d;
        }
        .form-section {
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
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
        .form-group textarea {
            width: 100%;
            min-height: 200px;
            padding: 15px;
            border: 2px solid #e9ecef;
            border-radius: 10px;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            font-size: 14px;
            resize: vertical;
        }
        .form-group textarea:focus {
            outline: none;
            border-color: #a855f7;
        }
        .btn-group {
            display: flex;
            gap: 15px;
        }
        .btn {
            padding: 12px 30px;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }
        .btn-submit {
            background: linear-gradient(135deg, #a855f7, #ec4899);
            color: white;
        }
        .btn-submit:hover {
            transform: scale(1.02);
            box-shadow: 0 5px 15px rgba(168, 85, 247, 0.4);
        }
        .btn-cancel {
            background: #e9ecef;
            color: #2c3e50;
        }
        .btn-cancel:hover {
            background: #d3d3d3;
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
        <a href="${pageContext.request.contextPath}/student/assignments" class="menu-item active">
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
            <h1><i class="fas fa-pen"></i> Submit Assignment</h1>
            <p style="color: #7f8c8d; margin-top: 5px;">Complete and submit your work</p>
        </div>
        
        <div class="assignment-details">
            <h2>${assignment.title}</h2>
            <div class="detail-row">
                <div class="detail-label"><i class="fas fa-book"></i> Course:</div>
                <div class="detail-value">${assignment.courseName}</div>
            </div>
            <div class="detail-row">
                <div class="detail-label"><i class="fas fa-info-circle"></i> Description:</div>
                <div class="detail-value">${assignment.description}</div>
            </div>
            <div class="detail-row">
                <div class="detail-label"><i class="fas fa-calendar"></i> Due Date:</div>
                <div class="detail-value">${assignment.dueDate}</div>
            </div>
            <div class="detail-row">
                <div class="detail-label"><i class="fas fa-star"></i> Max Points:</div>
                <div class="detail-value">${assignment.maxPoints}</div>
            </div>
        </div>
        
        <div class="form-section">
            <h3 style="margin-bottom: 20px; color: #2c3e50;">Your Submission</h3>
            <form action="${pageContext.request.contextPath}/student/submit-assignment" method="post">
                <input type="hidden" name="assignmentId" value="${assignment.assignmentID}">
                
                <div class="form-group">
                    <label><i class="fas fa-edit"></i> Assignment Answer</label>
                    <textarea name="submission" required placeholder="Type your assignment answer here..."></textarea>
                </div>
                
                <div class="btn-group">
                    <button type="submit" class="btn btn-submit">
                        <i class="fas fa-paper-plane"></i> Submit Assignment
                    </button>
                    <a href="${pageContext.request.contextPath}/student/assignments" class="btn btn-cancel">
                        <i class="fas fa-times"></i> Cancel
                    </a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
