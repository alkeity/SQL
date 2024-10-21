USE PD311_AcademyDesign;
GO

--SELECT 
--	[���] = FORMATMESSAGE('%s %s %s', last_name, first_name, middle_name),
--	[������] = group_name,
--	[�����������] = study_field_name
--FROM Students, Groups, StudyFields
--WHERE Students.group_id = Groups.id AND Groups.study_field_id = StudyFields.id;

--SELECT
--	[���] = FORMATMESSAGE('%s %s %s', last_name, first_name, middle_name),
--	[�������] = subject_name
--FROM Teachers, Subjects, TeachersSubjectsRelationship
--WHERE
--	TeachersSubjectsRelationship.teacher_id = Teachers.id AND
--	TeachersSubjectsRelationship.subject_id = Subjects.id AND
--	(subject_name LIKE '%SQL%' OR
--	subject_name LIKE '%Windows%');

-- ������� ��� ���������� ��� ��������� ADO.NET

SELECT
	Subjects.subject_name AS '��������� �������'
FROM Subjects, SubjectRequirements
WHERE
	SubjectRequirements.subject_id = (SELECT Subjects.id FROM Subjects WHERE subject_name LIKE '%ADO.NET%') AND
	SubjectRequirements.required_subject_id = Subjects.id;
