CREATE PROCEDURE [dbo].[usp_PurgeDlAlarmData]
    (
     @FChunkSize INT,
     @PurgeDateUTC DATETIME,
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
            [gad]
        FROM
            [dbo].[GeneralAlarmsData] AS [gad] WITH (ROWLOCK) -- Do not allow lock escalations.
        WHERE
            [gad].[StartDateTime] < @PurgeDateUTC;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END;

    SET @Loop = 1;
    
    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize)
            [lad]
        FROM
            [dbo].[LimitAlarmsData] AS [lad] WITH (ROWLOCK) -- Do not allow lock escalations.
        WHERE
            [lad].[StartDateTime] < @PurgeDateUTC;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END;

    SET @Loop = 1;
    
    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize)
            [lcd]
        FROM
            [dbo].[LimitChangeData] AS [lcd] WITH (ROWLOCK) -- Do not allow lock escalations.
        WHERE
            [lcd].[AcquiredDateTimeUTC] < @PurgeDateUTC;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END;

    SET @Loop = 1;
    
    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize)
            [asd]
        FROM
            [dbo].[AlarmsStatusData] AS [asd] WITH (ROWLOCK) -- Do not allow lock escalations.
        WHERE
            [asd].[AcquiredDateTimeUTC] < @PurgeDateUTC;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END;

    IF (@RC <> 0)
        SET @AlarmsRowsPurged = @RC;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Purge DL alarm data.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_PurgeDlAlarmData';

