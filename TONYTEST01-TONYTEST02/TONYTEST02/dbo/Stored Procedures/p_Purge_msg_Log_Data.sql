
CREATE PROCEDURE [dbo].[p_Purge_msg_Log_Data]
(
    @FChunkSize INT,
    @PurgeDate DATETIME,
    @MessageLogPurged INT OUTPUT
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @RC INT = 0;
    DECLARE @Loop INT = 1;
    
    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize) [dbo].[int_msg_log]
        WHERE msg_dt < @PurgeDate 
            AND external_id IS NULL;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END

    IF (@RC <> 0)
    SET @MessageLogPurged = @RC;
END

