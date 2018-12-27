
CREATE PROCEDURE [dbo].[RetrieveTrendData]
    (
     @UserID DUSER_ID,
     @PatientID DPATIENT_ID
    )
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [user_id],
        [patient_id],
        [total_categories],
        [start_ft],
        [total_periods],
        [samples_per_period],
        [trend_data]
    FROM
        [dbo].[TrendData]
    WHERE
        ([user_id] = @UserID
        AND [patient_id] = @PatientID
        );
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'RetrieveTrendData';

