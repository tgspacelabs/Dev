CREATE PROCEDURE [dbo].[p_Purge_Alarm_Data]
    (
     @FChunkSize INT,
     @PurgeDate DATETIME,
     @AlarmsRowsPurged INT OUTPUT
    )
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @RC INT = 0;
    DECLARE @Loop INT = 1;
    
    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize)
            [a]
        FROM
            [dbo].[int_alarm] AS [a]
        WHERE
            [a].[start_dt] < @PurgeDate;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END;

    IF (@RC <> 0)
        SET @AlarmsRowsPurged = @RC;
END;
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'p_Purge_Alarm_Data';

