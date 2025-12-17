<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Portal - University of Rwanda</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #F5F7FA;
            display: flex;
            min-height: 100vh;
        }
        
        /* Sidebar */
        .sidebar {
            width: 200px;
            background: linear-gradient(180deg, #5B6EC7 0%, #7B8FD9 100%);
            color: white;
            position: fixed;
            height: 100vh;
            overflow-y: auto;
            padding: 30px 0;
            box-shadow: 2px 0 15px rgba(0,0,0,0.1);
        }
        
        .logo {
            text-align: center;
            margin-bottom: 40px;
            padding: 0 20px;
        }
        
        .logo-icon {
            width: 70px;
            height: 70px;
            background: white;
            border-radius: 20px;
            margin: 0 auto 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 36px;
            color: #5B6EC7;
            font-weight: bold;
        }
        
        .logo h2 {
            font-size: 18px;
            font-weight: 600;
        }
        
        .menu-item {
            padding: 15px 25px;
            display: flex;
            align-items: center;
            gap: 15px;
            color: rgba(255,255,255,0.85);
            text-decoration: none;
            transition: all 0.3s;
            margin: 5px 15px;
            border-radius: 10px;
        }
        
        .menu-item:hover,
        .menu-item.active {
            background: rgba(255,255,255,0.2);
            color: white;
        }
        
        .menu-item i {
            width: 22px;
            font-size: 18px;
        }
        
        /* Main Content */
        .main-content {
            margin-left: 200px;
            flex: 1;
            padding: 30px 40px;
            width: calc(100% - 200px);
        }
        
        /* Search Bar */
        .search-bar {
            max-width: 500px;
            margin-bottom: 30px;
        }
        
        .search-input {
            width: 100%;
            padding: 12px 20px;
            border: 1px solid #E0E0E0;
            border-radius: 25px;
            font-size: 14px;
            background: white;
        }
        
        /* Welcome Banner */
        .welcome-banner {
            background: linear-gradient(135deg, #5B6EC7 0%, #8A9FE5 100%);
            border-radius: 20px;
            padding: 40px;
            margin-bottom: 30px;
            position: relative;
            overflow: hidden;
            color: white;
            min-height: 200px;
        }
        
        .welcome-banner::after {
            content: '';
            position: absolute;
            right: -50px;
            top: -50px;
            width: 200px;
            height: 200px;
            background: rgba(255,255,255,0.1);
            border-radius: 50%;
        }
        
        .welcome-date {
            font-size: 14px;
            opacity: 0.9;
            margin-bottom: 15px;
        }
        
        .welcome-title {
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 10px;
        }
        
        .welcome-subtitle {
            font-size: 15px;
            opacity: 0.95;
        }
        
        .welcome-illustration {
            position: absolute;
            right: 40px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 120px;
            opacity: 0.3;
        }
        
        /* Dashboard Grid */
        .dashboard-grid {
            display: grid;
            grid-template-columns: 1.5fr 1fr;
            gap: 30px;
            margin-bottom: 30px;
        }
        
        /* Info Card */
        .info-card {
            background: white;
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
        }
        
        .info-card h3 {
            font-size: 18px;
            margin-bottom: 25px;
            color: #2C3E50;
        }
        
        .personal-info {
            background: linear-gradient(135deg, #5B6EC7 0%, #7B8FD9 100%);
            border-radius: 15px;
            padding: 25px;
            color: white;
            margin-bottom: 20px;
        }
        
        .info-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-top: 15px;
        }
        
        .info-item {
            margin-bottom: 12px;
        }
        
        .info-label {
            font-size: 13px;
            opacity: 0.9;
            margin-bottom: 5px;
        }
        
        .info-value {
            font-size: 15px;
            font-weight: 600;
        }
        
        .student-info-card {
            background: #F8F9FA;
            border-radius: 12px;
            padding: 20px;
        }
        
        .student-info-item {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #E9ECEF;
        }
        
        .student-info-item:last-child {
            border-bottom: none;
        }
        
        .student-label {
            color: #6C757D;
            font-size: 14px;
        }
        
        .student-value {
            color: #2C3E50;
            font-weight: 600;
            font-size: 14px;
        }
        
        /* Progress & GPA Cards */
        .stats-mini-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }
        
        .chart-placeholder {
            background: #F8F9FA;
            border-radius: 12px;
            padding: 30px;
            text-align: center;
            height: 200px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #ADB5BD;
            font-size: 14px;
        }
        
        /* Courses Table */
        .section {
            background: white;
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            margin-bottom: 30px;
        }
        
        .section h3 {
            font-size: 20px;
            margin-bottom: 25px;
            color: #2C3E50;
            font-weight: 600;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
        }
        
        thead {
            background: #F8F9FA;
        }
        
        th {
            padding: 15px;
            text-align: left;
            font-weight: 600;
            color: #6C757D;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        td {
            padding: 18px 15px;
            color: #2C3E50;
            font-size: 14px;
            border-bottom: 1px solid #F0F0F0;
        }
        
        tbody tr:hover {
            background: #F8F9FA;
        }
        
        .badge {
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }
        
        .badge-active {
            background: #D4EDDA;
            color: #155724;
        }
        
        .badge-pending {
            background: #FFF3CD;
            color: #856404;
        }
        
        .no-data {
            text-align: center;
            padding: 60px 20px;
            color: #ADB5BD;
            font-size: 15px;
        }
        
        .btn-take-assignment {
            background: linear-gradient(135deg, #5B6EC7, #7B8FD9);
            color: white;
            padding: 8px 18px;
            border-radius: 20px;
            text-decoration: none;
            font-size: 13px;
            font-weight: 600;
            transition: all 0.3s;
            display: inline-block;
        }
        
        .btn-take-assignment:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(91,110,199,0.3);
        }
        
        /* Responsive Design */
        @media (max-width: 1024px) {
            .sidebar {
                width: 180px;
            }
            
            .main-content {
                margin-left: 180px;
                width: calc(100% - 180px);
                padding: 25px 30px;
            }
            
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
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
                padding: 20px 0;
            }
            
            .logo {
                display: flex;
                align-items: center;
                gap: 15px;
                padding: 0 20px;
                margin-bottom: 20px;
            }
            
            .logo-icon {
                width: 50px;
                height: 50px;
                font-size: 24px;
                margin: 0;
            }
            
            .logo h2 {
                font-size: 16px;
                margin-bottom: 0;
            }
            
            .menu-item {
                margin: 2px 10px;
                padding: 12px 20px;
            }
            
            .main-content {
                margin-left: 0;
                width: 100%;
                padding: 20px 15px;
            }
            
            .stats-grid {
                grid-template-columns: 1fr;
                gap: 15px;
            }
            
            .welcome-banner {
                padding: 30px 20px;
                min-height: 150px;
            }
            
            .welcome-title {
                font-size: 24px;
            }
            
            .welcome-subtitle {
                font-size: 14px;
            }
            
            .welcome-illustration {
                display: none;
            }
            
            table {
                font-size: 13px;
            }
            
            table th, table td {
                padding: 10px 8px;
            }
            
            .btn-take-assignment {
                padding: 6px 12px;
                font-size: 12px;
            }
        }
        
        @media (max-width: 576px) {
            .search-bar {
                margin-bottom: 20px;
            }
            
            .welcome-banner {
                padding: 25px 15px;
                border-radius: 15px;
            }
            
            .welcome-title {
                font-size: 20px;
            }
            
            .section {
                padding: 20px 15px;
                border-radius: 12px;
            }
            
            table {
                display: block;
                overflow-x: auto;
                white-space: nowrap;
                -webkit-overflow-scrolling: touch;
            }
            
            .stats-grid {
                gap: 12px;
            }
            
            .stat-card {
                padding: 20px 15px;
            }
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="logo">
            <div class="logo-icon">
                <i class="fas fa-graduation-cap"></i>
            </div>
            <h2>U/lex</h2>
        </div>
        
        <a href="${pageContext.request.contextPath}/student/dashboard" class="menu-item active">
            <i class="fas fa-home"></i>
            <span>Home Page</span>
        </a>
        <a href="${pageContext.request.contextPath}/student/courses" class="menu-item">
            <i class="fas fa-book"></i>
            <span>Courses</span>
        </a>
        <a href="${pageContext.request.contextPath}/student/assignments" class="menu-item">
            <i class="fas fa-tasks"></i>
            <span>Assignments</span>
        </a>
        <a href="${pageContext.request.contextPath}/student/grades" class="menu-item">
            <i class="fas fa-chart-bar"></i>
            <span>Grades</span>
        </a>
        <a href="${pageContext.request.contextPath}/logout" class="menu-item">
            <i class="fas fa-sign-out-alt"></i>
            <span>Logout</span>
        </a>
    </div>
    
    <!-- Main Content -->
    <div class="main-content">
        <div class="search-bar">
            <input type="text" class="search-input" placeholder="Search">
        </div>
        
        <!-- Welcome Banner with Illustration -->
        <div class="welcome-banner">
            <div class="welcome-date">
                <jsp:useBean id="now" class="java.util.Date"/>
                ${String.format("%tB %td, %tY", now, now, now)}
            </div>
            <h1 class="welcome-title">Welcome back, ${sessionScope.user.firstName}!</h1>
            <p class="welcome-subtitle">Always stay updated in your student portal</p>
            <div class="welcome-illustration">
                🎓
            </div>
        </div>
        
        <!-- Dashboard Grid -->
        <div class="dashboard-grid">
            <!-- Personal Information Card -->
            <div class="info-card">
                <h3>Personal Information</h3>
                <div class="personal-info">
                    <div class="info-grid">
                        <div class="info-item">
                            <div class="info-label">Name:</div>
                            <div class="info-value">${sessionScope.user.firstName} ${sessionScope.user.lastName}</div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Student ID:</div>
                            <div class="info-value">${sessionScope.user.studentID}</div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Email:</div>
                            <div class="info-value">${sessionScope.user.email}</div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">DOB:</div>
                            <div class="info-value">${sessionScope.user.dateOfBirth}</div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Major:</div>
                            <div class="info-value">Computer Science</div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Status:</div>
                            <div class="info-value">Active</div>
                        </div>
                    </div>
                </div>
                
                <h3 style="margin-top: 30px;">Progress</h3>
                <div class="chart-placeholder">
                    <i class="fas fa-chart-line" style="font-size: 48px;"></i>
                </div>
            </div>
            
            <!-- Student Information Card -->
            <div class="info-card">
                <h3>Student Information</h3>
                <div class="student-info-card">
                    <div class="student-info-item">
                        <span class="student-label">Roll Number:</span>
                        <span class="student-value">${sessionScope.user.studentID}</span>
                    </div>
                    <div class="student-info-item">
                        <span class="student-label">Degree:</span>
                        <span class="student-value">Bachelor</span>
                    </div>
                    <div class="student-info-item">
                        <span class="student-label">Batch:</span>
                        <span class="student-value">2024</span>
                    </div>
                    <div class="student-info-item">
                        <span class="student-label">Section:</span>
                        <span class="student-value">A</span>
                    </div>
                    <div class="student-info-item">
                        <span class="student-label">Campus:</span>
                        <span class="student-value">University of Rwanda</span>
                    </div>
                    <div class="student-info-item">
                        <span class="student-label">Status:</span>
                        <span class="student-value">Current</span>
                    </div>
                </div>
                
                <h3 style="margin-top: 30px;">University GPA</h3>
                <div class="chart-placeholder">
                    <i class="fas fa-chart-bar" style="font-size: 48px;"></i>
                </div>
            </div>
        </div>
        
        <!-- My Courses Section -->
        <div class="section">
            <h3>My Courses</h3>
            <c:choose>
                <c:when test="${not empty courses}">
                    <table>
                        <thead>
                            <tr>
                                <th>Course Code</th>
                                <th>Course Name</th>
                                <th>Instructor</th>
                                <th>Credits</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="course" items="${courses}">
                                <tr>
                                    <td><strong>${course.courseCode}</strong></td>
                                    <td>${course.courseName}</td>
                                    <td>${course.instructorName}</td>
                                    <td>${course.credits}</td>
                                    <td><span class="badge badge-active">Active</span></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="no-data">
                        <i class="fas fa-book-open" style="font-size: 48px; margin-bottom: 15px; display: block;"></i>
                        No courses enrolled yet
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        
        <!-- Pending Assignments Section -->
        <div class="section">
            <h3>Pending Assignments</h3>
            <c:choose>
                <c:when test="${not empty assignments}">
                    <table>
                        <thead>
                            <tr>
                                <th>Assignment</th>
                                <th>Course</th>
                                <th>Due Date</th>
                                <th>Max Points</th>
                                <th>Type</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="assignment" items="${assignments}">
                                <c:if test="${!assignment.submitted}">
                                    <tr>
                                        <td><strong>${assignment.title}</strong></td>
                                        <td>${assignment.courseName}</td>
                                        <td>${assignment.dueDate}</td>
                                        <td>${assignment.maxPoints} points</td>
                                        <td><span class="badge badge-pending">${assignment.assignmentType != null ? assignment.assignmentType : 'ESSAY'}</span></td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/student/take-assignment?id=${assignment.assignmentID}" 
                                               class="btn-take-assignment">
                                                <i class="fas fa-edit"></i> Take Assignment
                                            </a>
                                        </td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="no-data">
                        <i class="fas fa-check-circle" style="font-size: 48px; margin-bottom: 15px; display: block; color: #28A745;"></i>
                        All assignments completed!
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>
