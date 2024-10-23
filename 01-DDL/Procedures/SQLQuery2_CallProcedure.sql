USE PD311_AcademyDesign;
GO

--EXEC PrintTableStudentsGroups;
--EXEC PrintSchedule;
--EXEC PrintScheduleForGroup 'PD_321';
--EXEC sp_AddScheduleForGroup N'PD_212', '2024-01-10', '13:30', N'%ADO.NET%', N'Покидюк';
EXEC PrintScheduleForGroup 'PD_212';