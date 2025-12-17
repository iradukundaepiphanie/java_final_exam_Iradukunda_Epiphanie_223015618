<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Instructor - Admin</title>
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
        
        .menu-item:hover { background: rgba(255,255,255,0.15); }
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
        
        .form-container {
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            max-width: 700px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #2c3e50;
            font-weight: 600;
        }
        
        .form-group input,
        .form-group select {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            font-size: 14px;
            transition: border-color 0.3s;
        }
        
        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: #a855f7;
        }
        
        .btn-submit {
            background: linear-gradient(135deg, #a855f7, #ec4899);
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 10px;
            font-weight: 600;
            font-size: 16px;
            cursor: pointer;
            transition: transform 0.3s;
        }
        
        .btn-submit:hover {
            transform: translateY(-2px);
        }
        
        .btn-cancel {
            background: #6c757d;
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 10px;
            font-weight: 600;
            font-size: 16px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            margin-left: 10px;
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="sidebar-header">
            <h2><i class="fas fa-graduation-cap"></i> Admin Portal</h2>
        </div>
        
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="menu-item">
            <i class="fas fa-home"></i>
            <span>Dashboard</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/students" class="menu-item">
            <i class="fas fa-user-graduate"></i>
            <span>Students</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/instructors" class="menu-item active">
            <i class="fas fa-chalkboard-teacher"></i>
            <span>Instructors</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/courses" class="menu-item">
            <i class="fas fa-book"></i>
            <span>Courses</span>
        </a>
    </div>
    
    <div class="main-content">
        <div class="top-bar">
            <h1><i class="fas fa-user-plus"></i> Add New Instructor</h1>
            <p style="color: #7f8c8d; margin-top: 5px;">Fill in the form to add a new instructor</p>
        </div>
        
        <div class="form-container">
            <form action="${pageContext.request.contextPath}/admin/add-instructor" method="post">
                <div class="form-group">
                    <label for="firstName"><i class="fas fa-user"></i> First Name</label>
                    <input type="text" id="firstName" name="firstName" required>
                </div>
                
                <div class="form-group">
                    <label for="lastName"><i class="fas fa-user"></i> Last Name</label>
                    <input type="text" id="lastName" name="lastName" required>
                </div>
                
                <div class="form-group">
                    <label for="email"><i class="fas fa-envelope"></i> Email</label>
                    <input type="email" id="email" name="email" required>
                </div>
                
                <div class="form-group">
                    <label for="password"><i class="fas fa-lock"></i> Password</label>
                    <input type="password" id="password" name="password" required>
                </div>
                
                <div class="form-group">
                    <label for="phone"><i class="fas fa-phone"></i> Phone</label>
                    <input type="text" id="phone" name="phone">
                </div>
                
                <div class="form-group">
                    <label for="department"><i class="fas fa-building"></i> Department</label>
                    <input type="text" id="department" name="department">
                </div>
                
                <div class="form-group">
                    <label for="specialization"><i class="fas fa-award"></i> Specialization</label>
                    <input type="text" id="specialization" name="specialization">
                </div>
                
                <div class="form-group">
                    <button type="submit" class="btn-submit">
                        <i class="fas fa-check"></i> Add Instructor
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/instructors" class="btn-cancel">
                        <i class="fas fa-times"></i> Cancel
                    </a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
