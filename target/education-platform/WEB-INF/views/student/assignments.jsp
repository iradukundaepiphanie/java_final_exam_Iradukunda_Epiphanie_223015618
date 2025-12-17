<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Assignments - Student</title>
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
        
        .section {
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
        }
        
        table th {
            background: #f8f9fa;
            padding: 15px;
            text-align: left;
            font-weight: 600;
            color: #2c3e50;
            border-bottom: 2px solid #e9ecef;
        }
        
        table td {
            padding: 15px;
            border-bottom: 1px solid #e9ecef;
        }
        
        table tr:hover {
            background: #f8f9fa;
        }
        
        .badge {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }
        
        .badge-pending {
            background: #fff3cd;
            color: #856404;
        }
        
        .badge-submitted {
            background: #d1ecf1;
            color: #0c5460;
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
        
        .action-link {
            color: #a855f7;
            text-decoration: none;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }
        
        .action-link:hover {
            text-decoration: underline;
        }
        
        /* Responsive Design */
        @media (max-width: 1024px) {
            .sidebar {
                width: 220px;
            }
            
            .main-content {
                margin-left: 220px;
                padding: 25px;
            }
        }
        
        @media (max-width: 768px) {
            body {
                flex-direction: column;
            }
            
            .sidebar {
                width: 100%;
                height: auto;
                position: relative;
            }
            
            .sidebar-header {
                padding: 20px;
            }
            
            .sidebar-header h2 {
                font-size: 18px;
            }
            
            .menu-item {
                padding: 12px 20px;
            }
            
            .main-content {
                margin-left: 0;
                padding: 20px 15px;
            }
            
            .page-header h1 {
                font-size: 24px;
            }
            
            table {
                font-size: 13px;
            }
            
            table th, table td {
                padding: 10px 8px;
            }
            
            .btn-take {
                padding: 6px 12px;
                font-size: 12px;
            }
        }
        
        @media (max-width: 576px) {
            .sidebar-header h2 {
                font-size: 16px;
            }
            
            .page-header {
                padding: 20px 15px;
            }
            
            .page-header h1 {
                font-size: 20px;
            }
            
            .content-section {
                padding: 20px 15px;
            }
            
            table {
                display: block;
                overflow-x: auto;
                white-space: nowrap;
                -webkit-overflow-scrolling: touch;
            }
            
            .badge {
                padding: 4px 10px;
                font-size: 11px;
            }
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="sidebar-header">
            <h2><i class="fas fa-graduation-cap"></i> Student Portal</h2>
        </div>
        
        <a href="${pageContext.request.contextPath}/student/dashboard" class="menu-item">
            <i class="fas fa-home"></i>
            <span>Dashboard</span>
        </a>
        <a href="${pageContext.request.contextPath}/student/courses" class="menu-item">
            <i class="fas fa-book"></i>
            <span>My Courses</span>
        </a>
        <a href="${pageContext.request.contextPath}/student/enroll" class="menu-item">
            <i class="fas fa-plus-circle"></i>
            <span>Enroll in Course</span>
        </a>
        <a href="${pageContext.request.contextPath}/student/assignments" class="menu-item active">
            <i class="fas fa-tasks"></i>
            <span>Assignments</span>
        </a>
        <a href="${pageContext.request.contextPath}/student/grades" class="menu-item">
            <i class="fas fa-chart-line"></i>
            <span>Grades</span>
        </a>
        <a href="${pageContext.request.contextPath}/logout" class="menu-item">
            <i class="fas fa-sign-out-alt"></i>
            <span>Logout</span>
        </a>
    </div>
    
    <div class="main-content">
        <div class="top-bar">
            <h1><i class="fas fa-tasks"></i> My Assignments</h1>
            <p style="color: #7f8c8d; margin-top: 5px;">View and manage your assignments</p>
        </div>
        
        <div class="section">
            <h2 style="margin-bottom: 25px;">All Assignments</h2>
            <c:choose>
                <c:when test="${not empty assignments}">
                    <table>
                        <thead>
                            <tr>
                                <th>Assignment</th>
                                <th>Course</th>
                                <th>Description</th>
                                <th>Due Date</th>
                                <th>Max Points</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="assignment" items="${assignments}">
                                <tr>
                                    <td><strong>${assignment.title}</strong></td>
                                    <td>${assignment.courseName}</td>
                                    <td>${assignment.description}</td>
                                    <td>${assignment.dueDate}</td>
                                    <td>${assignment.maxPoints}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${assignment.submitted}">
                                                <span class="badge badge-submitted">Submitted</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-pending">Pending</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${assignment.submitted}">
                                                <a href="${pageContext.request.contextPath}/student/view-grade?assignmentId=${assignment.assignmentID}" class="action-link">
                                                    <i class="fas fa-eye"></i> View Grade
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="${pageContext.request.contextPath}/student/take-assignment?assignmentId=${assignment.assignmentID}" class="action-link">
                                                    <i class="fas fa-pen"></i> Start Work
                                                </a>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="no-data">
                        <i class="fas fa-tasks"></i>
                        <p>No assignments available.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>
