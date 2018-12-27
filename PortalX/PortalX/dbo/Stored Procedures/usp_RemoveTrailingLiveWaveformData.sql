CREATE PROCEDURE [dbo].[usp_RemoveTrailingLiveWaveformData]
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Message VARCHAR(200) = '';
    DECLARE @ChunkSize INT = 1500;
    DECLARE @DateString VARCHAR(30) = CAST(SYSDATETIME() AS VARCHAR(30));
    DECLARE @Flag BIT = 1;
    DECLARE @TotalRows BIGINT = 0;
    DECLARE @RowCount BIGINT = 0;
    DECLARE @ErrorNumber INT = 0;
    DECLARE @Multiplier TINYINT = 100;

    SET @Message = CAST(SYSDATETIME() AS VARCHAR(30)) + ' - Starting WaveformLiveData purge...';
    RAISERROR (@Message, 10, 1) WITH NOWAIT;

    SET @DateString = CAST(SYSDATETIME() AS VARCHAR(30));
    RAISERROR (N'%s - Chunk Size: %d', 10, 1, @DateString, @ChunkSize) WITH NOWAIT;

    SELECT
        [wld].[TopicInstanceId],
        [wld].[TypeId],
        DATEADD(SECOND, -150, MAX([wld].[EndTimeUTC])) AS [LatestUTC]
    INTO
        [#CutoffRows]
    FROM
        [dbo].[WaveformLiveData] AS [wld]
    GROUP BY
        [wld].[TopicInstanceId],
        [wld].[TypeId];

    WHILE (@Flag = 1)
    BEGIN
        BEGIN TRY
            DELETE TOP (@ChunkSize)
                [wld]
            FROM
                [dbo].[WaveformLiveData] AS [wld] WITH (ROWLOCK) -- Do not allow lock escalations.
                INNER JOIN [#CutoffRows] AS [cr]
                    ON [wld].[TopicInstanceId] = [cr].[TopicInstanceId]
                       AND [wld].[TypeId] = [cr].[TypeId]
            WHERE
                [wld].[StartTimeUTC] < [cr].[LatestUTC];

            SET @RowCount = @@ROWCOUNT;
            SET @TotalRows += @RowCount;
        END TRY
        BEGIN CATCH
            SET @ErrorNumber = ERROR_NUMBER();
            RAISERROR (N'%s - ERROR: %d - CONTINUING...', 10, 1, @DateString, @ErrorNumber) WITH NOWAIT;

            WAITFOR DELAY '00:00:01';
    
            CONTINUE;
        END CATCH;

        -- Report progress when Total Rows is a multiple of Chunk Size
        IF (@TotalRows % (@ChunkSize * @Multiplier) = 0) 
        BEGIN
            SET @DateString = CAST(SYSDATETIME() AS VARCHAR(30));
            RAISERROR (N'%s - Total Rows Deleted: %I64d ...', 10, 1, @DateString, @TotalRows) WITH NOWAIT;
        END;

        IF (@RowCount = 0)
            SET @Flag = 0;
    END;

    SET @DateString = CAST(SYSDATETIME() AS VARCHAR(30));
    RAISERROR (N'%s - Total Rows Deleted: %I64d', 10, 1, @DateString, @TotalRows) WITH NOWAIT;

    SET @Message = CAST(SYSDATETIME() AS VARCHAR(40)) + ' - Ending WaveformLiveData purge...';
    RAISERROR (@Message, 10, 1) WITH NOWAIT;
END;


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Remove the waveform live data where start times are less than the latest end times per topic instance ID.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_RemoveTrailingLiveWaveformData';

