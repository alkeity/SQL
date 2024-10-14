USE PD_311_Academy_DDL;

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'StudyFields')
BEGIN
	CREATE TABLE StudyFields
	(
		id INT PRIMARY KEY IDENTITY(1,1),
		study_field_name NVARCHAR(150) NOT NULL,
	);
END

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'Groups')
BEGIN
	CREATE TABLE Groups
	(
		id INT PRIMARY KEY IDENTITY(1,1),
		group_name NVARCHAR(16) NOT NULL,
		study_field_id INT NOT NULL CONSTRAINT FK_Groups_StudyFields FOREIGN KEY REFERENCES StudyFields(id)
	);
END

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'Students')
BEGIN
	CREATE TABLE Students
	(
		id BIGINT PRIMARY KEY IDENTITY(1,1),
		first_name NVARCHAR(150) NOT NULL,
		last_name NVARCHAR(150) NOT NULL,
		middle_name NVARCHAR(150),
		birth_date date NOT NULL,
		group_id INT NOT NULL CONSTRAINT FK_Students_Groups FOREIGN KEY REFERENCES Groups(id)
	);
END

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'Teachers')
BEGIN
	CREATE TABLE Teachers
	(
		id BIGINT PRIMARY KEY IDENTITY(1,1),
		first_name NVARCHAR(150) NOT NULL,
		last_name NVARCHAR(150) NOT NULL,
		middle_name NVARCHAR(150),
		birth_date DATE NOT NULL,
		year_started INT NOT NULL,
		rate MONEY NOT NULL
	);
END

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'TeachersGroups')
BEGIN
	CREATE TABLE TeachersGroups
	(
		teacher_id BIGINT CONSTRAINT FK_TeachersGroups_Teachers FOREIGN KEY REFERENCES Teachers(id),
		group_id INT CONSTRAINT FK_TeachersGroups_Groups FOREIGN KEY REFERENCES Groups(id),
		CONSTRAINT PK_TeachersGroups PRIMARY KEY (teacher_id, group_id)
	);
END

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'ReportTypes')
BEGIN
	CREATE TABLE ReportTypes
	(
		id INT PRIMARY KEY IDENTITY(1,1),
		report_type_name NVARCHAR(10) NOT NULL
	);
END

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'Subjects')
BEGIN
	CREATE TABLE Subjects
	(
		id INT PRIMARY KEY IDENTITY(1,1),
		subject_name NVARCHAR(150) NOT NULL,
		amount_of_hours INT NOT NULL,
		report_type_id INT NOT NULL CONSTRAINT FK_Subjects_ReportTypes FOREIGN KEY REFERENCES ReportTypes(id)
	);
END

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'SubjectRequirements')
BEGIN
	CREATE TABLE SubjectRequirements
	(
		subject_id INT CONSTRAINT FK_SubjectRequirements_Subjects FOREIGN KEY REFERENCES Subjects(id),
		required_subject_id INT CONSTRAINT FK_SubjectRequirements_Subjects_Requirement FOREIGN KEY REFERENCES Subjects(id),
		CONSTRAINT PK_SubjectRequirements PRIMARY KEY (subject_id, required_subject_id)
	);
END

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'CompleteSubjects')
BEGIN
	CREATE TABLE CompleteSubjects
	(
		subject_id INT CONSTRAINT FK_CompleteSubjects_Subjects FOREIGN KEY REFERENCES Subjects(id),
		group_id INT CONSTRAINT FK_CompleteSubjects_Groups FOREIGN KEY REFERENCES Groups(id),
		CONSTRAINT PK_CompleteSubjects PRIMARY KEY (subject_id, group_id)
	);
END

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'SubjectsStudyFields')
BEGIN
	CREATE TABLE SubjectsStudyFields
	(
		subject_id INT CONSTRAINT FK_SubjectsStudyFields_Subjects FOREIGN KEY REFERENCES Subjects(id),
		study_field_id INT NOT NULL CONSTRAINT FK_SubjectsStudyFields_StudyFields FOREIGN KEY REFERENCES StudyFields(id),
		CONSTRAINT PK_SubjectsStudyFields PRIMARY KEY (subject_id, study_field_id)
	);
END

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'Lessons')
BEGIN
	CREATE TABLE Lessons
	(
		id INT PRIMARY KEY IDENTITY(1,1),
		lesson_date DATE NOT NULL,
		lesson_time TIME(0) NOT NULL,
		lesson_theme NVARCHAR(50),
		is_done BIT,
		group_id INT NOT NULL CONSTRAINT FK_Lessons_Groups FOREIGN KEY REFERENCES Groups(id),
		teacher_id BIGINT NOT NULL CONSTRAINT FK_Lessons_Teachers FOREIGN KEY REFERENCES Teachers(id),
		subject_id INT NOT NULL CONSTRAINT FK_Lessons_Subjects FOREIGN KEY REFERENCES Subjects(id)
	);
END

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'Grades')
BEGIN
	CREATE TABLE Grades
	(
		grade_classwork TINYINT CONSTRAINT CHK_GradeClasswork CHECK (grade_classwork > 0 AND grade_classwork <= 12),
		grade_control TINYINT CONSTRAINT CHK_GradeControl CHECK (grade_control > 0 AND grade_control <= 12),
		subject_id INT CONSTRAINT FK_Grades_Subjects FOREIGN KEY REFERENCES Subjects(id),
		lesson_id INT CONSTRAINT FK_Grades_Lessons FOREIGN KEY REFERENCES Lessons(id),
		CONSTRAINT PK_Grades PRIMARY KEY (subject_id, lesson_id)
	);
END

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'Exams')
BEGIN
	CREATE TABLE Exams
	(
		grade TINYINT CONSTRAINT CHK_Grade CHECK (grade > 0 AND grade <= 12),
		subject_id INT CONSTRAINT FK_Exams_Subjects FOREIGN KEY REFERENCES Subjects(id),
		lesson_id INT CONSTRAINT FK_Exams_Lessons FOREIGN KEY REFERENCES Lessons(id),
		CONSTRAINT PK_Exams PRIMARY KEY (subject_id, lesson_id)
	);
END
