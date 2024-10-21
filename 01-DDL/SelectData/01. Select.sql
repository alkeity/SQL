USE PD311_AcademyDesign;
GO

SELECT
	--last_name + ' ' + first_name + ' ' + middle_name AS N'ФИО',
	[ФИО] = FORMATMESSAGE('%s %s %s', last_name, first_name, middle_name),
	birth_date AS N'Дата рождения'
FROM Students
WHERE birth_date > '1990-01-01'
ORDER BY birth_date DESC;