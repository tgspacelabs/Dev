CREATE PROCEDURE [dbo].[usp_PurgeDlPrintJobsData]
    (
     @FChunkSize INT,
     @PurgeDate VARCHAR(30), -- TG - Should be DATETIME
     @PrintJobsPurged INT OUTPUT
    )
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @RC INT = 0;

    DELETE TOP (@FChunkSize)
        [dbo].[PrintBlobData]
    WHERE
        [PrintRequestId] IN (SELECT
                                [Id]
                             FROM
                                [dbo].[PrintRequests]
                             WHERE
                                [dbo].[fnUtcDateTimeToLocalTime]([TimestampUTC]) < CAST(@PurgeDate AS DATETIME));

    SET @RC = @RC + @@ROWCOUNT;

    DELETE TOP (@FChunkSize)
        [dbo].[WaveformPrintData]
    WHERE
        [PrintRequestId] IN (SELECT
                                [Id]
                             FROM
                                [dbo].[PrintRequests]
                             WHERE
                                [dbo].[fnUtcDateTimeToLocalTime]([TimestampUTC]) < CAST(@PurgeDate AS DATETIME));

    SET @RC = @RC + @@ROWCOUNT;

    DELETE TOP (@FChunkSize)
        [dbo].[PrintRequests]
    WHERE
        [dbo].[fnUtcDateTimeToLocalTime]([TimestampUTC]) < CAST(@PurgeDate AS DATETIME);

    --TRUNCATE TABLE [dbo].[PrintJobs] --don't have a clear idea 

    SET @RC = @RC + @@ROWCOUNT;

    IF (@RC <> 0)
        SET @PrintJobsPurged = @RC;
END;
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_PurgeDlPrintJobsData';

