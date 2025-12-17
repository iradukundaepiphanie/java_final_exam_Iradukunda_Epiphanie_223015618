<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Assignment Result</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .result-container {
            max-width: 700px;
            width: 100%;
        }
        .success-animation {
            text-align: center;
            margin-bottom: 30px;
        }
        .checkmark-circle {
            width: 120px;
            height: 120px;
            margin: 0 auto;
            border-radius: 50%;
            background: white;
            display: flex;
            align-items: center;
            justify-content: center;
            animation: scaleIn 0.5s ease-in-out;
        }
        @keyframes scaleIn {
            0% { transform: scale(0); }
            50% { transform: scale(1.1); }
            100% { transform: scale(1); }
        }
        .checkmark {
            font-size: 60px;
            color: #27ae60;
            animation: checkmark 0.8s ease-in-out 0.3s both;
        }
        @keyframes checkmark {
            0% { transform: scale(0) rotate(0deg); }
            50% { transform: scale(1.2) rotate(180deg); }
            100% { transform: scale(1) rotate(360deg); }
        }
        .result-card {
            background: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            text-align: center;
        }
        .result-card h1 {
            color: #2c3e50;
            margin-bottom: 15px;
            font-size: 32px;
        }
        .result-card p {
            color: #7f8c8d;
            margin-bottom: 30px;
            font-size: 16px;
        }
        .score-display {
            background: linear-gradient(135deg, #f093fb, #f5576c);
            color: white;
            padding: 30px;
            border-radius: 15px;
            margin-bottom: 30px;
        }
        .score-display h2 {
            font-size: 48px;
            margin-bottom: 10px;
        }
        .score-display p {
            color: white;
            opacity: 0.95;
            font-size: 18px;
            margin: 0;
        }
        .score-breakdown {
            background: #f8f9fa;
            padding: 25px;
            border-radius: 12px;
            margin-bottom: 25px;
        }
        .breakdown-item {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid #e9ecef;
        }
        .breakdown-item:last-child {
            border-bottom: none;
        }
        .breakdown-label {
            color: #7f8c8d;
            font-weight: 500;
        }
        .breakdown-value {
            color: #2c3e50;
            font-weight: 600;
        }
        .correct-answer {
            color: #27ae60;
        }
        .incorrect-answer {
            color: #e74c3c;
        }
        .pending-badge {
            background: #fff3cd;
            color: #856404;
            padding: 15px 25px;
            border-radius: 12px;
            margin-bottom: 25px;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            font-weight: 600;
        }
        .btn-group {
            display: flex;
            gap: 15px;
            justify-content: center;
        }
        .btn {
            padding: 14px 35px;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 10px;
        }
        .btn-primary {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
        }
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
        }
        .btn-secondary {
            background: #e9ecef;
            color: #2c3e50;
        }
        .grade-letter {
            font-size: 64px;
            font-weight: 700;
            margin-bottom: 10px;
        }
        .grade-a { color: #27ae60; }
        .grade-b { color: #3498db; }
        .grade-c { color: #f39c12; }
        .grade-d { color: #e67e22; }
        .grade-f { color: #e74c3c; }
    </style>
</head>
<body>
    <div class="result-container">
        <div class="success-animation">
            <div class="checkmark-circle">
                <i class="fas fa-check checkmark"></i>
            </div>
        </div>
        
        <div class="result-card">
            <h1>
                <c:choose>
                    <c:when test="${result.autoGraded}">Assignment Submitted!</c:when>
                    <c:otherwise>Assignment Submitted!</c:otherwise>
                </c:choose>
            </h1>
            <p>Your work has been successfully submitted</p>
            
            <c:choose>
                <c:when test="${result.autoGraded}">
                    <div class="score-display">
                        <div class="grade-letter grade-${result.gradeLetter}">${result.gradeLetter}</div>
                        <h2>${result.score} / ${result.maxPoints}</h2>
                        <p>${result.percentage}% - ${result.gradeText}</p>
                    </div>
                    
                    <div class="score-breakdown">
                        <div class="breakdown-item">
                            <span class="breakdown-label"><i class="fas fa-check-circle"></i> Correct Answers</span>
                            <span class="breakdown-value correct-answer">${result.correctAnswers}</span>
                        </div>
                        <div class="breakdown-item">
                            <span class="breakdown-label"><i class="fas fa-times-circle"></i> Incorrect Answers</span>
                            <span class="breakdown-value incorrect-answer">${result.incorrectAnswers}</span>
                        </div>
                        <div class="breakdown-item">
                            <span class="breakdown-label"><i class="fas fa-list"></i> Total Questions</span>
                            <span class="breakdown-value">${result.totalQuestions}</span>
                        </div>
                        <div class="breakdown-item">
                            <span class="breakdown-label"><i class="fas fa-award"></i> Points Earned</span>
                            <span class="breakdown-value">${result.score} points</span>
                        </div>
                    </div>
                </c:when>
                
                <c:otherwise>
                    <div class="pending-badge">
                        <i class="fas fa-clock"></i>
                        Pending Manual Grading
                    </div>
                    <p style="margin-bottom: 25px;">
                        Your instructor will review and grade your assignment. 
                        You'll receive your grade soon.
                    </p>
                </c:otherwise>
            </c:choose>
            
            <div class="btn-group">
                <a href="${pageContext.request.contextPath}/student/assignments" class="btn btn-secondary">
                    <i class="fas fa-list"></i> View All Assignments
                </a>
                <a href="${pageContext.request.contextPath}/student/grades" class="btn btn-primary">
                    <i class="fas fa-chart-line"></i> View My Grades
                </a>
            </div>
        </div>
    </div>
</body>
</html>
