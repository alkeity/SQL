USE PD311_AcademyDesign;
GO

--EXEC PrintSchedule;
--PRINT dbo.CompleteLessonsForTeacher(N'�������', '2024-10-01', '2024-12-31');
EXEC PrintScheduleForGroup 'PD_311';