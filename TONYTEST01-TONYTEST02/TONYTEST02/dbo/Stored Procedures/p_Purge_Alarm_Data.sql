
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
        DELETE TOP (@FChunkSize) a 
        FROM [dbo].[int_alarm] a
        WHERE a.[start_dt] < @PurgeDate;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END

    IF (@RC <> 0)
    SET @AlarmsRowsPurged =@RC
END

