CREATE PROCEDURE [dbo].[usp_PurgeDlWaveformData]
    (
     @FChunkSize INT,
     @PurgeDateUTC DATETIME,
     @WaveformDataPurged INT OUTPUT
    )
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE
        @RC INT = 0,
        @Loop INT = 1;
    
    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize)
            [wd]
        FROM
            [dbo].[WaveformData] AS [wd]
        WHERE
            [wd].[StartTimeUTC] < @PurgeDateUTC;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END;

    IF (@RC <> 0)
        SET @WaveformDataPurged = @RC;
END;
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Purge DL waveform data.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_PurgeDlWaveformData';

