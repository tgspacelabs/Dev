

CREATE PROCEDURE [dbo].[WriteTrendData]
    (
     @UserID DUSER_ID,
     @PatientID DPATIENT_ID,
     @TotalCategories INT,
     @StartFT BIGINT,
     @TotalPeriods INT,
     @SamplesPerPeriod FLOAT,
     @TrendData IMAGE
    )
AS
BEGIN
    SET NOCOUNT ON;

    INSERT  INTO [dbo].[TrendData]
            ([user_id],
             [patient_id],
             [total_categories],
             [start_ft],
             [total_periods],
             [samples_per_period],
             [trend_data]
            )
    VALUES
            (@UserID,
             @PatientID,
             @TotalCategories,
             @StartFT,
             @TotalPeriods,
             @SamplesPerPeriod,
             @TrendData
            );
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'WriteTrendData';

