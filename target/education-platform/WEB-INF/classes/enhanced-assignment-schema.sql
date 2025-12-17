-- Enhanced Assignment System with MCQ and Auto-Grading Support
-- Run this script to add new tables and columns for multiple choice questions and auto-grading

-- Add new columns to assignments table for assignment types and timing
ALTER TABLE assignments
ADD COLUMN assignment_type ENUM('MCQ', 'ESSAY') DEFAULT 'ESSAY' COMMENT 'Type of assignment',
ADD COLUMN timed BOOLEAN DEFAULT FALSE COMMENT 'Whether assignment has time limit',
ADD COLUMN time_limit INT DEFAULT NULL COMMENT 'Time limit in minutes',
ADD COLUMN available_from DATETIME DEFAULT NULL COMMENT 'When assignment becomes available',
ADD COLUMN available_until DATETIME DEFAULT NULL COMMENT 'When assignment closes',
ADD COLUMN auto_graded BOOLEAN DEFAULT FALSE COMMENT 'Whether assignment is auto-graded';

-- Create table for MCQ questions
CREATE TABLE IF NOT EXISTS assignment_questions (
    question_id INT AUTO_INCREMENT PRIMARY KEY,
    assignment_id INT NOT NULL,
    question_text TEXT NOT NULL,
    option_a VARCHAR(500) NOT NULL,
    option_b VARCHAR(500) NOT NULL,
    option_c VARCHAR(500) NOT NULL,
    option_d VARCHAR(500) NOT NULL,
    correct_answer CHAR(1) NOT NULL COMMENT 'A, B, C, or D',
    points DECIMAL(5,2) DEFAULT 1.00,
    question_order INT DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (assignment_id) REFERENCES assignments(assignment_id) ON DELETE CASCADE,
    INDEX idx_assignment (assignment_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Create table for student submissions
CREATE TABLE IF NOT EXISTS assignment_submissions (
    submission_id INT AUTO_INCREMENT PRIMARY KEY,
    assignment_id INT NOT NULL,
    student_id INT NOT NULL,
    submission_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    essay_answer TEXT DEFAULT NULL COMMENT 'For essay-type assignments',
    time_taken INT DEFAULT NULL COMMENT 'Time taken in seconds',
    auto_graded BOOLEAN DEFAULT FALSE,
    score DECIMAL(5,2) DEFAULT NULL,
    status ENUM('SUBMITTED', 'GRADED', 'PENDING') DEFAULT 'SUBMITTED',
    graded_by INT DEFAULT NULL COMMENT 'Instructor ID who graded',
    graded_date DATETIME DEFAULT NULL,
    feedback TEXT DEFAULT NULL,
    FOREIGN KEY (assignment_id) REFERENCES assignments(assignment_id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (graded_by) REFERENCES instructors(instructor_id) ON DELETE SET NULL,
    UNIQUE KEY unique_submission (assignment_id, student_id),
    INDEX idx_student (student_id),
    INDEX idx_assignment (assignment_id),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Create table for student MCQ answers
CREATE TABLE IF NOT EXISTS submission_answers (
    answer_id INT AUTO_INCREMENT PRIMARY KEY,
    submission_id INT NOT NULL,
    question_id INT NOT NULL,
    student_answer CHAR(1) NOT NULL COMMENT 'A, B, C, or D',
    is_correct BOOLEAN DEFAULT FALSE,
    points_earned DECIMAL(5,2) DEFAULT 0.00,
    FOREIGN KEY (submission_id) REFERENCES assignment_submissions(submission_id) ON DELETE CASCADE,
    FOREIGN KEY (question_id) REFERENCES assignment_questions(question_id) ON DELETE CASCADE,
    UNIQUE KEY unique_answer (submission_id, question_id),
    INDEX idx_submission (submission_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Update grades table to link with submissions
ALTER TABLE grades
ADD COLUMN submission_id INT DEFAULT NULL COMMENT 'Link to submission',
ADD CONSTRAINT fk_submission FOREIGN KEY (submission_id) REFERENCES assignment_submissions(submission_id) ON DELETE SET NULL;

-- Insert sample MCQ assignment
INSERT INTO assignments (course_id, title, description, due_date, max_points, assignment_type, timed, time_limit, auto_graded)
VALUES 
(1, 'Java Fundamentals Quiz', 'Multiple choice quiz covering basic Java concepts', '2025-12-20 23:59:59', 10, 'MCQ', TRUE, 30, TRUE);

SET @quiz_id = LAST_INSERT_ID();

-- Insert sample MCQ questions
INSERT INTO assignment_questions (assignment_id, question_text, option_a, option_b, option_c, option_d, correct_answer, points, question_order)
VALUES
(@quiz_id, 'What is the default value of a boolean variable in Java?', 'true', 'false', 'null', '0', 'B', 1.00, 1),
(@quiz_id, 'Which keyword is used to inherit a class in Java?', 'implements', 'extends', 'inherits', 'import', 'B', 1.00, 2),
(@quiz_id, 'What is the size of an int in Java?', '8 bits', '16 bits', '32 bits', '64 bits', 'C', 1.00, 3),
(@quiz_id, 'Which of these is NOT a valid access modifier in Java?', 'public', 'private', 'protected', 'package', 'D', 1.00, 4),
(@quiz_id, 'What does JVM stand for?', 'Java Virtual Machine', 'Java Variable Method', 'Java Vision Model', 'Java Version Manager', 'A', 1.00, 5),
(@quiz_id, 'Which method is the entry point of a Java application?', 'start()', 'main()', 'run()', 'init()', 'B', 1.00, 6),
(@quiz_id, 'What is encapsulation in Java?', 'Hiding implementation details', 'Creating multiple classes', 'Using interfaces', 'Compiling code', 'A', 1.00, 7),
(@quiz_id, 'Which collection does NOT allow duplicate elements?', 'ArrayList', 'LinkedList', 'HashSet', 'Vector', 'C', 1.00, 8),
(@quiz_id, 'What is the parent class of all classes in Java?', 'System', 'Object', 'Class', 'Main', 'B', 1.00, 9),
(@quiz_id, 'Which keyword is used to prevent method overriding?', 'static', 'final', 'abstract', 'const', 'B', 1.00, 10);

-- Insert sample timed essay assignment
INSERT INTO assignments (course_id, title, description, due_date, max_points, assignment_type, timed, time_limit, available_from, available_until, auto_graded)
VALUES 
(2, 'Data Structures Analysis', 'Explain the differences between arrays and linked lists with examples', '2025-12-25 23:59:59', 20, 'ESSAY', TRUE, 60, '2025-12-15 00:00:00', '2025-12-25 23:59:59', FALSE);

-- Insert sample regular essay assignment (not timed)
INSERT INTO assignments (course_id, title, description, due_date, max_points, assignment_type, auto_graded)
VALUES 
(3, 'Database Design Project', 'Design a database schema for an e-commerce system and explain your choices', '2025-12-30 23:59:59', 50, 'ESSAY', FALSE);

COMMIT;

-- Sample queries for testing

-- Get all MCQ questions for an assignment
-- SELECT * FROM assignment_questions WHERE assignment_id = @quiz_id ORDER BY question_order;

-- Get student submission with answers
-- SELECT s.*, a.student_answer, a.is_correct, q.correct_answer
-- FROM assignment_submissions s
-- LEFT JOIN submission_answers a ON s.submission_id = a.submission_id
-- LEFT JOIN assignment_questions q ON a.question_id = q.question_id
-- WHERE s.student_id = 1 AND s.assignment_id = @quiz_id;

-- Calculate auto-graded score
-- SELECT submission_id, SUM(points_earned) as total_score
-- FROM submission_answers
-- WHERE submission_id = ?
-- GROUP BY submission_id;
