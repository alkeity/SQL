USE PD311_AcademyDesign;
GO

SELECT
	--last_name + ' ' + first_name + ' ' + middle_name AS N'���',
	[���] = FORMATMESSAGE('%s %s %s', last_name, first_name, middle_name),
	birth_date AS N'���� ��������'
FROM Students
WHERE birth_date > '1990-01-01'
ORDER BY birth_date DESC;