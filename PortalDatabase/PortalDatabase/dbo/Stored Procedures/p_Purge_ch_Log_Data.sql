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
        DELETE TOP (@FChunkSize)
            [ld]
        FROM
            [dbo].[LogData] AS [ld]
        WHERE
            [DateTime] < @PurgeDate;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END;

    IF (@RC <> 0)
        SET @CHLogDataPurged = @RC;
END;
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'p_Purge_ch_Log_Data';

