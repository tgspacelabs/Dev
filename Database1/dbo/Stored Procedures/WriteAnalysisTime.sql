

CREATE PROCEDURE [dbo].[WriteAnalysisTime]
    (
     @UserID UNIQUEIDENTIFIER,
     @PatientID UNIQUEIDENTIFIER,
     @StartFt BIGINT,
     @EndFt BIGINT,
     @AnalysisType INT
    )
AS
BEGIN
    SET NOCOUNT ON;

    INSERT  INTO [dbo].[AnalysisTime]
            ([user_id],
             [patient_id],
             [start_ft],
             [end_ft],
             [analysis_type]
            )
    VALUES
            (@UserID,
             @PatientID,
             @StartFt,
             @EndFt,
             @AnalysisType
            );
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'WriteAnalysisTime';

