USE PD311_AcademyDesign;
GO

--SELECT
--	Groups.group_name AS N'������',
--	[���������� ���������] = COUNT(Students.id)
--FROM Students, Groups
--WHERE Students.group_id = Groups.id
--GROUP BY Groups.group_name
--ORDER BY [���������� ���������];

SELECT
	[�����������] = study_field_name,
	[���������� ���������] = COUNT(Students.id)
FROM Students, StudyFields, Groups
WHERE
	Students.group_id = Groups.id AND
	Groups.study_field_id = StudyFields.id
GROUP BY StudyFields.study_field_name;