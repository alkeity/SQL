USE PD311_AcademyDesign;
GO

--SELECT 
--	[ФИО] = FORMATMESSAGE('%s %s %s', last_name, first_name, middle_name),
--	[Группа] = group_name,
--	[Направление] = study_field_name
--FROM Students, Groups, StudyFields
--WHERE Students.group_id = Groups.id AND Groups.study_field_id = StudyFields.id;

--SELECT
--	[ФИО] = FORMATMESSAGE('%s %s %s', last_name, first_name, middle_name),
--	[Предмет] = subject_name
--FROM Teachers, Subjects, TeachersSubjectsRelationship
--WHERE
--	TeachersSubjectsRelationship.teacher_id = Teachers.id AND
--	TeachersSubjectsRelationship.subject_id = Subjects.id AND
--	(subject_name LIKE '%SQL%' OR
--	subject_name LIKE '%Windows%');

-- вывести все дисциплины для прочтения ADO.NET

SELECT
	Subjects.subject_name AS 'Требуемый предмет'
FROM Subjects, SubjectRequirements
WHERE
	SubjectRequirements.subject_id = (SELECT Subjects.id FROM Subjects WHERE subject_name LIKE '%ADO.NET%') AND
	SubjectRequirements.required_subject_id = Subjects.id;
