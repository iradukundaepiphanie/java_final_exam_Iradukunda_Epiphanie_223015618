<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Grade Submission</title>
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
        .submission-details {
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 25px;
        }
        .detail-row {
            display: flex;
            padding: 12px 0;
            border-bottom: 1px solid #e9ecef;
        }
        .detail-label {
            font-weight: 600;
            color: #2c3e50;
            width: 180px;
        }
        .detail-value {
            color: #7f8c8d;
            flex: 1;
        }
        .submission-content {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            margin-top: 20px;
        }
        .submission-content h3 {
            color: #2c3e50;
            margin-bottom: 15px;
        }
        .grading-form {
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
        .form-group input, .form-group textarea {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e9ecef;
            border-radius: 10px;
            font-size: 14px;
            font-family: inherit;
        }
        .form-group textarea {
            min-height: 120px;
        }
        .form-group input:focus, .form-group textarea:focus {
            outline: none;
            border-color: #f093fb;
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
            <h1><i class="fas fa-check-circle"></i> Grade Submission</h1>
        </div>
        
        <div class="submission-details">
            <h2 style="margin-bottom: 20px;">${submission.assignmentTitle}</h2>
            <div class="detail-row">
                <div class="detail-label"><i class="fas fa-user"></i> Student:</div>
                <div class="detail-value">${submission.studentName}</div>
            </div>
            <div class="detail-row">
                <div class="detail-label"><i class="fas fa-book"></i> Course:</div>
                <div class="detail-value">${submission.courseName}</div>
            </div>
            <div class="detail-row">
                <div class="detail-label"><i class="fas fa-calendar"></i> Submitted:</div>
                <div class="detail-value">${submission.submissionDate}</div>
            </div>
            <div class="detail-row">
                <div class="detail-label"><i class="fas fa-star"></i> Max Points:</div>
                <div class="detail-value">${submission.maxPoints}</div>
            </div>
            
            <div class="submission-content">
                <h3>Student's Answer:</h3>
                <p>${submission.submissionText}</p>
            </div>
        </div>
        
        <div class="grading-form">
            <h3 style="margin-bottom: 20px; color: #2c3e50;">Grade This Submission</h3>
            <form action="${pageContext.request.contextPath}/instructor/grade-submission" method="post">
                <input type="hidden" name="submissionId" value="${submission.submissionID}">
                
                <div class="form-group">
                    <label><i class="fas fa-star"></i> Score (out of ${submission.maxPoints}) *</label>
                    <input type="number" name="score" min="0" max="${submission.maxPoints}" step="0.5" required>
                </div>
                
                <div class="form-group">
                    <label><i class="fas fa-comment"></i> Feedback</label>
                    <textarea name="feedback" placeholder="Provide feedback to the student..."></textarea>
                </div>
                
                <div class="btn-group">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-check"></i> Submit Grade
                    </button>
                    <a href="${pageContext.request.contextPath}/instructor/assignments" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Back
                    </a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
