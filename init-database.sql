-- Education Platform Database Initialization Script
-- This script creates the database, tables, and sample data

-- Create database if it doesn't exist
CREATE DATABASE IF NOT EXISTS `education-platform`;
USE `education-platform`;

-- Drop existing tables if they exist
DROP TABLE IF EXISTS `grades`;
DROP TABLE IF EXISTS `assignments`;
DROP TABLE IF EXISTS `enrollments`;
DROP TABLE IF EXISTS `courses`;
DROP TABLE IF EXISTS `students`;
DROP TABLE IF EXISTS `instructors`;
DROP TABLE IF EXISTS `admins`;

-- Create Admins table
CREATE TABLE `admins` (
  `admin_id` INT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) UNIQUE NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `phone` VARCHAR(20),
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Students table
CREATE TABLE `students` (
  `student_id` INT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) UNIQUE NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `phone` VARCHAR(20),
  `enrollment_date` DATE,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Instructors table
CREATE TABLE `instructors` (
  `instructor_id` INT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) UNIQUE NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `phone` VARCHAR(20),
  `department` VARCHAR(100),
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Courses table
CREATE TABLE `courses` (
  `course_id` INT PRIMARY KEY AUTO_INCREMENT,
  `course_name` VARCHAR(150) NOT NULL,
  `course_code` VARCHAR(20) UNIQUE NOT NULL,
  `instructor_id` INT,
  `credits` INT,
  `description` TEXT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`instructor_id`) REFERENCES `instructors`(`instructor_id`) ON DELETE SET NULL
);

-- Create Enrollments table
CREATE TABLE `enrollments` (
  `enrollment_id` INT PRIMARY KEY AUTO_INCREMENT,
  `student_id` INT NOT NULL,
  `course_id` INT NOT NULL,
  `enrollment_date` DATE,
  `status` VARCHAR(20) DEFAULT 'Active',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`student_id`) REFERENCES `students`(`student_id`) ON DELETE CASCADE,
  FOREIGN KEY (`course_id`) REFERENCES `courses`(`course_id`) ON DELETE CASCADE
);

-- Create Assignments table
CREATE TABLE `assignments` (
  `assignment_id` INT PRIMARY KEY AUTO_INCREMENT,
  `course_id` INT NOT NULL,
  `title` VARCHAR(200) NOT NULL,
  `description` TEXT,
  `due_date` DATETIME,
  `max_points` INT DEFAULT 100,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`course_id`) REFERENCES `courses`(`course_id`) ON DELETE CASCADE
);

-- Create Grades table
CREATE TABLE `grades` (
  `grade_id` INT PRIMARY KEY AUTO_INCREMENT,
  `student_id` INT NOT NULL,
  `assignment_id` INT NOT NULL,
  `score` DECIMAL(5,2),
  `feedback` TEXT,
  `submitted_date` DATETIME,
  `graded_date` DATETIME,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`student_id`) REFERENCES `students`(`student_id`) ON DELETE CASCADE,
  FOREIGN KEY (`assignment_id`) REFERENCES `assignments`(`assignment_id`) ON DELETE CASCADE
);

-- Insert sample data

-- Sample Admins (password: admin123)
INSERT INTO `admins` (`name`, `email`, `password`, `phone`) VALUES
('Admin User', 'admin@education.com', 'admin123', '555-0100'),
('System Admin', 'system@education.com', 'admin123', '555-0101');

-- Sample Instructors (password: instructor123)
INSERT INTO `instructors` (`name`, `email`, `password`, `phone`, `department`) VALUES
('Dr. John Smith', 'john.smith@education.com', 'instructor123', '555-0200', 'Computer Science'),
('Prof. Sarah Johnson', 'sarah.johnson@education.com', 'instructor123', '555-0201', 'Mathematics'),
('Dr. Michael Brown', 'michael.brown@education.com', 'instructor123', '555-0202', 'Physics'),
('Prof. Emily Davis', 'emily.davis@education.com', 'instructor123', '555-0203', 'Chemistry');

-- Sample Students (password: student123)
INSERT INTO `students` (`name`, `email`, `password`, `phone`, `enrollment_date`) VALUES
('Alice Williams', 'alice.williams@student.edu', 'student123', '555-1000', '2024-09-01'),
('Bob Martinez', 'bob.martinez@student.edu', 'student123', '555-1001', '2024-09-01'),
('Charlie Garcia', 'charlie.garcia@student.edu', 'student123', '555-1002', '2024-09-01'),
('Diana Rodriguez', 'diana.rodriguez@student.edu', 'student123', '555-1003', '2024-09-01'),
('Eva Lopez', 'eva.lopez@student.edu', 'student123', '555-1004', '2024-09-01'),
('Frank Wilson', 'frank.wilson@student.edu', 'student123', '555-1005', '2024-09-01'),
('Grace Lee', 'grace.lee@student.edu', 'student123', '555-1006', '2024-09-01'),
('Henry Taylor', 'henry.taylor@student.edu', 'student123', '555-1007', '2024-09-01');

-- Sample Courses
INSERT INTO `courses` (`course_name`, `course_code`, `instructor_id`, `credits`, `description`) VALUES
('Introduction to Programming', 'CS101', 1, 3, 'Learn the basics of programming using Java'),
('Data Structures', 'CS201', 1, 4, 'Study fundamental data structures and algorithms'),
('Calculus I', 'MATH101', 2, 4, 'Introduction to differential and integral calculus'),
('Linear Algebra', 'MATH201', 2, 3, 'Study of vector spaces and linear transformations'),
('Physics I', 'PHYS101', 3, 4, 'Introduction to classical mechanics'),
('General Chemistry', 'CHEM101', 4, 4, 'Introduction to chemical principles and reactions');

-- Sample Enrollments
INSERT INTO `enrollments` (`student_id`, `course_id`, `enrollment_date`, `status`) VALUES
-- Alice enrolled in CS101, MATH101, PHYS101
(1, 1, '2024-09-01', 'Active'),
(1, 3, '2024-09-01', 'Active'),
(1, 5, '2024-09-01', 'Active'),
-- Bob enrolled in CS101, CS201, MATH101
(2, 1, '2024-09-01', 'Active'),
(2, 2, '2024-09-01', 'Active'),
(2, 3, '2024-09-01', 'Active'),
-- Charlie enrolled in MATH101, PHYS101, CHEM101
(3, 3, '2024-09-01', 'Active'),
(3, 5, '2024-09-01', 'Active'),
(3, 6, '2024-09-01', 'Active'),
-- Diana enrolled in CS101, MATH101, CHEM101
(4, 1, '2024-09-01', 'Active'),
(4, 3, '2024-09-01', 'Active'),
(4, 6, '2024-09-01', 'Active'),
-- Eva enrolled in CS201, MATH201, PHYS101
(5, 2, '2024-09-01', 'Active'),
(5, 4, '2024-09-01', 'Active'),
(5, 5, '2024-09-01', 'Active'),
-- Frank enrolled in CS101, PHYS101
(6, 1, '2024-09-01', 'Active'),
(6, 5, '2024-09-01', 'Active'),
-- Grace enrolled in MATH101, MATH201, CHEM101
(7, 3, '2024-09-01', 'Active'),
(7, 4, '2024-09-01', 'Active'),
(7, 6, '2024-09-01', 'Active'),
-- Henry enrolled in CS201, PHYS101, CHEM101
(8, 2, '2024-09-01', 'Active'),
(8, 5, '2024-09-01', 'Active'),
(8, 6, '2024-09-01', 'Active');

-- Sample Assignments for CS101
INSERT INTO `assignments` (`course_id`, `title`, `description`, `due_date`, `max_points`) VALUES
(1, 'Hello World Program', 'Write your first Java program', '2024-09-15 23:59:00', 100),
(1, 'Variables and Data Types', 'Practice with different data types', '2024-09-22 23:59:00', 100),
(1, 'Conditional Statements', 'Implement if-else logic', '2024-09-29 23:59:00', 100),
(1, 'Loops Assignment', 'Practice for and while loops', '2024-10-06 23:59:00', 100);

-- Sample Assignments for CS201
INSERT INTO `assignments` (`course_id`, `title`, `description`, `due_date`, `max_points`) VALUES
(2, 'Linked Lists', 'Implement a linked list', '2024-09-20 23:59:00', 100),
(2, 'Stack and Queue', 'Implement stack and queue data structures', '2024-09-27 23:59:00', 100),
(2, 'Binary Trees', 'Create a binary search tree', '2024-10-04 23:59:00', 100);

-- Sample Assignments for MATH101
INSERT INTO `assignments` (`course_id`, `title`, `description`, `due_date`, `max_points`) VALUES
(3, 'Limits and Continuity', 'Solve limit problems', '2024-09-18 23:59:00', 100),
(3, 'Derivatives', 'Calculate derivatives', '2024-09-25 23:59:00', 100),
(3, 'Integration', 'Practice integration techniques', '2024-10-02 23:59:00', 100);

-- Sample Grades for Alice (student_id = 1)
INSERT INTO `grades` (`student_id`, `assignment_id`, `score`, `feedback`, `submitted_date`, `graded_date`) VALUES
(1, 1, 95.00, 'Excellent work!', '2024-09-14 18:30:00', '2024-09-15 10:00:00'),
(1, 2, 88.00, 'Good job, minor issues with naming conventions', '2024-09-21 20:15:00', '2024-09-22 14:30:00'),
(1, 7, 92.00, 'Well done', '2024-09-17 19:00:00', '2024-09-18 11:00:00');

-- Sample Grades for Bob (student_id = 2)
INSERT INTO `grades` (`student_id`, `assignment_id`, `score`, `feedback`, `submitted_date`, `graded_date`) VALUES
(2, 1, 100.00, 'Perfect!', '2024-09-13 16:00:00', '2024-09-15 10:30:00'),
(2, 2, 90.00, 'Great work', '2024-09-22 10:00:00', '2024-09-23 09:00:00'),
(2, 5, 85.00, 'Good implementation', '2024-09-19 22:00:00', '2024-09-20 15:00:00'),
(2, 7, 78.00, 'Needs more practice', '2024-09-18 23:00:00', '2024-09-19 10:00:00');

-- Sample Grades for Diana (student_id = 4)
INSERT INTO `grades` (`student_id`, `assignment_id`, `score`, `feedback`, `submitted_date`, `graded_date`) VALUES
(4, 1, 82.00, 'Good start', '2024-09-15 20:00:00', '2024-09-16 09:00:00'),
(4, 7, 88.00, 'Well done', '2024-09-18 17:30:00', '2024-09-19 11:30:00');

COMMIT;

-- Display summary
SELECT 'Database initialized successfully!' AS Status;
SELECT COUNT(*) AS Total_Students FROM students;
SELECT COUNT(*) AS Total_Instructors FROM instructors;
SELECT COUNT(*) AS Total_Courses FROM courses;
SELECT COUNT(*) AS Total_Enrollments FROM enrollments;
SELECT COUNT(*) AS Total_Assignments FROM assignments;
SELECT COUNT(*) AS Total_Grades FROM grades;
