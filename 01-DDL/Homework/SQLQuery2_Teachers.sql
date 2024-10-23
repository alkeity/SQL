USE PD311_AcademyDesign;
GO

DECLARE @cur_date AS DATE = GETDATE();
DECLARE @req_exp AS INT = 10;

SELECT
	[ФИО] = FORMATMESSAGE('%s %s %s', last_name, first_name, middle_name),
	[Возраст] = DATEDIFF(year, birth_date, @cur_date),
	[Опыт преподавания] = DATEDIFF(year, year_started, @cur_date)
FROM Teachers;

SELECT
	[ФИО] = FORMATMESSAGE('%s %s %s', last_name, first_name, middle_name),
	[Опыт преподавания] = DATEDIFF(year, year_started, @cur_date)
FROM Teachers
WHERE DATEDIFF(year, year_started, @cur_date) > @req_exp;