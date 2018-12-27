
CREATE PROCEDURE [dbo].[WriteTrendData]
  (
  @UserID           DUSER_ID,
  @PatientID        DPATIENT_ID,
  @TotalCategories  INT,
  @StartFT          BIGINT,
  @TotalPeriods     INT,
  @SamplesPerPeriod FLOAT,
  @TrendData        IMAGE
  )
AS
  BEGIN
    INSERT INTO dbo.TrendData
                (user_id,
                 patient_id,
                 total_categories,
                 start_ft,
                 total_periods,
                 samples_per_period,
                 trend_data)
    VALUES      (@UserID,
                 @PatientID,
                 @TotalCategories,
                 @StartFT,
                 @TotalPeriods,
                 @SamplesPerPeriod,
                 @TrendData)
  END

