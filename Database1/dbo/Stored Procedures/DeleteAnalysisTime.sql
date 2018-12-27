

CREATE PROCEDURE [dbo].[DeleteAnalysisTime]
    (
     @UserID UNIQUEIDENTIFIER,
     @PatientID UNIQUEIDENTIFIER
    )
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM
        [dbo].[AnalysisTime]
    WHERE
        [user_id] = @UserID
        AND [patient_id] = @PatientID;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'DeleteAnalysisTime';

