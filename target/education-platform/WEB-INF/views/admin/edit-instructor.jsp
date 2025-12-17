<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Instructor - Admin</title>
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
            background: linear-gradient(180deg, #1e3a5f 0%, #152a45 100%);
            color: white;
            position: fixed;
            height: 100vh;
            overflow-y: auto;
        }
        .sidebar-header {
            padding: 25px 20px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }
        .sidebar-header h2 {
            font-size: 20px;
            color: #FBC02D;
        }
        .menu-item {
            padding: 14px 20px;
            display: flex;
            align-items: center;
            gap: 12px;
            color: white;
            text-decoration: none;
            transition: all 0.3s;
        }
        .menu-item:hover, .menu-item.active {
            background: rgba(251, 192, 45, 0.1);
            border-left: 3px solid #FBC02D;
        }
        .main-content {
            margin-left: 260px;
            flex: 1;
            padding: 30px;
        }
        .header {
            background: white;
            padding: 25px 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 30px;
        }
        .header h1 {
            color: #2c3e50;
            font-size: 28px;
        }
        .form-container {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #2c3e50;
            font-weight: 500;
        }
        .form-group input, .form-group select {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }
        .form-group input:focus, .form-group select:focus {
            outline: none;
            border-color: #FBC02D;
        }
        .btn-group {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }
        .btn {
            padding: 12px 30px;
            border: none;
            border-radius: 5px;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-block;
        }
        .btn-primary {
            background: #FBC02D;
            color: #1e3a5f;
            font-weight: 600;
        }
        .btn-primary:hover {
            background: #f9b000;
        }
        .btn-secondary {
            background: #6c757d;
            color: white;
        }
        .btn-secondary:hover {
            background: #5a6268;
        }
        .error-message {
            background: #fee;
            color: #c33;
            padding: 12px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="sidebar-header">
            <h2><i class="fas fa-graduation-cap"></i> UR</h2>
            <p style="font-size: 12px; opacity: 0.8;">University of Rwanda</p>
        </div>
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="menu-item">
            <i class="fas fa-tachometer-alt"></i> Dashboard
        </a>
        <a href="${pageContext.request.contextPath}/admin/students" class="menu-item">
            <i class="fas fa-user-graduate"></i> Students
        </a>
        <a href="${pageContext.request.contextPath}/admin/instructors" class="menu-item active">
            <i class="fas fa-chalkboard-teacher"></i> Instructors
        </a>
        <a href="${pageContext.request.contextPath}/admin/courses" class="menu-item">
            <i class="fas fa-book"></i> Courses
        </a>
        <a href="${pageContext.request.contextPath}/logout" class="menu-item">
            <i class="fas fa-sign-out-alt"></i> Logout
        </a>
    </div>

    <div class="main-content">
        <div class="header">
            <h1><i class="fas fa-edit"></i> Edit Instructor</h1>
        </div>

        <c:if test="${not empty error}">
            <div class="error-message">${error}</div>
        </c:if>

        <div class="form-container">
            <form action="${pageContext.request.contextPath}/admin/edit-instructor" method="post">
                <input type="hidden" name="instructorId" value="${instructor.instructorID}">
                
                <div class="form-group">
                    <label for="firstName">First Name</label>
                    <input type="text" id="firstName" name="firstName" value="${instructor.firstName}" required>
                </div>

                <div class="form-group">
                    <label for="lastName">Last Name</label>
                    <input type="text" id="lastName" name="lastName" value="${instructor.lastName}" required>
                </div>

                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" id="email" name="email" value="${instructor.email}" required>
                    </div>

                    <div class="form-group">
                        <label for="phone">Phone</label>
                        <input type="tel" id="phone" name="phone" value="${instructor.phone}">
                    </div>

                    <div class="form-group">
                        <label for="department">Department</label>
                        <input type="text" id="department" name="department" value="${instructor.department}" required>
                    </div>

                    <div class="form-group">
                        <label for="specialization">Specialization</label>
                        <input type="text" id="specialization" name="specialization" value="${instructor.specialization}">
                    </div>

                    <div class="form-group">
                        <label for="hireDate">Hire Date</label>
                        <input type="date" id="hireDate" name="hireDate" value="${instructor.hireDate}">
                    </div>

                    <div class="form-group">
                        <label for="status">Status</label>
                        <select id="status" name="status" required>
                            <option value="Active" ${instructor.status == 'Active' ? 'selected' : ''}>Active</option>
                            <option value="Inactive" ${instructor.status == 'Inactive' ? 'selected' : ''}>Inactive</option>
                        </select>
                    </div>                <div class="btn-group">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i> Update Instructor
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/instructors" class="btn btn-secondary">
                        <i class="fas fa-times"></i> Cancel
                    </a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
