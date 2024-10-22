USE PD311_AcademyDesign;
GO

DECLARE @subject_name AS NVARCHAR(50) = '����������� ���������������� �� ����� C++';

SELECT
	[��������� ����������] = Subjects.subject_name
FROM Subjects, SubjectRequirements
WHERE
	Subjects.id = SubjectRequirements.subject_id AND
	SubjectRequirements.required_subject_id = (SELECT id FROM Subjects WHERE subject_name = @subject_name);
