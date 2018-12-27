
CREATE PROCEDURE [dbo].[p_Purge_CEI_Log_Data]
(
    @FChunkSize INT,
    @PurgeDate DATETIME,
    @CEILogPurged INT OUTPUT
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @RC INT = 0;
    DECLARE @Loop INT = 1;

    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP(@FChunkSize) [dbo].[int_event_log]
        WHERE event_dt < @PurgeDate;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END

	IF (@RC <> 0)
    SET @CEILogPurged = @RC;
END

