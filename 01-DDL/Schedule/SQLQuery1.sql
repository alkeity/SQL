USE PD311_AcademyDesign;
GO

DECLARE @groupID AS INT = (SELECT id from Groups WHERE group_name = 'PD_321');
DECLARE @subjectID AS INT = (SELECT id from Subjects WHERE subject_name LIKE '%MS SQL Server%');
DECLARE @lesson_amount AS SMALLINT = (SELECT amount_of_hours FROM Subjects WHERE subject_name LIKE '%MS SQL Server%');
DECLARE @teacherID AS BIGINT = (SELECT id FROM Teachers WHERE last_name = 'Покидюк');

DECLARE @start_date AS DATE = '2024-10-02';
DECLARE @time AS TIME = '13:30';

--PRINT(@groupID)
--PRINT(@subjectID)
--PRINT(@teacherID)

DECLARE @lesson AS SMALLINT = 0;
DECLARE @date AS DATE = @start_date;
WHILE @lesson < @lesson_amount
BEGIN
	SET @lesson = @lesson + 1;
	PRINT(FORMATMESSAGE('%i', @lesson));
END

--INSERT Lessons (lesson_date, lesson_time, group_id, subject_id, teacher_id, is_happened)
--VALUES
--	('2024-10-21', '13:30', @groupID, @subjectID, @teacherID, 0);