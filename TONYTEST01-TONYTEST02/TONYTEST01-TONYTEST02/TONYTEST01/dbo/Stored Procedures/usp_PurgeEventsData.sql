
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
        DELETE TOP (@FChunkSize) ed 
        FROM [dbo].[EventsData] ed
        WHERE ed.[TimeStampUTC] < @PurgeDate;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END

    IF (@RC <> 0)
    SET @EventsDataRowsPurged = @RC
END
