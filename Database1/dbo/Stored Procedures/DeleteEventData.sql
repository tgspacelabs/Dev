

CREATE PROCEDURE [dbo].[DeleteEventData]
    (
     @UserID DUSER_ID,
     @PatientID DPATIENT_ID
    )
AS
BEGIN
    SET NOCOUNT ON;

    DELETE
        [dbo].[AnalysisEvents]
    WHERE
        [user_id] = @UserID
        AND [patient_id] = @PatientID;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'DeleteEventData';

