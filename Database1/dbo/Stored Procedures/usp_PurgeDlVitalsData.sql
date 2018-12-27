

CREATE PROCEDURE [dbo].[usp_PurgeDlVitalsData]
    (
     @FChunkSize INT,
     @PurgeDateUTC DATETIME,
     @hl7MonitorRowsPurged INT OUTPUT
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
            [vd]
        FROM
            [dbo].[VitalsData] [vd]
        WHERE
            [vd].[TimestampUTC] < @l_PurgeDateUTC;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END;

    SET @Loop = 1;
    
    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize)
            [sd]
        FROM
            [dbo].[StatusData] [sd]
        WHERE
            [sd].[SetId] IN (SELECT
                            [sds].[Id]
                           FROM
                            [dbo].[StatusDataSets] [sds]
                           WHERE
                            [sds].[TimestampUTC] < @l_PurgeDateUTC);

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END;

    SET @Loop = 1;
    
    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize)
            [sds]
        FROM
            [dbo].[StatusDataSets] [sds]
        WHERE
            [sds].[TimestampUTC] < @l_PurgeDateUTC;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END;

    IF (@RC <> 0)
        SET @hl7MonitorRowsPurged = @RC;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_PurgeDlVitalsData';

