CREATE PROCEDURE [dbo].[usp_PurgeDlPrintJobsData]
    (
    @FChunkSize INT,
    @PurgeDate VARCHAR(30), -- TG - Should be DATETIME
    @PrintJobsPurged INT OUTPUT)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @RC INT = 0;

    DELETE TOP (@FChunkSize)
    [dbo].[PrintBlobData]
    WHERE [PrintRequestId] IN (SELECT [pr].[Id]
                               FROM [dbo].[PrintRequests] AS [pr]
                                   CROSS APPLY [dbo].[fntUtcDateTimeToLocalTime]([pr].[TimestampUTC]) AS [timestampLocal]
                               WHERE
                                   [timestampLocal].[LocalDateTime] < CAST(@PurgeDate AS DATETIME));

    SET @RC = @RC + @@ROWCOUNT;

    DELETE TOP (@FChunkSize)
    [dbo].[WaveformPrintData]
    WHERE [PrintRequestId] IN (SELECT [pr].[Id]
                               FROM [dbo].[PrintRequests] AS [pr]
                                   CROSS APPLY [dbo].[fntUtcDateTimeToLocalTime]([pr].[TimestampUTC]) AS [timestampLocal]
                               WHERE
                                   [timestampLocal].[LocalDateTime] < CAST(@PurgeDate AS DATETIME));

    SET @RC = @RC + @@ROWCOUNT;

    DELETE TOP (@FChunkSize)
    [pr]
    FROM [dbo].[PrintRequests] AS [pr]
        CROSS APPLY [dbo].[fntUtcDateTimeToLocalTime]([pr].[TimestampUTC]) AS [timestampLocal]
    WHERE
        [timestampLocal].[LocalDateTime] < CAST(@PurgeDate AS DATETIME);

    SET @RC = @RC + @@ROWCOUNT;

    SET @PrintJobsPurged = @RC;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_PurgeDlPrintJobsData';

