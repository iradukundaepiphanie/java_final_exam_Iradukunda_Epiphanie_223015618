<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${assignment.title}</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #5B6EC7 0%, #7B8FD9 100%);
            min-height: 100vh;
            padding: 30px;
        }
        .container {
            max-width: 900px;
            margin: 0 auto;
        }
        .timer-bar {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            background: #2c3e50;
            color: white;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            z-index: 1000;
            box-shadow: 0 4px 20px rgba(0,0,0,0.3);
        }
        .timer-info {
            display: flex;
            align-items: center;
            gap: 20px;
        }
        .timer-display {
            background: #e74c3c;
            padding: 10px 20px;
            border-radius: 25px;
            font-size: 18px;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 10px;
            animation: pulse 2s infinite;
        }
        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }
        .timer-display.warning {
            background: #f39c12;
            animation: pulse 1s infinite;
        }
        .timer-display.danger {
            background: #c0392b;
            animation: pulse 0.5s infinite;
        }
        .content-wrapper {
            margin-top: 80px;
        }
        .header {
            background: white;
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
            margin-bottom: 25px;
        }
        .header h1 {
            color: #2c3e50;
            margin-bottom: 15px;
            font-size: 28px;
        }
        .assignment-info {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        .info-item {
            display: flex;
            align-items: center;
            gap: 10px;
            color: #7f8c8d;
        }
        .info-item i {
            color: #FBC02D;
            font-size: 18px;
        }
        .quiz-card {
            background: white;
            padding: 35px;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
            margin-bottom: 25px;
        }
        .question-block {
            margin-bottom: 35px;
            padding-bottom: 30px;
            border-bottom: 2px solid #e9ecef;
        }
        .question-block:last-child {
            border-bottom: none;
            margin-bottom: 0;
        }
        .question-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .question-number {
            background: linear-gradient(135deg, #5B6EC7, #7B8FD9);
            color: white;
            padding: 10px 20px;
            border-radius: 25px;
            font-weight: 600;
            font-size: 16px;
        }
        .question-points {
            color: #27ae60;
            font-weight: 600;
            font-size: 14px;
        }
        .question-text {
            color: #2c3e50;
            font-size: 18px;
            font-weight: 500;
            margin-bottom: 20px;
            line-height: 1.6;
        }
        .options-list {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }
        .option-item {
            position: relative;
        }
        .option-item input[type="radio"] {
            position: absolute;
            opacity: 0;
        }
        .option-label {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 18px 22px;
            border: 2px solid #e9ecef;
            border-radius: 12px;
            cursor: pointer;
            transition: all 0.3s;
            background: #f8f9fa;
        }
        .option-item input:checked + .option-label {
            border-color: #5B6EC7;
            background: linear-gradient(135deg, rgba(91, 110, 199, 0.1), rgba(123, 143, 217, 0.1));
            box-shadow: 0 4px 15px rgba(91, 110, 199, 0.2);
        }
        .option-letter {
            background: linear-gradient(135deg, #5B6EC7, #7B8FD9);
            color: white;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            font-size: 16px;
            flex-shrink: 0;
        }
        .option-item input:checked + .option-label .option-letter {
            background: linear-gradient(135deg, #FBC02D, #FFD54F);
        }
        .option-text {
            color: #2c3e50;
            font-size: 16px;
            flex: 1;
        }
        .essay-section {
            margin-top: 20px;
        }
        .essay-textarea {
            width: 100%;
            min-height: 300px;
            padding: 20px;
            border: 2px solid #e9ecef;
            border-radius: 12px;
            font-family: inherit;
            font-size: 15px;
            line-height: 1.8;
            resize: vertical;
            transition: all 0.3s;
        }
        .essay-textarea:focus {
            outline: none;
            border-color: #5B6EC7;
            box-shadow: 0 0 0 4px rgba(91, 110, 199, 0.1);
        }
        .word-count {
            text-align: right;
            color: #7f8c8d;
            margin-top: 8px;
            font-size: 14px;
        }
        .submit-section {
            background: white;
            padding: 25px 35px;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .btn {
            padding: 16px 40px;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            text-decoration: none;
        }
        .btn-submit {
            background: linear-gradient(135deg, #FBC02D, #FFD54F);
            color: #2c3e50;
        }
        .btn-submit:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(251, 192, 45, 0.4);
        }
        .btn-cancel {
            background: #e9ecef;
            color: #2c3e50;
        }
        .progress-info {
            color: #7f8c8d;
        }
        .progress-info strong {
            color: #2c3e50;
        }
        .auto-grade-badge {
            background: #d4edda;
            color: #155724;
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        .hidden {
            display: none;
        }
    </style>
</head>
<body>
    <div class="timer-bar<c:if test='${!assignment.timed}'> hidden</c:if>" id="timerBar">
        <div class="timer-info">
            <span style="font-weight: 600;">${assignment.title}</span>
            <c:if test="${assignment.timed}">
                <div class="timer-display" id="timerDisplay">
                    <i class="fas fa-clock"></i>
                    <span id="timeRemaining">--:--</span>
                </div>
            </c:if>
        </div>
        <c:if test="${assignment.assignmentType == 'MCQ'}">
            <span class="auto-grade-badge">
                <i class="fas fa-bolt"></i> AUTO-GRADED
            </span>
        </c:if>
    </div>
    
    <div class="container content-wrapper">
        <div class="header">
            <h1><i class="fas fa-file-alt"></i> ${assignment.title}</h1>
            <p style="color: #7f8c8d; margin-bottom: 20px;">${assignment.description}</p>
            
            <div class="assignment-info">
                <div class="info-item">
                    <i class="fas fa-book"></i>
                    <span>${assignment.courseName}</span>
                </div>
                <div class="info-item">
                    <i class="fas fa-star"></i>
                    <span>${assignment.maxPoints} Points</span>
                </div>
                <div class="info-item">
                    <i class="fas fa-calendar"></i>
                    <span>Due: ${assignment.dueDate}</span>
                </div>
                <c:if test="${assignment.timed}">
                    <div class="info-item">
                        <i class="fas fa-hourglass-half"></i>
                        <span>${assignment.timeLimit} minutes</span>
                    </div>
                </c:if>
            </div>
        </div>
        
        <form action="${pageContext.request.contextPath}/student/submit-assignment" method="post" id="assignmentForm">
            <input type="hidden" name="assignmentId" value="${assignment.assignmentID}">
            <input type="hidden" name="assignmentType" value="${assignment.assignmentType}">
            
            <c:choose>
                <c:when test="${assignment.assignmentType == 'MCQ'}">
                    <div class="quiz-card">
                        <c:forEach var="question" items="${assignment.questions}" varStatus="status">
                            <div class="question-block">
                                <div class="question-header">
                                    <span class="question-number">Question ${status.index + 1}</span>
                                    <span class="question-points"><i class="fas fa-award"></i> ${question.points} point${question.points > 1 ? 's' : ''}</span>
                                </div>
                                
                                <div class="question-text">${question.questionText}</div>
                                
                                <div class="options-list">
                                    <div class="option-item">
                                        <input type="radio" name="answer_${question.questionID}" id="q${question.questionID}_a" value="A" required>
                                        <label for="q${question.questionID}_a" class="option-label">
                                            <span class="option-letter">A</span>
                                            <span class="option-text">${question.optionA}</span>
                                        </label>
                                    </div>
                                    
                                    <div class="option-item">
                                        <input type="radio" name="answer_${question.questionID}" id="q${question.questionID}_b" value="B">
                                        <label for="q${question.questionID}_b" class="option-label">
                                            <span class="option-letter">B</span>
                                            <span class="option-text">${question.optionB}</span>
                                        </label>
                                    </div>
                                    
                                    <div class="option-item">
                                        <input type="radio" name="answer_${question.questionID}" id="q${question.questionID}_c" value="C">
                                        <label for="q${question.questionID}_c" class="option-label">
                                            <span class="option-letter">C</span>
                                            <span class="option-text">${question.optionC}</span>
                                        </label>
                                    </div>
                                    
                                    <div class="option-item">
                                        <input type="radio" name="answer_${question.questionID}" id="q${question.questionID}_d" value="D">
                                        <label for="q${question.questionID}_d" class="option-label">
                                            <span class="option-letter">D</span>
                                            <span class="option-text">${question.optionD}</span>
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                
                <c:otherwise>
                    <div class="quiz-card">
                        <div class="essay-section">
                            <label style="color: #2c3e50; font-weight: 600; font-size: 18px; margin-bottom: 15px; display: block;">
                                <i class="fas fa-pen"></i> Your Answer
                            </label>
                            <textarea name="essayAnswer" class="essay-textarea" id="essayText" 
                                      placeholder="Type your answer here..." required></textarea>
                            <div class="word-count">
                                <span id="wordCount">0</span> words
                            </div>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
            
            <div class="submit-section">
                <div class="progress-info">
                    <c:choose>
                        <c:when test="${assignment.assignmentType == 'MCQ'}">
                            <i class="fas fa-list-check"></i> 
                            <strong>${assignment.questions.size()}</strong> questions total
                        </c:when>
                        <c:otherwise>
                            <i class="fas fa-info-circle"></i> 
                            <strong>Essay Assignment</strong> - Will be manually graded
                        </c:otherwise>
                    </c:choose>
                </div>
                
                <div style="display: flex; gap: 15px;">
                    <a href="${pageContext.request.contextPath}/student/assignments" class="btn btn-cancel">
                        <i class="fas fa-times"></i> Cancel
                    </a>
                    <button type="submit" class="btn btn-submit" onclick="return confirm('Are you sure you want to submit? You cannot change your answers after submission.')">
                        <i class="fas fa-paper-plane"></i> Submit Assignment
                    </button>
                </div>
            </div>
        </form>
    </div>
    
    <script type="text/jsp">
        // Set variables from server-side data
        var isTimed = ${assignment.timed};
        var isEssay = ${assignment.assignmentType == 'ESSAY'};
        var timeLimit = ${assignment.timeLimit} * 60;

        // Timer functionality
        if (isTimed) {
            let timeRemaining = timeLimit;

            function updateTimer() {
                const minutes = Math.floor(timeRemaining / 60);
                const seconds = timeRemaining % 60;
                const display = document.getElementById('timeRemaining');
                const timerDisplay = document.getElementById('timerDisplay');

                display.textContent = minutes + ':' + (seconds < 10 ? '0' : '') + seconds;

                // Change color based on time remaining
                if (timeRemaining <= 60) {
                    timerDisplay.className = 'timer-display danger';
                } else if (timeRemaining <= 300) {
                    timerDisplay.className = 'timer-display warning';
                }

                if (timeRemaining <= 0) {
                    alert('Time is up! Your assignment will be auto-submitted.');
                    document.getElementById('assignmentForm').submit();
                }

                timeRemaining--;
            }

            updateTimer();
            setInterval(updateTimer, 1000);
        }

        // Word counter for essay
        if (isEssay) {
            document.getElementById('essayText').addEventListener('input', function() {
                const text = this.value.trim();
                const words = text ? text.split(/\s+/).length : 0;
                document.getElementById('wordCount').textContent = words;
            });
        }

        // Prevent accidental navigation
        window.addEventListener('beforeunload', function(e) {
            e.preventDefault();
            e.returnValue = '';
        });

        // Remove warning when submitting
        document.getElementById('assignmentForm').addEventListener('submit', function() {
            window.removeEventListener('beforeunload', function() {});
        });
    </script>
</body>
</html>
