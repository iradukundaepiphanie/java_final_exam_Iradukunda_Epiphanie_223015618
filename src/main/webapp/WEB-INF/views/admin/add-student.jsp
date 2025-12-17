<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Student - UR Education Platform</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #F4F6F8;
            min-height: 100vh;
            padding: 30px;
        }
        
        .container {
            max-width: 800px;
            margin: 0 auto;
        }
        
        .back-link {
            color: #0D47A1;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            font-weight: 600;
            margin-bottom: 20px;
            transition: all 0.3s;
        }
        
        .back-link:hover {
            color: #FBC02D;
        }
        
        .header-card {
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            margin-bottom: 25px;
            border-left: 5px solid #0D47A1;
        }
        
        .header-card h1 {
            color: #0D47A1;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .header-card p {
            color: #666;
        }
        
        .form-card {
            background: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        .form-group label {
            display: block;
            color: #0D47A1;
            font-weight: 600;
            margin-bottom: 10px;
            font-size: 14px;
        }
        
        .form-group label i {
            color: #FBC02D;
            margin-right: 8px;
        }
        
        .form-group input, .form-group select {
            width: 100%;
            padding: 14px 18px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 15px;
            font-family: inherit;
            transition: all 0.3s;
        }
        
        .form-group input:focus, .form-group select:focus {
            outline: none;
            border-color: #0D47A1;
            box-shadow: 0 0 0 4px rgba(13, 71, 161, 0.1);
        }
        
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }
        
        .btn-group {
            display: flex;
            gap: 15px;
            margin-top: 35px;
            padding-top: 25px;
            border-top: 2px solid #f0f0f0;
        }
        
        .btn {
            padding: 14px 35px;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            text-decoration: none;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #0D47A1, #1976D2);
            color: white;
            flex: 1;
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(13, 71, 161, 0.3);
        }
        
        .btn-secondary {
            background: #f5f5f5;
            color: #666;
        }
        
        .btn-secondary:hover {
            background: #e0e0e0;
        }
        
        .required {
            color: #d32f2f;
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="${pageContext.request.contextPath}/admin/students" class="back-link">
            <i class="fas fa-arrow-left"></i> Back to Students
        </a>
        
        <div class="header-card">
            <h1><i class="fas fa-user-plus"></i> Add New Student</h1>
            <p>Enter student information to create a new account</p>
        </div>
        
        <div class="form-card">
            <form action="${pageContext.request.contextPath}/admin/add-student" method="post">
                <div class="form-row">
                    <div class="form-group">
                        <label><i class="fas fa-user"></i> First Name <span class="required">*</span></label>
                        <input type="text" name="firstName" required placeholder="Enter first name">
                    </div>
                    
                    <div class="form-group">
                        <label><i class="fas fa-user"></i> Last Name <span class="required">*</span></label>
                        <input type="text" name="lastName" required placeholder="Enter last name">
                    </div>
                </div>
                
                <div class="form-group">
                    <label><i class="fas fa-envelope"></i> Email Address <span class="required">*</span></label>
                    <input type="email" name="email" required placeholder="student@ur.ac.rw">
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label><i class="fas fa-id-card"></i> Student ID <span class="required">*</span></label>
                        <input type="text" name="studentId" required placeholder="e.g., 220001234">
                    </div>
                    
                    <div class="form-group">
                        <label><i class="fas fa-calendar"></i> Date of Birth</label>
                        <input type="date" name="dateOfBirth">
                    </div>
                </div>
                
                <div class="form-group">
                    <label><i class="fas fa-lock"></i> Password <span class="required">*</span></label>
                    <input type="password" name="password" required placeholder="Enter password" minlength="6">
                </div>
                
                <div class="form-group">
                    <label><i class="fas fa-graduation-cap"></i> Program/Major</label>
                    <input type="text" name="major" placeholder="e.g., Computer Science">
                </div>
                
                <div class="btn-group">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i> Add Student
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/students" class="btn btn-secondary">
                        <i class="fas fa-times"></i> Cancel
                    </a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
