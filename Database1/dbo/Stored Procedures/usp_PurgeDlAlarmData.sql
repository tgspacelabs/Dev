


CREATE PROCEDURE [dbo].[usp_PurgeDlAlarmData]
    (
     @FChunkSize INT,
     @PurgeDateUTC DATETIME,
     @AlarmsRowsPurged INT OUTPUT
    )
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @l_PurgeDateUTC DATETIME = @PurgeDateUTC;
    DECLARE @RC INT = 0;
    DECLARE @Loop INT = 1;
    
    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize)
            [gad]
        FROM
            [dbo].[GeneralAlarmsData] [gad]
        WHERE
            [gad].[StartDateTime] < @l_PurgeDateUTC;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END;

    SET @Loop = 1;
    
    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize)
            [lad]
        FROM
            [dbo].[LimitAlarmsData] [lad]
        WHERE
            [lad].[StartDateTime] < @l_PurgeDateUTC;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END;

    SET @Loop = 1;
    
    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize)
            [lcd]
        FROM
            [dbo].[LimitChangeData] [lcd]
        WHERE
            [lcd].[AcquiredDateTimeUTC] < @l_PurgeDateUTC;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END;

    SET @Loop = 1;
    
    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize)
            [asd]
        FROM
            [dbo].[AlarmsStatusData] [asd]
        WHERE
            [asd].[AcquiredDateTimeUTC] < @l_PurgeDateUTC;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END;

    IF (@RC <> 0)
        SET @AlarmsRowsPurged = @RC;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_PurgeDlAlarmData';

