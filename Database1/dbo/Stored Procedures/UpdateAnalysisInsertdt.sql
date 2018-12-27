
CREATE PROCEDURE [dbo].[UpdateAnalysisInsertdt]
    (
     @patient_id UNIQUEIDENTIFIER,
     @user_id UNIQUEIDENTIFIER,
     @insert_dt DATETIME
    )
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE
        [dbo].[AnalysisTime]
    SET
        [insert_dt] = @insert_dt
    WHERE
        [patient_id] = @patient_id
        AND [user_id] = @user_id;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'UpdateAnalysisInsertdt';

