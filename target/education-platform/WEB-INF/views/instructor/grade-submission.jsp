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
            padding: 30px;
        }

        .container {
            max-width: 1000px;
            margin: 0 auto;
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

        .header-card {
            background: linear-gradient(135deg, #1e3a5f 0%, #2a5080 100%);
            color: white;
            padding: 30px;
            border-radius: 15px;
            margin-bottom: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }

        .header-card h1 {
            font-size: 28px;
            margin-bottom: 15px;
            color: #FBC02D;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin-top: 20px;
        }

        .info-item {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .info-item i {
            color: #FBC02D;
        }

        .content-card {
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 30px;
        }

        .content-card h2 {
            color: #1e3a5f;
            margin-bottom: 20px;
            font-size: 22px;
            border-bottom: 2px solid #FBC02D;
            padding-bottom: 10px;
        }

        .question-item {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            border-left: 4px solid #1e3a5f;
        }

        .question-text {
            font-size: 16px;
            font-weight: 600;
            color: #1e3a5f;
            margin-bottom: 15px;
        }

        .answer-row {
            display: grid;
            grid-template-columns: 1fr 1fr 1fr;
            gap: 15px;
            margin-top: 10px;
        }

        .answer-item {
            padding: 12px;
            border-radius: 8px;
            font-size: 14px;
        }

        .answer-correct {
            background: #d4edda;
            color: #155724;
            border: 2px solid #28a745;
            font-weight: 600;
        }

        .answer-incorrect {
            background: #f8d7da;
            color: #721c24;
            border: 2px solid #dc3545;
        }

        .answer-neutral {
            background: #e9ecef;
            color: #495057;
        }

        .essay-content {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            border-left: 4px solid #1e3a5f;
            white-space: pre-wrap;
            font-size: 15px;
            line-height: 1.8;
            color: #2c3e50;
        }

        .grade-form {
            background: linear-gradient(135deg, #ecf0f1 0%, #d5dbdb 100%);
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #1e3a5f;
            font-size: 15px;
        }

        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #bdc3c7;
            border-radius: 8px;
            font-size: 15px;
            font-family: inherit;
            transition: all 0.3s;
        }

        .form-group input:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #FBC02D;
            box-shadow: 0 0 0 3px rgba(251, 192, 45, 0.1);
        }

        .form-group textarea {
            min-height: 120px;
            resize: vertical;
        }

        .score-input-wrapper {
            position: relative;
        }

        .score-input-wrapper .max-points {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #7f8c8d;
            font-weight: 600;
        }

        .btn-container {
            display: flex;
            gap: 15px;
            justify-content: flex-end;
        }

        .btn {
            padding: 12px 30px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s;
        }

        .btn-primary {
            background: #FBC02D;
            color: #1e3a5f;
        }

        .btn-primary:hover {
            background: #f9b000;
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(251, 192, 45, 0.4);
        }

        .btn-secondary {
            background: #7f8c8d;
            color: white;
        }

        .btn-secondary:hover {
            background: #95a5a6;
        }

        .current-grade {
            background: #1e3a5f;
            color: white;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .current-grade .score {
            font-size: 32px;
            font-weight: 700;
            color: #FBC02D;
        }

        .badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }

        .badge-graded {
            background: #27ae60;
            color: white;
        }

        .badge-pending {
            background: #f39c12;
            color: white;
        }
        
        /* Responsive Design */
        @media (max-width: 768px) {
            .container {
                padding: 20px 15px;
                max-width: 100%;
            }
            
            .header-card {
                padding: 25px 20px;
            }
            
            .header-card h1 {
                font-size: 22px;
            }
            
            .student-info {
                flex-direction: column;
                gap: 15px;
            }
            
            .info-item {
                padding: 15px;
            }
            
            .content-card {
                padding: 25px 20px;
            }
            
            .section-title {
                font-size: 18px;
            }
            
            .mcq-question {
                padding: 20px 15px;
            }
            
            .essay-content {
                padding: 20px 15px;
            }
            
            .grade-form .form-group {
                margin-bottom: 20px;
            }
            
            .submit-btn {
                width: 100%;
                padding: 14px;
            }
        }
        
        @media (max-width: 576px) {
            .container {
                padding: 15px 10px;
            }
            
            .back-btn {
                padding: 10px 16px;
                font-size: 13px;
            }
            
            .header-card {
                padding: 20px 15px;
            }
            
            .header-card h1 {
                font-size: 20px;
            }
            
            .info-item {
                padding: 12px;
            }
            
            .info-item .label {
                font-size: 11px;
            }
            
            .info-item .value {
                font-size: 14px;
            }
            
            .content-card {
                padding: 20px 15px;
            }
            
            .current-grade .score {
                font-size: 24px;
            }
            
            .mcq-question {
                padding: 15px 12px;
            }
            
            .question-number {
                width: 28px;
                height: 28px;
                font-size: 13px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="${pageContext.request.contextPath}/instructor/view-submissions?assignmentId=${submission.assignmentID}" class="back-btn">
            <i class="fas fa-arrow-left"></i> Back to Submissions
        </a>

        <div class="header-card">
            <h1><i class="fas fa-user-graduate"></i> ${submission.studentName}'s Submission</h1>
            <div class="info-grid">
                <div class="info-item">
                    <i class="fas fa-book"></i>
                    <span>${submission.assignmentTitle}</span>
                </div>
                <div class="info-item">
                    <i class="fas fa-envelope"></i>
                    <span>${submission.studentEmail}</span>
                </div>
                <div class="info-item">
                    <i class="fas fa-clock"></i>
                    <span>Submitted: ${submission.submissionDate}</span>
                </div>
                <div class="info-item">
                    <i class="fas fa-layer-group"></i>
                    <span>Type: ${submission.assignmentType}</span>
                </div>
            </div>
        </div>

        <c:if test="${submission.status == 'GRADED' || submission.status == 'Graded'}">
            <div class="current-grade">
                <div>
                    <span class="badge badge-graded">Already Graded</span>
                    <div style="margin-top: 10px; font-size: 16px;">Current Score</div>
                </div>
                <div class="score">${submission.score} / ${submission.maxPoints}</div>
            </div>
        </c:if>

        <div class="content-card">
            <h2><i class="fas fa-clipboard-check"></i> Student's Work</h2>

            <c:choose>
                <c:when test="${submission.assignmentType == 'MCQ'}">
                    <c:forEach var="answer" items="${submission.studentAnswers}" varStatus="status">
                        <div class="question-item">
                            <div class="question-text">
                                Question ${status.index + 1}: ${answer.questionText}
                            </div>
                            <div class="answer-row">
                                <div class="answer-item ${answer.correct ? 'answer-neutral' : 'answer-neutral'}">
                                    <strong>Student's Answer:</strong> ${answer.selectedAnswer}
                                </div>
                                <div class="answer-item answer-correct">
                                    <strong>Correct Answer:</strong> ${answer.correctAnswer}
                                </div>
                                <div class="answer-item ${answer.correct ? 'answer-correct' : 'answer-incorrect'}">
                                    <i class="fas ${answer.correct ? 'fa-check-circle' : 'fa-times-circle'}"></i>
                                    ${answer.correct ? 'Correct' : 'Incorrect'}
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="essay-content">
                        ${submission.essayAnswer != null ? submission.essayAnswer : 'No answer provided.'}
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="content-card">
            <h2><i class="fas fa-star"></i> Grade Submission</h2>

            <form action="${pageContext.request.contextPath}/instructor/submit-grade" method="post" class="grade-form">
                <input type="hidden" name="submissionId" value="${submission.submissionID}">
                <input type="hidden" name="assignmentId" value="${submission.assignmentID}">

                <div class="form-group">
                    <label for="score">
                        <i class="fas fa-trophy"></i> Score (out of ${submission.maxPoints})
                    </label>
                    <div class="score-input-wrapper">
                        <input 
                            type="number" 
                            id="score" 
                            name="score" 
                            min="0" 
                            max="${submission.maxPoints}" 
                            step="0.5" 
                            value="${submission.score != null ? submission.score : ''}" 
                            required
                            style="padding-right: 100px;"
                        >
                        <span class="max-points">/ ${submission.maxPoints}</span>
                    </div>
                </div>

                <div class="form-group">
                    <label for="feedback">
                        <i class="fas fa-comment"></i> Feedback (Optional)
                    </label>
                    <textarea 
                        id="feedback" 
                        name="feedback" 
                        placeholder="Provide feedback to help the student improve..."
                    >${submission.feedback != null ? submission.feedback : ''}</textarea>
                </div>

                <div class="btn-container">
                    <a href="${pageContext.request.contextPath}/instructor/view-submissions?assignmentId=${submission.assignmentID}" class="btn btn-secondary">
                        <i class="fas fa-times"></i> Cancel
                    </a>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i> Submit Grade
                    </button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
