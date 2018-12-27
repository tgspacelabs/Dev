
CREATE PROCEDURE [dbo].[p_Purge_ch_Log_Data]
(
    @FChunkSize INT,
    @PurgeDate DATETIME,
    @CHLogDataPurged INT OUTPUT
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @RC INT = 0;
    DECLARE @Loop INT = 1;

    --Purge data from logData too on 2/28/08
    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize) [dbo].[LogData]
        WHERE  DateTime < @PurgeDate;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END

    IF (@RC <> 0)
    SET @CHLogDataPurged = @RC;
END

