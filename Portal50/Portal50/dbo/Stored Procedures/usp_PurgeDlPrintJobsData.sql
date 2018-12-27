
CREATE PROCEDURE [dbo].[usp_PurgeDlPrintJobsData]
  (
  @FChunkSize INT,
  @PurgeDate  VARCHAR(30),
  @PrintJobsPurged INT OUTPUT
  )
AS
BEGIN
    SET NOCOUNT ON;
	
	DECLARE @RC INT = 0;

	DELETE TOP (@FChunkSize) [dbo].[PrintBlobData]
	WHERE PrintRequestId IN (SELECT id FROM [dbo].[PrintRequests]
	WHERE [dbo].fnUtcDateTimeToLocalTime(TimestampUTC) < @PurgeDate);

    SET @RC = @RC + @@ROWCOUNT

	DELETE TOP (@FChunkSize) [dbo].[WaveformPrintData]
	WHERE PrintRequestId IN(select id from PrintRequests
	WHERE [dbo].fnUtcDateTimeToLocalTime(TimestampUTC) < @PurgeDate);

    SET @RC = @RC + @@ROWCOUNT

	DELETE TOP (@FChunkSize) [dbo].[PrintRequests]
	WHERE [dbo].fnUtcDateTimeToLocalTime(TimestampUTC) < @PurgeDate;

	--TRUNCATE TABLE [dbo].[PrintJobs] --don't have a clear idea 

    SET @RC = @RC + @@ROWCOUNT;

    IF (@RC <> 0)
    SET @PrintJobsPurged = @RC;
END
