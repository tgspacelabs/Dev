CREATE PROCEDURE [dbo].[RetrieveTrendData]
    (
     @UserID [dbo].[DUSER_ID], -- TG - Should be BIGINT
     @PatientId [dbo].[DPATIENT_ID] -- TG - Should be BIGINT
    )
AS
BEGIN
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
        [user_id] = CAST(@UserID AS BIGINT)
        AND [patient_id] = CAST(@PatientId AS BIGINT); 
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'RetrieveTrendData';

