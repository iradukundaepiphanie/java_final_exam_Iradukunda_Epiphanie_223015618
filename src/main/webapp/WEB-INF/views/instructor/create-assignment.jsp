<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Assignment</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 30px;
        }
        .container {
            max-width: 900px;
            margin: 0 auto;
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
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .header h1 i {
            color: #f093fb;
        }
        .back-link {
            color: #667eea;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            font-weight: 600;
            margin-bottom: 15px;
        }
        .back-link:hover {
            text-decoration: underline;
        }
        .form-card {
            background: white;
            padding: 35px;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
            margin-bottom: 25px;
        }
        .section-title {
            color: #2c3e50;
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 25px;
            padding-bottom: 12px;
            border-bottom: 3px solid #f093fb;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 25px;
        }
        .form-group.full-width {
            grid-column: 1 / -1;
        }
        .form-group label {
            display: block;
            color: #2c3e50;
            font-weight: 600;
            margin-bottom: 10px;
            font-size: 14px;
        }
        .form-group label i {
            color: #f093fb;
            margin-right: 8px;
        }
        .form-group input, .form-group select, .form-group textarea {
            width: 100%;
            padding: 14px 18px;
            border: 2px solid #e9ecef;
            border-radius: 12px;
            font-size: 15px;
            font-family: inherit;
            transition: all 0.3s;
        }
        .form-group input:focus, .form-group select:focus, .form-group textarea:focus {
            outline: none;
            border-color: #f093fb;
            box-shadow: 0 0 0 4px rgba(240, 147, 251, 0.1);
        }
        .form-group textarea {
            min-height: 120px;
            resize: vertical;
        }
        .type-selector {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 30px;
        }
        .type-option {
            position: relative;
        }
        .type-option input[type="radio"] {
            position: absolute;
            opacity: 0;
        }
        .type-card {
            padding: 25px;
            border: 3px solid #e9ecef;
            border-radius: 15px;
            cursor: pointer;
            transition: all 0.3s;
            text-align: center;
            background: #f8f9fa;
        }
        .type-card i {
            font-size: 40px;
            color: #7f8c8d;
            margin-bottom: 15px;
        }
        .type-card h3 {
            color: #2c3e50;
            margin-bottom: 8px;
            font-size: 18px;
        }
        .type-card p {
            color: #7f8c8d;
            font-size: 13px;
        }
        .type-option input:checked + .type-card {
            border-color: #f093fb;
            background: linear-gradient(135deg, #f093fb, #f5576c);
            box-shadow: 0 8px 25px rgba(240, 147, 251, 0.3);
        }
        .type-option input:checked + .type-card i,
        .type-option input:checked + .type-card h3,
        .type-option input:checked + .type-card p {
            color: white;
        }
        .mcq-section {
            display: none;
            animation: fadeIn 0.3s;
        }
        .mcq-section.active {
            display: block;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .question-item {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 20px;
            border-left: 4px solid #f093fb;
        }
        .question-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }
        .question-number {
            background: linear-gradient(135deg, #f093fb, #f5576c);
            color: white;
            padding: 8px 16px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 14px;
        }
        .btn-remove-question {
            background: #e74c3c;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 13px;
            transition: all 0.3s;
        }
        .btn-remove-question:hover {
            background: #c0392b;
            transform: scale(1.05);
        }
        .option-group {
            margin-top: 15px;
        }
        .option-item {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 12px;
        }
        .option-item input[type="text"] {
            flex: 1;
        }
        .option-item input[type="radio"] {
            width: 20px;
            height: 20px;
            cursor: pointer;
        }
        .option-label {
            font-weight: 600;
            color: #2c3e50;
            min-width: 80px;
        }
        .correct-label {
            color: #27ae60;
            font-weight: 600;
            font-size: 13px;
            min-width: 100px;
        }
        .btn-add-question {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border: none;
            padding: 14px 28px;
            border-radius: 12px;
            cursor: pointer;
            font-size: 15px;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            transition: all 0.3s;
            margin-bottom: 20px;
        }
        .btn-add-question:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.4);
        }
        .time-settings {
            background: #fff3cd;
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 25px;
            border-left: 4px solid #ffc107;
        }
        .time-settings h4 {
            color: #856404;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .checkbox-group {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 15px;
        }
        .checkbox-group input[type="checkbox"] {
            width: 20px;
            height: 20px;
            cursor: pointer;
        }
        .checkbox-group label {
            margin: 0;
            cursor: pointer;
        }
        .btn-group {
            display: flex;
            gap: 15px;
            margin-top: 30px;
            padding-top: 25px;
            border-top: 2px solid #e9ecef;
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
        }
        .btn-primary {
            background: linear-gradient(135deg, #f093fb, #f5576c);
            color: white;
            flex: 1;
        }
        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(240, 147, 251, 0.4);
        }
        .btn-secondary {
            background: #e9ecef;
            color: #2c3e50;
            text-decoration: none;
        }
        .btn-secondary:hover {
            background: #d3d3d3;
        }
        .grading-badge {
            display: inline-block;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            margin-top: 5px;
        }
        .badge-auto {
            background: #d4edda;
            color: #155724;
        }
        .badge-manual {
            background: #d1ecf1;
            color: #0c5460;
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="${pageContext.request.contextPath}/instructor/assignments" class="back-link">
            <i class="fas fa-arrow-left"></i> Back to Assignments
        </a>
        
        <div class="header">
            <h1><i class="fas fa-plus-circle"></i> Create New Assignment</h1>
            <p style="color: #7f8c8d; margin-top: 8px;">Choose assignment type and configure settings</p>
        </div>
        
        <form action="${pageContext.request.contextPath}/instructor/create-assignment" method="post" id="assignmentForm">
            <div class="form-card">
                <div class="section-title">
                    <i class="fas fa-cog"></i> Basic Information
                </div>
                
                <div class="form-group">
                    <label><i class="fas fa-book"></i> Select Course *</label>
                    <select name="courseId" required>
                        <option value="">-- Select Course --</option>
                        <c:forEach var="course" items="${courses}">
                            <option value="${course.courseID}" ${selectedCourseId == course.courseID ? 'selected' : ''}>${course.courseCode} - ${course.courseName}</option>
                        </c:forEach>
                    </select>
                </div>
                
                <div class="form-group">
                    <label><i class="fas fa-heading"></i> Assignment Title *</label>
                    <input type="text" name="title" required placeholder="e.g., Java Programming - Week 1 Quiz">
                </div>
                
                <div class="form-group">
                    <label><i class="fas fa-align-left"></i> Description</label>
                    <textarea name="description" placeholder="Describe the assignment requirements and instructions..."></textarea>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label><i class="fas fa-calendar"></i> Due Date *</label>
                        <input type="datetime-local" name="dueDate" required>
                    </div>
                    
                    <div class="form-group">
                        <label><i class="fas fa-star"></i> Maximum Points *</label>
                        <input type="number" name="maxPoints" min="1" max="1000" required placeholder="100" value="100">
                    </div>
                </div>
            </div>
            
            <div class="form-card">
                <div class="section-title">
                    <i class="fas fa-tasks"></i> Assignment Type
                </div>
                
                <div class="type-selector">
                    <div class="type-option">
                        <input type="radio" name="assignmentType" id="type-mcq" value="MCQ" checked>
                        <label for="type-mcq" class="type-card">
                            <i class="fas fa-list-check"></i>
                            <h3>Multiple Choice</h3>
                            <p>Auto-graded quiz with MCQ questions</p>
                            <span class="grading-badge badge-auto">AUTO GRADED</span>
                        </label>
                    </div>
                    
                    <div class="type-option">
                        <input type="radio" name="assignmentType" id="type-essay" value="ESSAY">
                        <label for="type-essay" class="type-card">
                            <i class="fas fa-pen-to-square"></i>
                            <h3>Short Answer / Essay</h3>
                            <p>Manually graded written response</p>
                            <span class="grading-badge badge-manual">MANUAL GRADING</span>
                        </label>
                    </div>
                </div>
            </div>
            
            <div class="form-card">
                <div class="section-title">
                    <i class="fas fa-clock"></i> Time Settings
                </div>
                
                <div class="time-settings">
                    <h4><i class="fas fa-hourglass-start"></i> Timed Assignment</h4>
                    
                    <div class="checkbox-group">
                        <input type="checkbox" id="enableTiming" name="enableTiming" value="true">
                        <label for="enableTiming">Enable time limit for this assignment</label>
                    </div>
                    
                    <div id="timeSettingsFields" style="display: none;">
                        <div class="form-row">
                            <div class="form-group">
                                <label><i class="fas fa-play"></i> Available From</label>
                                <input type="datetime-local" name="availableFrom" id="availableFrom">
                            </div>
                            
                            <div class="form-group">
                                <label><i class="fas fa-stop"></i> Available Until</label>
                                <input type="datetime-local" name="availableUntil" id="availableUntil">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label><i class="fas fa-hourglass-half"></i> Time Limit (minutes)</label>
                            <input type="number" name="timeLimit" min="1" max="300" placeholder="60">
                            <small style="color: #7f8c8d; margin-top: 5px; display: block;">
                                <i class="fas fa-info-circle"></i> Assignment will auto-submit when time expires
                            </small>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="form-card mcq-section active" id="mcqSection">
                <div class="section-title">
                    <i class="fas fa-question-circle"></i> Multiple Choice Questions
                </div>
                
                <button type="button" class="btn-add-question" onclick="addQuestion()">
                    <i class="fas fa-plus"></i> Add Question
                </button>
                
                <div id="questionsContainer"></div>
            </div>
            
            <div class="form-card">
                <div class="btn-group">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-check"></i> Create Assignment
                    </button>
                    <a href="${pageContext.request.contextPath}/instructor/assignments" class="btn btn-secondary">
                        <i class="fas fa-times"></i> Cancel
                    </a>
                </div>
            </div>
        </form>
    </div>
    
    <script>
        let questionCount = 0;
        
        // Toggle assignment type sections
        document.querySelectorAll('input[name="assignmentType"]').forEach(radio => {
            radio.addEventListener('change', function() {
                const mcqSection = document.getElementById('mcqSection');
                if (this.value === 'MCQ') {
                    mcqSection.classList.add('active');
                } else {
                    mcqSection.classList.remove('active');
                }
            });
        });
        
        // Toggle time settings
        document.getElementById('enableTiming').addEventListener('change', function() {
            document.getElementById('timeSettingsFields').style.display = this.checked ? 'block' : 'none';
        });
        
        // Add MCQ question
        function addQuestion() {
            questionCount++;
            const container = document.getElementById('questionsContainer');
            const questionHTML = `
                <div class="question-item" id="question-${questionCount}">
                    <div class="question-header">
                        <span class="question-number">Question ${questionCount}</span>
                        <button type="button" class="btn-remove-question" onclick="removeQuestion(${questionCount})">
                            <i class="fas fa-trash"></i> Remove
                        </button>
                    </div>
                    
                    <div class="form-group">
                        <label><i class="fas fa-question"></i> Question Text *</label>
                        <input type="text" name="questions[${questionCount}].text" required 
                               placeholder="Enter your question here...">
                        <input type="hidden" name="questions[${questionCount}].points" value="1">
                    </div>
                    
                    <div class="option-group">
                        <div class="option-item">
                            <span class="option-label">Option A:</span>
                            <input type="text" name="questions[${questionCount}].optionA" required 
                                   placeholder="Enter option A">
                            <span class="correct-label">
                                <input type="radio" name="questions[${questionCount}].correct" value="A" required>
                                Correct
                            </span>
                        </div>
                        
                        <div class="option-item">
                            <span class="option-label">Option B:</span>
                            <input type="text" name="questions[${questionCount}].optionB" required 
                                   placeholder="Enter option B">
                            <span class="correct-label">
                                <input type="radio" name="questions[${questionCount}].correct" value="B">
                                Correct
                            </span>
                        </div>
                        
                        <div class="option-item">
                            <span class="option-label">Option C:</span>
                            <input type="text" name="questions[${questionCount}].optionC" required 
                                   placeholder="Enter option C">
                            <span class="correct-label">
                                <input type="radio" name="questions[${questionCount}].correct" value="C">
                                Correct
                            </span>
                        </div>
                        
                        <div class="option-item">
                            <span class="option-label">Option D:</span>
                            <input type="text" name="questions[${questionCount}].optionD" required 
                                   placeholder="Enter option D">
                            <span class="correct-label">
                                <input type="radio" name="questions[${questionCount}].correct" value="D">
                                Correct
                            </span>
                        </div>
                    </div>
                </div>
            `;
            container.insertAdjacentHTML('beforeend', questionHTML);
        }
        
        function removeQuestion(id) {
            document.getElementById('question-' + id).remove();
        }
        
        // Add first question on page load
        addQuestion();
    </script>
</body>
</html>
