﻿CREATE PROCEDURE [dbo].[usp_PurgeEventsData]
    (
     @FChunkSize INT,
     @PurgeDate DATETIME,
     @EventsDataRowsPurged INT OUTPUT
    )
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @RC INT = 0;
    DECLARE @Loop INT = 1;

    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize)
            [ed]
        FROM
            [dbo].[EventsData] AS [ed] WITH (ROWLOCK) -- Do not allow lock escalations.
        WHERE
            [ed].[TimestampUTC] < @PurgeDate;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END;

    SET @EventsDataRowsPurged = @RC;
END;
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Remove rows from the EventsData table that are older than the purge date parameter.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_PurgeEventsData';
