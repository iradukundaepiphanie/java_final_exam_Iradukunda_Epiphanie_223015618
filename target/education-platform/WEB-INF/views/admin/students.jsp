<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Students - Aksbor</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #F5F7FA;
            display: flex;
            min-height: 100vh;
        }
        
        /* Sidebar - Same as Dashboard */
        .sidebar {
            width: 220px;
            background: #1e3a5f;
            color: white;
            position: fixed;
            height: 100vh;
            overflow-y: auto;
            box-shadow: 2px 0 15px rgba(0,0,0,0.1);
        }
        .logo {
            background: #152a45;
            padding: 25px 20px;
            text-align: center;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }
        .logo h1 {
            color: #FBC02D;
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 5px;
        }
        .logo p {
            color: rgba(255,255,255,0.7);
            font-size: 12px;
        }
        .nav-menu { padding: 20px 0; }
        .nav-section { margin-bottom: 25px; }
        .nav-section-title {
            color: rgba(255,255,255,0.5);
            font-size: 11px;
            text-transform: uppercase;
            padding: 0 20px;
            margin-bottom: 10px;
            letter-spacing: 1px;
        }
        .menu-item {
            padding: 12px 20px;
            display: flex;
            align-items: center;
            gap: 12px;
            color: rgba(255,255,255,0.8);
            text-decoration: none;
            transition: all 0.3s;
            border-left: 3px solid transparent;
        }
        .menu-item:hover,
        .menu-item.active {
            background: rgba(251, 192, 45, 0.1);
            color: #FBC02D;
            border-left-color: #FBC02D;
        }
        .menu-item i { width: 20px; font-size: 16px; }
        
        /* Main Content */
        .main-content {
            margin-left: 220px;
            flex: 1;
            width: calc(100% - 220px);
        }
        .top-bar {
            background: white;
            padding: 15px 30px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .breadcrumb {
            display: flex;
            gap: 10px;
            align-items: center;
            color: #6C757D;
            font-size: 14px;
        }
        .breadcrumb a {
            color: #0D47A1;
            text-decoration: none;
        }
        .user-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: linear-gradient(135deg, #FBC02D, #FFD54F);
            display: flex;
            align-items: center;
            justify-content: center;
            color: #2C3E50;
            font-weight: 700;
        }
        
        /* Content Area */
        .content-area { padding: 30px; }
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }
        .page-header h1 {
            font-size: 28px;
            color: #2C3E50;
        }
        .btn-add {
            background: linear-gradient(135deg, #4CAF50, #66BB6A);
            color: white;
            padding: 12px 24px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            box-shadow: 0 4px 15px rgba(76, 175, 80, 0.3);
            transition: all 0.3s;
        }
        .btn-add:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(76, 175, 80, 0.4);
        }
        
        /* Table */
        .table-container {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.06);
            overflow: hidden;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table th {
            background: #F8F9FA;
            color: #2C3E50;
            font-weight: 600;
            padding: 15px;
            text-align: left;
            border-bottom: 2px solid #E9ECEF;
        }
        table td {
            padding: 15px;
            border-bottom: 1px solid #F0F0F0;
            color: #495057;
        }
        table tr:hover {
            background: #F8F9FA;
        }
        .badge {
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 600;
        }
        .badge.active {
            background: #D4EDDA;
            color: #155724;
        }
        .badge.inactive {
            background: #F8D7DA;
            color: #721C24;
        }
        .action-buttons {
            display: flex;
            gap: 8px;
        }
        .btn-edit {
            background: #00BCD4;
            color: white;
            padding: 6px 12px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 13px;
            font-weight: 600;
            transition: all 0.3s;
        }
        .btn-edit:hover {
            background: #0097A7;
            transform: scale(1.05);
        }
        .btn-delete {
            background: #FF5370;
            color: white;
            padding: 6px 12px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 13px;
            font-weight: 600;
            transition: all 0.3s;
        }
        .btn-delete:hover {
            background: #E53E3E;
            transform: scale(1.05);
        }
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #999;
        }
        .empty-state i {
            font-size: 64px;
            color: #DDD;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="logo">
            <h1>Aksbor</h1>
            <p>School Management System</p>
        </div>
        <nav class="nav-menu">
            <div class="nav-section">
                <div class="nav-section-title">Main</div>
                <a href="<c:url value='/admin/dashboard'/>" class="menu-item">
                    <i class="fas fa-home"></i>
                    <span>Dashboard</span>
                </a>
                <a href="<c:url value='/admin/students'/>" class="menu-item active">
                    <i class="fas fa-user-graduate"></i>
                    <span>Students</span>
                </a>
            </div>
            <div class="nav-section">
                <div class="nav-section-title">Management</div>
                <a href="<c:url value='/admin/instructors'/>" class="menu-item">
                    <i class="fas fa-chalkboard-teacher"></i>
                    <span>Teachers</span>
                </a>
                <a href="<c:url value='/admin/courses'/>" class="menu-item">
                    <i class="fas fa-book"></i>
                    <span>Courses</span>
                </a>
            </div>
            <div class="nav-section">
                <div class="nav-section-title">Account</div>
                <a href="<c:url value='/logout'/>" class="menu-item">
                    <i class="fas fa-sign-out-alt"></i>
                    <span>Logout</span>
                </a>
            </div>
        </nav>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Top Bar -->
        <div class="top-bar">
            <div class="breadcrumb">
                <a href="<c:url value='/admin/dashboard'/>">Home</a>
                <span>/</span>
                <span>Students</span>
            </div>
            <div class="user-info">
                <div class="user-avatar">A</div>
                <span>Admin</span>
            </div>
        </div>

        <!-- Content Area -->
        <div class="content-area">
            <div class="page-header">
                <h1><i class="fas fa-user-graduate"></i> Manage Students</h1>
                <a href="${pageContext.request.contextPath}/admin/add-student" class="btn-add">
                    <i class="fas fa-plus"></i> Add New Student
                </a>
            </div>

            <div class="table-container">
                <c:choose>
                    <c:when test="${not empty students}">
                        <table>
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Name</th>
                                    <th>Email</th>
                                    <th>Phone</th>
                                    <th>Date of Birth</th>
                                    <th>Enrollment Date</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="student" items="${students}">
                                    <tr>
                                        <td><strong>#${student.studentID}</strong></td>
                                        <td><strong>${student.fullName}</strong></td>
                                        <td>${student.email}</td>
                                        <td>${student.phone}</td>
                                        <td>${student.dateOfBirth}</td>
                                        <td>${student.enrollmentDate}</td>
                                        <td>
                                            <span class="badge ${student.status == 'Active' ? 'active' : 'inactive'}">
                                                ${student.status}
                                            </span>
                                        </td>
                                        <td>
                                            <div class="action-buttons">
                                                <a href="${pageContext.request.contextPath}/admin/edit-student?id=${student.studentID}" class="btn-edit">
                                                    <i class="fas fa-edit"></i> Edit
                                                </a>
                                                <form action="${pageContext.request.contextPath}/admin/delete-student" method="post" style="display:inline;">
                                                    <input type="hidden" name="studentId" value="${student.studentID}">
                                                    <button type="submit" class="btn-delete" onclick="return confirm('Are you sure you want to delete ${student.fullName}?')">
                                                        <i class="fas fa-trash"></i> Delete
                                                    </button>
                                                </form>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <i class="fas fa-user-graduate"></i>
                            <h3>No Students Found</h3>
                            <p>Start by adding your first student</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</body>
</html>
