


/* EventsData */
CREATE PROCEDURE [dbo].[usp_PurgeEventsData]
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
            [dbo].[EventsData] [ed]
        WHERE
            [ed].[TimeStampUTC] < @PurgeDate;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
        PRINT CAST(@Loop AS VARCHAR(10)) + ' rows deleted - Total: ' + CAST(@RC AS VARCHAR(10));
    END;

    IF (@RC <> 0)
        SET @EventsDataRowsPurged = @RC;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_PurgeEventsData';

