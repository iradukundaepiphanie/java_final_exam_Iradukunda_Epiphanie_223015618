<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Submissions - ${assignment.title}</title>
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
            border-left: 3px solid transparent;
        }

        .menu-item:hover {
            background: rgba(251, 192, 45, 0.1);
            border-left-color: #FBC02D;
        }

        .menu-item.active {
            background: rgba(251, 192, 45, 0.15);
            border-left-color: #FBC02D;
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
            color: #1e3a5f;
            margin-bottom: 5px;
        }

        .section {
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 30px;
        }

        .assignment-details {
            background: linear-gradient(135deg, #1e3a5f 0%, #2a5080 100%);
            color: white;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 30px;
        }

        .assignment-details h3 {
            font-size: 20px;
            margin-bottom: 15px;
            color: #FBC02D;
        }

        .detail-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
        }

        .detail-item {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .detail-item i {
            color: #FBC02D;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        thead {
            background: linear-gradient(135deg, #1e3a5f 0%, #2a5080 100%);
            color: white;
        }

        th {
            padding: 15px;
            text-align: left;
            font-weight: 600;
        }

        td {
            padding: 15px;
            border-bottom: 1px solid #ecf0f1;
        }

        tbody tr:hover {
            background: #f8f9fa;
        }

        .badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            display: inline-block;
        }

        .badge-submitted {
            background: #3498db;
            color: white;
        }

        .badge-graded {
            background: #27ae60;
            color: white;
        }

        .badge-pending {
            background: #f39c12;
            color: white;
        }

        .action-btn {
            padding: 8px 16px;
            background: #FBC02D;
            color: #1e3a5f;
            text-decoration: none;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s;
        }

        .action-btn:hover {
            background: #f9b000;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(251, 192, 45, 0.3);
        }

        .back-btn {
            padding: 10px 20px;
            background: #7f8c8d;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 20px;
        }

        .back-btn:hover {
            background: #95a5a6;
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

        .success-message {
            background: #d4edda;
            color: #155724;
            padding: 15px 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            border-left: 4px solid #28a745;
        }

        .score-display {
            font-weight: 700;
            font-size: 16px;
        }

        .score-good {
            color: #27ae60;
        }

        .score-medium {
            color: #f39c12;
        }

        .score-low {
            color: #e74c3c;
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="sidebar-header">
            <h2><i class="fas fa-chalkboard-teacher"></i> UR Instructor</h2>
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
        <a href="${pageContext.request.contextPath}/instructor/my-assignments" class="menu-item">
            <i class="fas fa-list"></i>
            <span>My Assignments</span>
        </a>
        <a href="${pageContext.request.contextPath}/instructor/grade-submissions" class="menu-item active">
            <i class="fas fa-check-circle"></i>
            <span>Grade Submissions</span>
        </a>
        <a href="${pageContext.request.contextPath}/logout" class="menu-item">
            <i class="fas fa-sign-out-alt"></i>
            <span>Logout</span>
        </a>
    </div>

    <div class="main-content">
        <a href="${pageContext.request.contextPath}/instructor/grade-submissions" class="back-btn">
            <i class="fas fa-arrow-left"></i> Back to Assignments
        </a>

        <div class="top-bar">
            <h1><i class="fas fa-clipboard-list"></i> Student Submissions</h1>
            <p style="color: #7f8c8d; margin-top: 5px;">Review and grade student work</p>
        </div>

        <c:if test="${param.success == 'graded'}">
            <div class="success-message">
                <i class="fas fa-check-circle"></i> Grade submitted successfully!
            </div>
        </c:if>

        <div class="assignment-details">
            <h3>${assignment.title}</h3>
            <div class="detail-grid">
                <div class="detail-item">
                    <i class="fas fa-book"></i>
                    <span>${assignment.courseName}</span>
                </div>
                <div class="detail-item">
                    <i class="fas fa-calendar"></i>
                    <span>Due: ${assignment.dueDate}</span>
                </div>
                <div class="detail-item">
                    <i class="fas fa-star"></i>
                    <span>Max Points: ${assignment.maxPoints}</span>
                </div>
                <div class="detail-item">
                    <i class="fas fa-layer-group"></i>
                    <span>Type: ${assignment.assignmentType}</span>
                </div>
            </div>
        </div>

        <div class="section">
            <h2 style="margin-bottom: 20px; color: #1e3a5f;">Submissions (${submissions.size()})</h2>

            <c:choose>
                <c:when test="${not empty submissions}">
                    <table>
                        <thead>
                            <tr>
                                <th>Student</th>
                                <th>Email</th>
                                <th>Submitted At</th>
                                <th>Status</th>
                                <th>Score</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="submission" items="${submissions}">
                                <tr>
                                    <td><strong>${submission.studentName}</strong></td>
                                    <td>${submission.studentEmail}</td>
                                    <td>${submission.submissionDate}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${submission.status == 'GRADED' || submission.status == 'Graded'}">
                                                <span class="badge badge-graded">Graded</span>
                                            </c:when>
                                            <c:when test="${submission.status == 'SUBMITTED' || submission.status == 'Submitted'}">
                                                <span class="badge badge-submitted">Needs Grading</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-pending">${submission.status}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${submission.score != null && submission.score > 0}">
                                                <c:set var="percentage" value="${(submission.score / assignment.maxPoints) * 100}" />
                                                <span class="score-display ${percentage >= 80 ? 'score-good' : percentage >= 60 ? 'score-medium' : 'score-low'}">
                                                    ${submission.score} / ${assignment.maxPoints}
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span style="color: #7f8c8d;">Not graded</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/instructor/grade-submission?submissionId=${submission.submissionID}" class="action-btn">
                                            <i class="fas fa-edit"></i> 
                                            <c:choose>
                                                <c:when test="${submission.status == 'GRADED' || submission.status == 'Graded'}">
                                                    Review
                                                </c:when>
                                                <c:otherwise>
                                                    Grade
                                                </c:otherwise>
                                            </c:choose>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="no-data">
                        <i class="fas fa-inbox"></i>
                        <p>No submissions yet for this assignment.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>
