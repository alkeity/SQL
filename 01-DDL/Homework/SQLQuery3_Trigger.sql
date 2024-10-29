USE PD311_AcademyDesign;
GO

CREATE TRIGGER CompleteSubject
ON Lessons
AFTER INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON; -- supress rows affected msgs
	DECLARE @group_id AS INT, @subject_id AS INT, @passed AS BIT;

	SELECT
		@group_id = group_id,
		@subject_id = subject_id,
		@passed = is_happened
	FROM inserted;

	IF @passed = 1
	BEGIN
		DECLARE @lessons AS INT, @all_lessons AS INT;

		SELECT
			@lessons = COUNT(id)
		FROM Lessons WHERE subject_id = @subject_id AND group_id = @group_id AND is_happened = 1;

		SELECT @all_lessons = amount_of_hours FROM Subjects WHERE id = @subject_id;
		PRINT(FORMATMESSAGE('lessons: %i, completed: %i', @all_lessons, @lessons));

		IF @lessons = (SELECT amount_of_hours FROM Subjects WHERE id = @subject_id)
		   AND NOT EXISTS (SELECT * FROM CompleteSubjects WHERE subject_id = @subject_id AND group_id = @group_id)
		BEGIN
			INSERT INTO CompleteSubjects (subject_id, group_id) VALUES (@subject_id, @group_id);
		END
	END
END
