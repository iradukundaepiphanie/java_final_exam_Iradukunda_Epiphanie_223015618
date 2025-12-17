-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 06, 2025 at 07:00 PM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.4.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `education-platform`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `AdminID` int(11) NOT NULL,
  `FirstName` varchar(100) NOT NULL,
  `LastName` varchar(100) NOT NULL,
  `Email` varchar(150) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  `Role` varchar(50) DEFAULT 'Admin',
  `Status` varchar(20) DEFAULT 'Active',
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`AdminID`, `FirstName`, `LastName`, `Email`, `Password`, `Phone`, `Role`, `Status`, `CreatedAt`) VALUES
(1, 'System', 'Administrator', 'admin@edu.com', 'admin123', '555-0001', 'Admin', 'Active', '2025-12-06 15:46:35');

-- --------------------------------------------------------

--
-- Table structure for table `assignment`
--

CREATE TABLE `assignment` (
  `AssignmentID` int(11) NOT NULL AUTO_INCREMENT,
  `CourseID` int(11) NOT NULL,
  `Title` varchar(200) NOT NULL,
  `Description` text DEFAULT NULL,
  `DueDate` date DEFAULT NULL,
  `MaxPoints` int(11) DEFAULT 100,
  `Status` varchar(20) DEFAULT 'Active',
  `AssignmentType` varchar(20) DEFAULT 'ESSAY',
  `Timed` tinyint(1) DEFAULT 0,
  `TimeLimit` int(11) DEFAULT NULL,
  `AvailableFrom` datetime DEFAULT NULL,
  `AvailableUntil` datetime DEFAULT NULL,
  `AutoGraded` tinyint(1) DEFAULT 0,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`AssignmentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `assignment`
--

INSERT INTO `assignment` (`AssignmentID`, `CourseID`, `Title`, `Description`, `DueDate`, `MaxPoints`, `Status`, `AssignmentType`, `Timed`, `TimeLimit`, `AvailableFrom`, `AvailableUntil`, `AutoGraded`, `CreatedAt`) VALUES
(1, 1, 'Hello World Program', 'Create your first Java program', '2025-02-01', 100, 'Active', 'ESSAY', 0, NULL, NULL, NULL, 0, '2025-12-06 15:46:35'),
(2, 1, 'Variables and Data Types', 'Explore Java data types', '2025-02-15', 100, 'Active', 'ESSAY', 0, NULL, NULL, NULL, 0, '2025-12-06 15:46:35'),
(3, 2, 'Implement a Binary Tree', 'Create a binary tree data structure', '2025-02-20', 150, 'Active', 'ESSAY', 0, NULL, NULL, NULL, 0, '2025-12-06 15:46:35'),
(4, 3, 'Derivatives Problem Set', 'Solve derivative problems', '2025-02-10', 100, 'Active', 'ESSAY', 0, NULL, NULL, NULL, 0, '2025-12-06 15:46:35'),
(5, 4, 'Newton Laws Lab', 'Apply Newton laws in experiments', '2025-02-25', 120, 'Active', 'ESSAY', 0, NULL, NULL, NULL, 0, '2025-12-06 15:46:35');

-- --------------------------------------------------------

--
-- Table structure for table `assignmentquestion`
--

CREATE TABLE `assignmentquestion` (
  `QuestionID` int(11) NOT NULL AUTO_INCREMENT,
  `AssignmentID` int(11) NOT NULL,
  `QuestionText` text NOT NULL,
  `QuestionOrder` int(11) DEFAULT 1,
  `Points` int(11) DEFAULT 10,
  `OptionA` text DEFAULT NULL,
  `OptionB` text DEFAULT NULL,
  `OptionC` text DEFAULT NULL,
  `OptionD` text DEFAULT NULL,
  `CorrectAnswer` char(1) DEFAULT NULL,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`QuestionID`),
  KEY `AssignmentID` (`AssignmentID`),
  CONSTRAINT `fk_question_assignment` FOREIGN KEY (`AssignmentID`) REFERENCES `assignment` (`AssignmentID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `assignmentsubmission`
--

CREATE TABLE `assignmentsubmission` (
  `SubmissionID` int(11) NOT NULL AUTO_INCREMENT,
  `AssignmentID` int(11) NOT NULL,
  `StudentID` int(11) NOT NULL,
  `SubmittedAt` datetime DEFAULT current_timestamp(),
  `Score` decimal(5,2) DEFAULT NULL,
  `TimeSpent` int(11) DEFAULT NULL,
  `Status` varchar(20) DEFAULT 'Submitted',
  `EssayContent` text DEFAULT NULL,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`SubmissionID`),
  KEY `AssignmentID` (`AssignmentID`),
  KEY `StudentID` (`StudentID`),
  CONSTRAINT `fk_submission_assignment` FOREIGN KEY (`AssignmentID`) REFERENCES `assignment` (`AssignmentID`) ON DELETE CASCADE,
  CONSTRAINT `fk_submission_student` FOREIGN KEY (`StudentID`) REFERENCES `student` (`StudentID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `studentanswer`
--

CREATE TABLE `studentanswer` (
  `AnswerID` int(11) NOT NULL AUTO_INCREMENT,
  `SubmissionID` int(11) NOT NULL,
  `QuestionID` int(11) NOT NULL,
  `SelectedAnswer` char(1) DEFAULT NULL,
  `IsCorrect` tinyint(1) DEFAULT 0,
  `PointsEarned` decimal(5,2) DEFAULT 0.00,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`AnswerID`),
  KEY `SubmissionID` (`SubmissionID`),
  KEY `QuestionID` (`QuestionID`),
  CONSTRAINT `fk_answer_submission` FOREIGN KEY (`SubmissionID`) REFERENCES `assignmentsubmission` (`SubmissionID`) ON DELETE CASCADE,
  CONSTRAINT `fk_answer_question` FOREIGN KEY (`QuestionID`) REFERENCES `assignmentquestion` (`QuestionID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `course`
--

CREATE TABLE `course` (
  `CourseID` int(11) NOT NULL,
  `CourseName` varchar(200) NOT NULL,
  `CourseCode` varchar(50) NOT NULL,
  `Description` text DEFAULT NULL,
  `Credits` int(11) DEFAULT 3,
  `InstructorID` int(11) DEFAULT NULL,
  `StartDate` date DEFAULT NULL,
  `EndDate` date DEFAULT NULL,
  `Status` varchar(20) DEFAULT 'Active',
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `course`
--

INSERT INTO `course` (`CourseID`, `CourseName`, `CourseCode`, `Description`, `Credits`, `InstructorID`, `StartDate`, `EndDate`, `Status`, `CreatedAt`) VALUES
(1, 'Introduction to Programming', 'CS101', 'Learn the basics of programming with Java', 4, 1, '2025-01-15', '2025-05-15', 'Active', '2025-12-06 15:46:35'),
(2, 'Data Structures', 'CS201', 'Advanced data structures and algorithms', 4, 1, '2025-01-15', '2025-05-15', 'Active', '2025-12-06 15:46:35'),
(3, 'Calculus I', 'MATH101', 'Fundamental concepts of calculus', 3, 2, '2025-01-15', '2025-05-15', 'Active', '2025-12-06 15:46:35'),
(4, 'Physics I', 'PHY101', 'Introduction to classical mechanics', 4, 3, '2025-01-15', '2025-05-15', 'Active', '2025-12-06 15:46:35');

-- --------------------------------------------------------

--
-- Table structure for table `enrollment`
--

CREATE TABLE `enrollment` (
  `EnrollmentID` int(11) NOT NULL,
  `StudentID` int(11) NOT NULL,
  `CourseID` int(11) NOT NULL,
  `EnrollmentDate` date DEFAULT curdate(),
  `Status` varchar(20) DEFAULT 'Enrolled',
  `Grade` varchar(5) DEFAULT NULL,
  `CompletionDate` date DEFAULT NULL,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `enrollment`
--

INSERT INTO `enrollment` (`EnrollmentID`, `StudentID`, `CourseID`, `EnrollmentDate`, `Status`, `Grade`, `CompletionDate`, `CreatedAt`) VALUES
(1, 1, 1, '2025-01-10', 'Enrolled', NULL, NULL, '2025-12-06 15:46:35'),
(2, 1, 3, '2025-01-10', 'Enrolled', NULL, NULL, '2025-12-06 15:46:35'),
(3, 2, 1, '2025-01-11', 'Enrolled', NULL, NULL, '2025-12-06 15:46:35'),
(4, 2, 2, '2025-01-11', 'Enrolled', NULL, NULL, '2025-12-06 15:46:35'),
(5, 3, 3, '2025-01-12', 'Enrolled', NULL, NULL, '2025-12-06 15:46:35'),
(6, 3, 4, '2025-01-12', 'Enrolled', NULL, NULL, '2025-12-06 15:46:35'),
(7, 4, 1, '2025-01-13', 'Enrolled', NULL, NULL, '2025-12-06 15:46:35'),
(8, 4, 4, '2025-01-13', 'Enrolled', NULL, NULL, '2025-12-06 15:46:35');

-- --------------------------------------------------------

--
-- Table structure for table `grade`
--

CREATE TABLE `grade` (
  `GradeID` int(11) NOT NULL,
  `StudentID` int(11) NOT NULL,
  `AssignmentID` int(11) NOT NULL,
  `EnrollmentID` int(11) NOT NULL,
  `PointsEarned` decimal(5,2) DEFAULT NULL,
  `Feedback` text DEFAULT NULL,
  `SubmissionDate` date DEFAULT NULL,
  `GradedDate` date DEFAULT NULL,
  `Status` varchar(20) DEFAULT 'Pending',
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `grade`
--

INSERT INTO `grade` (`GradeID`, `StudentID`, `AssignmentID`, `EnrollmentID`, `PointsEarned`, `Feedback`, `SubmissionDate`, `GradedDate`, `Status`, `CreatedAt`) VALUES
(1, 1, 1, 1, '95.00', 'Excellent work!', '2025-01-31', '2025-02-02', 'Graded', '2025-12-06 15:46:35'),
(2, 1, 4, 2, '88.00', 'Good understanding', '2025-02-09', '2025-02-11', 'Graded', '2025-12-06 15:46:35'),
(3, 2, 1, 3, '92.00', 'Well done', '2025-01-30', '2025-02-02', 'Graded', '2025-12-06 15:46:35'),
(4, 4, 1, 7, '85.00', 'Good effort', '2025-02-01', '2025-02-03', 'Graded', '2025-12-06 15:46:35');

-- --------------------------------------------------------

--
-- Table structure for table `instructor`
--

CREATE TABLE `instructor` (
  `InstructorID` int(11) NOT NULL,
  `FirstName` varchar(100) NOT NULL,
  `LastName` varchar(100) NOT NULL,
  `Email` varchar(150) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  `Department` varchar(100) DEFAULT NULL,
  `Specialization` varchar(100) DEFAULT NULL,
  `HireDate` date DEFAULT NULL,
  `Status` varchar(20) DEFAULT 'Active',
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `instructor`
--

INSERT INTO `instructor` (`InstructorID`, `FirstName`, `LastName`, `Email`, `Password`, `Phone`, `Department`, `Specialization`, `HireDate`, `Status`, `CreatedAt`) VALUES
(1, 'John', 'Smith', 'john.smith@edu.com', 'instructor123', '555-0101', 'Computer Science', 'Software Engineering', '2020-01-15', 'Active', '2025-12-06 15:46:35'),
(2, 'Sarah', 'Johnson', 'sarah.johnson@edu.com', 'instructor123', '555-0102', 'Mathematics', 'Applied Mathematics', '2019-03-20', 'Active', '2025-12-06 15:46:35'),
(3, 'Michael', 'Brown', 'michael.brown@edu.com', 'instructor123', '555-0103', 'Physics', 'Quantum Physics', '2018-08-10', 'Active', '2025-12-06 15:46:35');

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `StudentID` int(11) NOT NULL,
  `FirstName` varchar(100) NOT NULL,
  `LastName` varchar(100) NOT NULL,
  `Email` varchar(150) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  `DateOfBirth` date DEFAULT NULL,
  `Address` text DEFAULT NULL,
  `EnrollmentDate` date DEFAULT curdate(),
  `Status` varchar(20) DEFAULT 'Active',
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`StudentID`, `FirstName`, `LastName`, `Email`, `Password`, `Phone`, `DateOfBirth`, `Address`, `EnrollmentDate`, `Status`, `CreatedAt`) VALUES
(1, 'Alice', 'Williams', 'alice.w@student.edu', 'student123', '555-1001', '2002-05-15', '123 Main St', '2025-12-06', 'Active', '2025-12-06 15:46:35'),
(2, 'Bob', 'Davis', 'bob.d@student.edu', 'student123', '555-1002', '2001-08-22', '456 Oak Ave', '2025-12-06', 'Active', '2025-12-06 15:46:35'),
(3, 'Carol', 'Miller', 'carol.m@student.edu', 'student123', '555-1003', '2003-02-10', '789 Pine Rd', '2025-12-06', 'Active', '2025-12-06 15:46:35'),
(4, 'David', 'Wilson', 'david.w@student.edu', 'student123', '555-1004', '2002-11-30', '321 Elm St', '2025-12-06', 'Active', '2025-12-06 15:46:35');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`AdminID`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- Indexes for table `assignment`
--
ALTER TABLE `assignment`
  ADD PRIMARY KEY (`AssignmentID`),
  ADD KEY `CourseID` (`CourseID`);

--
-- Indexes for table `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`CourseID`),
  ADD UNIQUE KEY `CourseCode` (`CourseCode`),
  ADD KEY `InstructorID` (`InstructorID`);

--
-- Indexes for table `enrollment`
--
ALTER TABLE `enrollment`
  ADD PRIMARY KEY (`EnrollmentID`),
  ADD UNIQUE KEY `unique_enrollment` (`StudentID`,`CourseID`),
  ADD KEY `CourseID` (`CourseID`);

--
-- Indexes for table `grade`
--
ALTER TABLE `grade`
  ADD PRIMARY KEY (`GradeID`),
  ADD UNIQUE KEY `unique_grade` (`StudentID`,`AssignmentID`),
  ADD KEY `AssignmentID` (`AssignmentID`),
  ADD KEY `EnrollmentID` (`EnrollmentID`);

--
-- Indexes for table `instructor`
--
ALTER TABLE `instructor`
  ADD PRIMARY KEY (`InstructorID`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`StudentID`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `AdminID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `assignment`
--
ALTER TABLE `assignment`
  MODIFY `AssignmentID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `course`
--
ALTER TABLE `course`
  MODIFY `CourseID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `enrollment`
--
ALTER TABLE `enrollment`
  MODIFY `EnrollmentID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `grade`
--
ALTER TABLE `grade`
  MODIFY `GradeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `instructor`
--
ALTER TABLE `instructor`
  MODIFY `InstructorID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `student`
--
ALTER TABLE `student`
  MODIFY `StudentID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `assignment`
--
ALTER TABLE `assignment`
  ADD CONSTRAINT `assignment_ibfk_1` FOREIGN KEY (`CourseID`) REFERENCES `course` (`CourseID`) ON DELETE CASCADE;

--
-- Constraints for table `course`
--
ALTER TABLE `course`
  ADD CONSTRAINT `course_ibfk_1` FOREIGN KEY (`InstructorID`) REFERENCES `instructor` (`InstructorID`) ON DELETE SET NULL;

--
-- Constraints for table `enrollment`
--
ALTER TABLE `enrollment`
  ADD CONSTRAINT `enrollment_ibfk_1` FOREIGN KEY (`StudentID`) REFERENCES `student` (`StudentID`) ON DELETE CASCADE,
  ADD CONSTRAINT `enrollment_ibfk_2` FOREIGN KEY (`CourseID`) REFERENCES `course` (`CourseID`) ON DELETE CASCADE;

--
-- Constraints for table `grade`
--
ALTER TABLE `grade`
  ADD CONSTRAINT `grade_ibfk_1` FOREIGN KEY (`StudentID`) REFERENCES `student` (`StudentID`) ON DELETE CASCADE,
  ADD CONSTRAINT `grade_ibfk_2` FOREIGN KEY (`AssignmentID`) REFERENCES `assignment` (`AssignmentID`) ON DELETE CASCADE,
  ADD CONSTRAINT `grade_ibfk_3` FOREIGN KEY (`EnrollmentID`) REFERENCES `enrollment` (`EnrollmentID`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
