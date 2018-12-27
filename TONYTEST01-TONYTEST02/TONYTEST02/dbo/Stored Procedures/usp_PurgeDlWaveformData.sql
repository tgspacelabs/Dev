
CREATE PROCEDURE [dbo].[usp_PurgeDlWaveformData]
(
    @FChunkSize INT,
    @PurgeDateUTC DATETIME,
    @WaveformDataPurged INT OUTPUT
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @l_PurgeDateUTC DATETIME = @PurgeDateUTC;
    DECLARE @RC INT = 0;
    DECLARE @Loop INT = 1;
    
    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize) wfd 
        FROM [dbo].[WaveformData] wfd
        WHERE wfd.[StartTimeUTC] < @l_PurgeDateUTC;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END

    IF (@RC <> 0)
    SET @WaveformDataPurged = @RC;
END

