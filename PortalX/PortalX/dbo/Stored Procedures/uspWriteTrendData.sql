CREATE PROCEDURE [dbo].[uspWriteTrendData]
    (
    @UserID UNIQUEIDENTIFIER,
    @PatientId UNIQUEIDENTIFIER,
    @TotalCategories INT,
    @StartFT BIGINT,
    @TotalPeriods INT,
    @SamplesPerPeriod FLOAT, -- TG - Should be INT
    @TrendData IMAGE)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO [dbo].[TrendData] ([user_id],
                                   [patient_id],
                                   [total_categories],
                                   [start_ft],
                                   [total_periods],
                                   [samples_per_period],
                                   [trend_data])
    VALUES (
           @UserID, @PatientId, @TotalCategories, @StartFT, @TotalPeriods, CAST(@SamplesPerPeriod AS INT), @TrendData
           );
END;
GO
EXECUTE [sys].[sp_addextendedproperty]
    @name = N'MS_Description',
    @value = N'',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'PROCEDURE',
    @level1name = N'uspWriteTrendData';
