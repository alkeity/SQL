USE PD311_AcademyDesign;
GO

DECLARE @group_id AS INT = (SELECT id FROM Groups WHERE group_name = 'PD_212');

SELECT
	[������] = Groups.group_name,
	[����] = Lessons.lesson_date,
	[�����] = Lessons.lesson_time,
	[���� ������] = DATENAME(WEEKDAY, Lessons.lesson_date),
	[���������] = IIF(Lessons.is_happened = 1, '���������', '�������������')
FROM Lessons, Groups
WHERE
	Lessons.group_id = @group_id AND
	Groups.id = @group_id;
