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
        DELETE TOP (@FChunkSize)
            [iel]
        FROM
            [dbo].[int_event_log] AS [iel]
        WHERE
            [event_dt] < @PurgeDate;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END;

    IF (@RC <> 0)
        SET @CEILogPurged = @RC;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'p_Purge_CEI_Log_Data';

