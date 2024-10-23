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

ALTER PROC PrintScheduleForGroup
@group NVARCHAR(50)
AS
BEGIN
	SELECT
		[Группа] = Groups.group_name,
		[Предмет] = Subjects.subject_name,
		[Дата] = Lessons.lesson_date,
		[Время] = Lessons.lesson_time,
		[День недели] = DATENAME(WEEKDAY, Lessons.lesson_date),
		[Проведено] = Lessons.is_happened
	FROM Lessons, Groups, Subjects
	WHERE
		Lessons.group_id = (SELECT id FROM Groups WHERE group_name = @group) AND
		Groups.id = (SELECT id FROM Groups WHERE group_name = @group) AND
		Lessons.subject_id = Subjects.id;
END

--ALTER PROC sp_AddScheduleForGroup
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
--			SET @passed = 1;
--		ELSE
--			SET @passed = 0;

--		INSERT Lessons (lesson_date, lesson_time, group_id, subject_id, teacher_id, is_happened)
--		VALUES
--			(@date, @time, @groupID, @subjectID, @teacherID, @passed);

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
