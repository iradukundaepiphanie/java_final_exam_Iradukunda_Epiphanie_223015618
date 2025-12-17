-- Create missing assignmentsubmission table
USE `education-platform`;

CREATE TABLE IF NOT EXISTS `assignmentsubmission` (
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
  KEY `StudentID` (`StudentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Create studentanswer table for MCQ answers
CREATE TABLE IF NOT EXISTS `studentanswer` (
  `AnswerID` int(11) NOT NULL AUTO_INCREMENT,
  `SubmissionID` int(11) NOT NULL,
  `QuestionID` int(11) NOT NULL,
  `SelectedAnswer` char(1) DEFAULT NULL,
  `IsCorrect` tinyint(1) DEFAULT 0,
  `PointsEarned` decimal(5,2) DEFAULT 0.00,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`AnswerID`),
  KEY `SubmissionID` (`SubmissionID`),
  KEY `QuestionID` (`QuestionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
