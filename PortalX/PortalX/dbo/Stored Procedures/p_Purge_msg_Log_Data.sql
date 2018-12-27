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
        DELETE TOP (@FChunkSize)
            [iml]
        FROM
            [dbo].[int_msg_log] AS [iml]
        WHERE
            [msg_dt] < @PurgeDate
            AND [external_id] IS NULL;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END;

    IF (@RC <> 0)
        SET @MessageLogPurged = @RC;
END;
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'p_Purge_msg_Log_Data';

