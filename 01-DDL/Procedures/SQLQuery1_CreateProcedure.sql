USE PD311_AcademyDesign;
GO

--CREATE PROCEDURE PrintTableStudentsGroups
--AS
--BEGIN
--	SELECT
--		[ФИО] = FORMATMESSAGE('%s %s %s', Students.last_name, Students.first_name, Students.middle_name),
--		[Возраст] = DATEDIFF(DAY, Students.birth_date, GETDATE()) / 365,
--		[Группа] = Groups.group_name
--	FROM Students, Groups
--	WHERE Students.group_id = Groups.id;
--END

--CREATE PROC PrintSchedule
--AS
--BEGIN
--	SELECT
--		[Группа] = Groups.group_name,
--		[Дата] = Lessons.lesson_date,
--		[Время] = Lessons.lesson_time,
--		[День недели] = DATENAME(WEEKDAY, Lessons.lesson_date),
--		[Проведено] = IIF(Lessons.is_happened = 1, 'Проведено', 'Запланировано')
--	FROM Lessons, Groups
--	WHERE
--		Lessons.group_id = Groups.id;
--END

--CREATE PROC PrintScheduleForGroup
--@group NVARCHAR(50)
--AS
--BEGIN
--	SELECT
--		[Группа] = Groups.group_name,
--		[Предмет] = Subjects.subject_name,
--		[Дата] = Lessons.lesson_date,
--		[Время] = Lessons.lesson_time,
--		[День недели] = DATENAME(WEEKDAY, Lessons.lesson_date),
--		[Проведено] = Lessons.is_happened
--	FROM Lessons, Groups, Subjects
--	WHERE
--		Lessons.group_id = (SELECT id FROM Groups WHERE group_name = @group) AND
--		Groups.id = (SELECT id FROM Groups WHERE group_name = @group) AND
--		Lessons.subject_id = Subjects.id
--	ORDER BY Lessons.lesson_date;
--END

--CREATE PROC sp_AddScheduleForGroup
--@group NVARCHAR(50),
--@start_date DATE,
--@start_time TIME,
--@subject NVARCHAR(256),
--@teacher_last_name NVARCHAR(150)
--AS
--BEGIN
--	DECLARE @groupID AS INT = (SELECT Groups.id FROM Groups WHERE group_name = @group);
--	DECLARE @subjectID AS INT = (SELECT Subjects.id from Subjects WHERE subject_name LIKE @subject);
--	DECLARE @teacherID AS BIGINT = (SELECT Teachers.id FROM Teachers WHERE last_name = @teacher_last_name);
--	DECLARE @lesson_amount AS SMALLINT = (SELECT amount_of_hours FROM Subjects WHERE id = @subjectID);
--	DECLARE @cur_date AS DATE = GETDATE();
--	DECLARE @lesson AS SMALLINT = 0;
--	DECLARE @date AS DATE = @start_date;
--	DECLARE @time AS TIME = @start_time;
--	DECLARE @passed AS BIT = 0;

--	WHILE @lesson < @lesson_amount
--	BEGIN
--		IF DATEDIFF(DAY, @cur_date, @date) < 0
--		BEGIN
--			SET @passed = 1;
--		END
--		ELSE
--		BEGIN
--			SET @passed = 0;
--		END

--		IF NOT EXISTS(SELECT id FROM Lessons WHERE group_id = @groupID AND subject_id = @subjectID AND lesson_date = @date AND lesson_time = @time)
--		BEGIN
--			INSERT Lessons (lesson_date, lesson_time, group_id, subject_id, teacher_id, is_happened)
--			VALUES
--				(@date, @time, @groupID, @subjectID, @teacherID, @passed);
--		END

--		SET @lesson = @lesson + 1;

--		IF @time = @start_time
--			SET @time = DATEADD(HOUR, 2, @time);
--		ELSE
--			SET @time = @start_time

--		IF DATEPART(WEEKDAY, @date) IN (2, 4) AND @time = @start_time
--			SET @date = DATEADD(DAY, 2, @date);
--		ELSE IF DATEPART(WEEKDAY, @date) = 6 AND @time = @start_time
--			SET @date = DATEADD(DAY, 3, @date);
--	END
--END

ALTER PROC sp_AddScheduleForBaseStationaryGroup
@group NVARCHAR(50),
@start_date DATE,
@start_time TIME,
@teacher1_last_name NVARCHAR(150),
@teacher2_last_name NVARCHAR(150)
AS
BEGIN
	DECLARE @teacherID_1 AS INT = (SELECT id FROM Teachers WHERE last_name = @teacher1_last_name);
	DECLARE @teacherID_2 AS INT = (SELECT id FROM Teachers WHERE last_name = @teacher2_last_name);

	DECLARE @subject_codeID AS INT = (SELECT id FROM Subjects WHERE subject_name = 'Процедурное программирование на языке C++');
	DECLARE @subject_hardwareID AS INT = (SELECT id FROM Subjects WHERE subject_name = 'Hardware PC');
	DECLARE @subject_winID AS INT = (SELECT id FROM Subjects WHERE subject_name = 'Администрирование Windows XP/7/8/10/11');

	DECLARE @code_lessons AS INT = (SELECT amount_of_hours FROM Subjects WHERE id = @subject_codeID);
	DECLARE @hardware_lessons AS INT = (SELECT amount_of_hours FROM Subjects WHERE id = @subject_hardwareID);
	DECLARE @win_lessons AS INT = (SELECT amount_of_hours FROM Subjects WHERE id = @subject_winID);
	DECLARE @lessons AS INT = @code_lessons + @hardware_lessons + @win_lessons;

	DECLARE @lesson_count_code AS INT = 0;
	DECLARE @lesson_count_hardware AS INT = 0;
	DECLARE @lesson_count_win AS INT = 0;
	DECLARE @lesson_count AS INT = 0;
	DECLARE @week_count AS INT = 0;

	DECLARE @groupID AS INT = (SELECT Groups.id FROM Groups WHERE group_name = @group);
	DECLARE @cur_date AS DATE = GETDATE();
	DECLARE @date AS DATE = @start_date;
	DECLARE @time AS TIME = @start_time;
	DECLARE @passed AS BIT = 0;

	DECLARE @cur_subject AS INT = 0;
	DECLARE @cur_teacher AS INT = 0;


	WHILE @lesson_count < @lessons
	BEGIN
		IF DATEDIFF(DAY, @cur_date, @date) < 0
		BEGIN
			SET @passed = 1;
		END
		ELSE
		BEGIN
			SET @passed = 0;
		END

		IF @lesson_count_hardware < @hardware_lessons AND 
			((@week_count % 2 != 0 AND DATENAME(WEEKDAY, @date) = 'Monday') OR
			(@week_count % 2 = 0 AND DATENAME(WEEKDAY, @date) IN ('Monday', 'Wednesday')))
		BEGIN
			--PRINT(FORMATMESSAGE('HARDWARE, week %i, weekday %s', @week_count, DATENAME(WEEKDAY, @date)));
			SET @cur_subject = @subject_hardwareID;
			SET @cur_teacher = @teacherID_2;
			SET @lesson_count_hardware = @lesson_count_hardware + 1;
		END

		ELSE IF @lesson_count_win < @win_lessons AND 
				((@week_count % 2 != 0 AND DATENAME(WEEKDAY, @date) = 'Monday') OR
				 (@week_count % 2 = 0 AND DATENAME(WEEKDAY, @date) IN ('Monday', 'Wednesday')))
		BEGIN
			--PRINT(FORMATMESSAGE('WINDOWS, week %i, weekday %s', @week_count, DATENAME(WEEKDAY, @date)));
			SET @cur_subject = @subject_winID;
			SET @cur_teacher = @teacherID_2;
			SET @lesson_count_win = @lesson_count_win + 1;
		END

		ELSE
		BEGIN
			--PRINT(FORMATMESSAGE('C++, week %i, weekday %s', @week_count, DATENAME(WEEKDAY, @date)));
			SET @cur_subject = @subject_codeID;
			SET @cur_teacher = @teacherID_1;
			SET @lesson_count_code = @lesson_count_code + 1;
		END

		SET @lesson_count = @lesson_count + 1;
		IF DATENAME(WEEKDAY, @date) = 'Friday' AND @time != @start_time
		BEGIN
			SET @week_count = @week_count + 1;
		END

		IF NOT EXISTS(SELECT id FROM Lessons WHERE group_id = @groupID AND subject_id = @cur_subject AND lesson_date = @date AND lesson_time = @time)
		BEGIN
			INSERT Lessons (lesson_date, lesson_time, group_id, subject_id, teacher_id, is_happened)
			VALUES
				(@date, @time, @groupID, @cur_subject, @cur_teacher, @passed);
		END

		IF @time = @start_time
			SET @time = DATEADD(MINUTE, 90, @time);
		ELSE
			SET @time = @start_time

		IF DATEPART(WEEKDAY, @date) IN (2, 4) AND @time = @start_time
			SET @date = DATEADD(DAY, 2, @date);
		ELSE IF DATEPART(WEEKDAY, @date) = 6 AND @time = @start_time
			SET @date = DATEADD(DAY, 3, @date);
	END
END