USE PD311_AcademyDesign;
GO

DECLARE @group_id AS INT = (SELECT id FROM Groups WHERE group_name = 'PD_212');

SELECT
	[Группа] = Groups.group_name,
	[Дата] = Lessons.lesson_date,
	[Время] = Lessons.lesson_time,
	[День недели] = DATENAME(WEEKDAY, Lessons.lesson_date),
	[Проведено] = IIF(Lessons.is_happened = 1, 'Проведено', 'Запланировано')
FROM Lessons, Groups
WHERE
	Lessons.group_id = @group_id AND
	Groups.id = @group_id;
