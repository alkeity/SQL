USE PD311_AcademyDesign;
GO

SELECT
	[ФИО] = FORMATMESSAGE('%s %s %s', Students.last_name, Students.first_name, Students.middle_name),
	[Группа] = Groups.group_name
FROM Students JOIN Groups ON (Students.group_id = Groups.id);