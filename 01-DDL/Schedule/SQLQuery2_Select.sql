USE PD311_AcademyDesign;
GO

DECLARE @group_id AS INT = (SELECT id FROM Groups WHERE group_name = 'PD_321');

SELECT
	[Группа] = Groups.group_name,
	[Дата] = Lessons.lesson_date,
	[Время] = Lessons.lesson_time,
	[День недели] = DATENAME(WEEKDAY, Lessons.lesson_date),
	[Проведено] = Lessons.is_happened
FROM Lessons, Groups
WHERE
	Lessons.group_id = @group_id AND
	Groups.id = @group_id;
