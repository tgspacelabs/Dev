CREATE PROCEDURE [dbo].[WriteTrendData]
    (
     @UserID [dbo].[DUSER_ID], -- TG - Should be BIGINT
     @PatientId [dbo].[DPATIENT_ID], -- TG - Should be BIGINT
     @TotalCategories INT,
     @StartFT BIGINT,
     @TotalPeriods INT,
     @SamplesPerPeriod FLOAT, -- TG - Should be INT
     @TrendData IMAGE
    )
AS
BEGIN
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
            (CAST(@UserID AS BIGINT),
             CAST(@PatientId AS BIGINT),
             @TotalCategories,
             @StartFT,
             @TotalPeriods,
             CAST(@SamplesPerPeriod AS INT),
             @TrendData
            );
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'WriteTrendData';

