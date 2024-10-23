USE PD311_AcademyDesign;
GO

DECLARE @cur_date AS DATE = GETDATE();
DECLARE @req_exp AS INT = 10;

SELECT
	[���] = FORMATMESSAGE('%s %s %s', last_name, first_name, middle_name),
	[�������] = DATEDIFF(year, birth_date, @cur_date),
	[���� ������������] = DATEDIFF(year, year_started, @cur_date)
FROM Teachers;

SELECT
	[���] = FORMATMESSAGE('%s %s %s', last_name, first_name, middle_name),
	[���� ������������] = DATEDIFF(year, year_started, @cur_date)
FROM Teachers
WHERE DATEDIFF(year, year_started, @cur_date) > @req_exp;