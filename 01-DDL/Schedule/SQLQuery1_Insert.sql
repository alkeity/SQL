USE PD311_AcademyDesign;
GO

DECLARE @groupID AS INT = (SELECT id from Groups WHERE group_name = 'PD_212');
DECLARE @subjectID AS INT = (SELECT id from Subjects WHERE subject_name LIKE '%MS SQL Server%');
DECLARE @lesson_amount AS SMALLINT = (SELECT amount_of_hours FROM Subjects WHERE subject_name LIKE '%MS SQL Server%');
DECLARE @teacherID AS BIGINT = (SELECT id FROM Teachers WHERE last_name = 'Покидюк');

DECLARE @start_date AS DATE = '2023-11-27';
DECLARE @start_time AS TIME = '13:30';
DECLARE @cur_date AS DATE = GETDATE();

DECLARE @lesson AS SMALLINT = 0;
DECLARE @date AS DATE = @start_date;
DECLARE @time AS TIME = @start_time;
DECLARE @passed AS BIT = 0;

WHILE @lesson < @lesson_amount
BEGIN

	IF DATEDIFF(DAY, @cur_date, @date) < 0
		SET @passed = 1;
	ELSE
		SET @passed = 0;

	--PRINT(FORMATMESSAGE('Урок №%i, %s %s %s', @lesson, CAST(@passed AS VARCHAR), CAST(@date AS VARCHAR), CAST(@time AS VARCHAR)));
	--PRINT(FORMATMESSAGE('День недели: %s', DATENAME(weekday, @date)));
	--PRINT('---------------------------------------------------------')

	INSERT Lessons (lesson_date, lesson_time, group_id, subject_id, teacher_id, is_happened)
	VALUES
		(@date, @time, @groupID, @subjectID, @teacherID, @passed);

	SET @lesson = @lesson + 1;

	IF @time = @start_time
		SET @time = DATEADD(HOUR, 2, @time);
	ELSE
		SET @time = @start_time

	IF DATEPART(WEEKDAY, @date) IN (2, 4) AND @time = @start_time
		SET @date = DATEADD(DAY, 2, @date);
	ELSE IF DATEPART(WEEKDAY, @date) = 6 AND @time = @start_time
		SET @date = DATEADD(DAY, 3, @date);
END
