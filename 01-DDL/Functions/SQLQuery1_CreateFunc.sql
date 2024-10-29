USE PD311_AcademyDesign;
GO

CREATE FUNCTION CompleteLessonsForTeacher
				(
				@teacher_last_name AS NVARCHAR(150),
				@start_date AS DATE,
				@end_date AS DATE
				)
				RETURNS INT
AS
BEGIN
	DECLARE @teacher_id AS INT = (SELECT id FROM Teachers WHERE last_name = @teacher_last_name);
	DECLARE @number_of_lessons AS INT = (SELECT COUNT(id) FROM Lessons WHERE teacher_id = @teacher_id AND is_happened = 1);
	RETURN @number_of_lessons;
END