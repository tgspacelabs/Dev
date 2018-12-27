CREATE PROCEDURE [dbo].[usp_PurgeDlVitalsData]
    (
     @FChunkSize INT,
     @PurgeDateUTC DATETIME,
     @HL7MonitorRowsPurged INT OUTPUT
    )
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @RC INT = 0;
    DECLARE @Loop INT = 1;
    
    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize)
            [vd]
        FROM
            [dbo].[VitalsData] AS [vd]
        WHERE
            [vd].[TimestampUTC] < @PurgeDateUTC;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END;

    SET @Loop = 1;
    
    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize)
            [sd]
        FROM
            [dbo].[StatusData] AS [sd]
        WHERE
            [sd].[SetId] IN (SELECT
                                [sds].[Id]
                             FROM
                                [dbo].[StatusDataSets] AS [sds]
                             WHERE
                                [sds].[TimestampUTC] < @PurgeDateUTC);

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END;

    SET @Loop = 1;
    
    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize)
            [sds]
        FROM
            [dbo].[StatusDataSets] AS [sds]
        WHERE
            [sds].[TimestampUTC] < @PurgeDateUTC;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END;

    IF (@RC <> 0)
        SET @HL7MonitorRowsPurged = @RC;
END;
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Purge data loader vitals data.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_PurgeDlVitalsData';

