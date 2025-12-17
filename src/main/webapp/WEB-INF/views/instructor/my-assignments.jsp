<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Assignments - UR Education Platform</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #1e3a5f 0%, #152a45 100%);
            min-height: 100vh;
            display: flex;
        }

        .sidebar {
            width: 260px;
            background: linear-gradient(180deg, #1e3a5f 0%, #152a45 100%);
            color: white;
            padding: 20px;
            position: fixed;
            height: 100vh;
            overflow-y: auto;
            box-shadow: 4px 0 10px rgba(0,0,0,0.1);
        }

        .sidebar-header {
            padding: 20px 10px;
            margin-bottom: 30px;
            border-bottom: 2px solid rgba(255,215,0,0.3);
        }

        .sidebar-header h2 {
            color: #ffd700;
            font-size: 22px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .menu-item {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 14px 18px;
            color: white;
            text-decoration: none;
            border-radius: 10px;
            margin-bottom: 8px;
            transition: all 0.3s ease;
            font-size: 15px;
        }

        .menu-item:hover {
            background: rgba(255,215,0,0.1);
            padding-left: 25px;
            border-left: 3px solid #ffd700;
        }

        .menu-item.active {
            background: rgba(255,215,0,0.15);
            border-left: 4px solid #ffd700;
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

        .top-bar p {
            color: #7f8c8d;
            font-size: 14px;
        }

        .section {
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .section h2 {
            font-size: 20px;
            color: #2c3e50;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #f0f0f0;
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

        .badge-mcq {
            background: #e3f2fd;
            color: #1976d2;
        }

        .badge-essay {
            background: #f3e5f5;
            color: #7b1fa2;
        }

        .action-link {
            color: #3498db;
            text-decoration: none;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 5px;
            transition: all 0.3s;
        }

        .action-link:hover {
            color: #2980b9;
            gap: 8px;
        }

        .stats-row {
            display: flex;
            gap: 20px;
            margin-bottom: 25px;
        }

        .stat-card {
            flex: 1;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 20px;
            border-radius: 12px;
            color: white;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }

        .stat-card h3 {
            font-size: 14px;
            opacity: 0.9;
            margin-bottom: 8px;
        }

        .stat-card .value {
            font-size: 32px;
            font-weight: bold;
        }

        .stat-card.gold {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
        }

        .stat-card.green {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #95a5a6;
        }

        .empty-state i {
            font-size: 64px;
            margin-bottom: 20px;
            opacity: 0.3;
        }

        .empty-state h3 {
            font-size: 20px;
            margin-bottom: 10px;
        }

        .empty-state p {
            font-size: 14px;
            margin-bottom: 20px;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 12px 25px;
            border-radius: 8px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            font-weight: 500;
            transition: all 0.3s;
            border: none;
            cursor: pointer;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
        }

        .date-display {
            font-size: 13px;
            color: #7f8c8d;
        }

        .submissions-badge {
            background: #e8f5e9;
            color: #2e7d32;
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 600;
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
            
            .filters {
                flex-direction: column;
                gap: 12px;
            }
            
            .filter-group {
                width: 100%;
            }
            
            table {
                font-size: 13px;
            }
            
            table th, table td {
                padding: 10px 8px;
            }
            
            .btn-view {
                padding: 6px 12px;
                font-size: 12px;
            }
        }
        
        @media (max-width: 576px) {
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
            
            .filter-input, .filter-select {
                padding: 10px 12px;
                font-size: 13px;
            }
            
            .type-badge, .submissions-badge {
                padding: 3px 8px;
                font-size: 11px;
            }
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-header">
            <h2><i class="fas fa-graduation-cap"></i> Instructor Portal</h2>
        </div>

        <a href="${pageContext.request.contextPath}/instructor/dashboard" class="menu-item">
            <i class="fas fa-home"></i>
            <span>Dashboard</span>
        </a>
        <a href="${pageContext.request.contextPath}/instructor/courses" class="menu-item">
            <i class="fas fa-book"></i>
            <span>My Courses</span>
        </a>
        <a href="${pageContext.request.contextPath}/instructor/create-assignment" class="menu-item">
            <i class="fas fa-plus-circle"></i>
            <span>Create Assignment</span>
        </a>
        <a href="${pageContext.request.contextPath}/instructor/my-assignments" class="menu-item active">
            <i class="fas fa-list"></i>
            <span>My Assignments</span>
        </a>
        <a href="${pageContext.request.contextPath}/instructor/grade-submissions" class="menu-item">
            <i class="fas fa-check-circle"></i>
            <span>Grade Submissions</span>
        </a>
        <a href="${pageContext.request.contextPath}/logout" class="menu-item">
            <i class="fas fa-sign-out-alt"></i>
            <span>Logout</span>
        </a>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="top-bar">
            <h1><i class="fas fa-list"></i> My Created Assignments</h1>
            <p>View and manage all assignments you've created</p>
        </div>

        <!-- Success Message -->
        <c:if test="${param.success == 'created'}">
            <div style="background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%); color: white; padding: 15px 25px; border-radius: 12px; margin-bottom: 25px; display: flex; align-items: center; gap: 12px; box-shadow: 0 4px 15px rgba(79, 172, 254, 0.3);">
                <i class="fas fa-check-circle" style="font-size: 24px;"></i>
                <div>
                    <strong style="font-size: 16px;">Assignment Created Successfully!</strong>
                    <p style="margin: 5px 0 0 0; opacity: 0.9; font-size: 14px;">Your assignment has been created and is now visible to students in the enrolled course.</p>
                </div>
            </div>
        </c:if>

        <!-- Statistics Cards -->
        <div class="stats-row">
            <div class="stat-card">
                <h3>Total Assignments</h3>
                <div class="value">${assignments.size()}</div>
            </div>
            <div class="stat-card gold">
                <h3>MCQ Assignments</h3>
                <div class="value">
                    <c:set var="mcqCount" value="0"/>
                    <c:forEach items="${assignments}" var="assignment">
                        <c:if test="${assignment.assignmentType == 'MCQ'}">
                            <c:set var="mcqCount" value="${mcqCount + 1}"/>
                        </c:if>
                    </c:forEach>
                    ${mcqCount}
                </div>
            </div>
            <div class="stat-card green">
                <h3>Essay Assignments</h3>
                <div class="value">
                    <c:set var="essayCount" value="0"/>
                    <c:forEach items="${assignments}" var="assignment">
                        <c:if test="${assignment.assignmentType == 'Essay'}">
                            <c:set var="essayCount" value="${essayCount + 1}"/>
                        </c:if>
                    </c:forEach>
                    ${essayCount}
                </div>
            </div>
        </div>

        <!-- Assignments Table -->
        <div class="section">
            <h2><i class="fas fa-clipboard-list"></i> Assignment Details</h2>

            <c:choose>
                <c:when test="${empty assignments}">
                    <div class="empty-state">
                        <i class="fas fa-folder-open"></i>
                        <h3>No Assignments Yet</h3>
                        <p>You haven't created any assignments yet. Create your first assignment to get started!</p>
                        <a href="${pageContext.request.contextPath}/instructor/create-assignment" class="btn-primary">
                            <i class="fas fa-plus-circle"></i> Create Assignment
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <table>
                        <thead>
                            <tr>
                                <th>Assignment Title</th>
                                <th>Course</th>
                                <th>Type</th>
                                <th>Created Date</th>
                                <th>Due Date</th>
                                <th>Max Points</th>
                                <th>Submissions</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${assignments}" var="assignment">
                                <tr>
                                    <td>
                                        <strong>${assignment.title}</strong>
                                        <c:if test="${not empty assignment.description}">
                                            <br><small style="color: #7f8c8d;">${assignment.description.length() > 60 ? assignment.description.substring(0, 60).concat('...') : assignment.description}</small>
                                        </c:if>
                                    </td>
                                    <td>${assignment.courseName}</td>
                                    <td>
                                        <span class="badge ${assignment.assignmentType == 'MCQ' ? 'badge-mcq' : 'badge-essay'}">
                                            ${assignment.assignmentType}
                                        </span>
                                    </td>
                                    <td>
                                        <div class="date-display">
                                            <i class="fas fa-calendar-plus"></i>
                                            <fmt:formatDate value="${assignment.createdAt}" pattern="MMM dd, yyyy"/>
                                            <br>
                                            <small><fmt:formatDate value="${assignment.createdAt}" pattern="hh:mm a"/></small>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="date-display">
                                            <i class="fas fa-calendar-check"></i>
                                            ${assignment.dueDate != null ? assignment.dueDate : 'Not set'}
                                        </div>
                                    </td>
                                    <td><strong>${assignment.maxPoints}</strong></td>
                                    <td>
                                        <span class="submissions-badge">
                                            ${assignment.submissionCount} submissions
                                        </span>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/instructor/view-submissions?assignmentId=${assignment.assignmentID}" class="action-link">
                                            <i class="fas fa-eye"></i> View Submissions
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>
