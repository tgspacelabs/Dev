
/* int_results purger */
CREATE PROCEDURE [dbo].[p_Purge_Result_Data]
  (
    @FChunkSize INT, 
    @PurgeDate DATETIME, 
    @hl7MonitorRowsPurged INT OUTPUT
  )
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @RC INT = 0;
    DECLARE @Loop INT = 1;
    
    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize) ir
        FROM [dbo].[int_result] ir
        WHERE ir.[obs_start_dt] < @PurgeDate;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END

    DELETE iol 
    FROM [dbo].[int_order_line] iol
        INNER JOIN [dbo].[int_order] io
        ON iol.[order_id] = io.[order_id]
    WHERE io.[order_dt] < @PurgeDate;

    SET @RC += @@ROWCOUNT;

    DELETE iom
    FROM [dbo].[int_order_map] iom
        INNER JOIN [dbo].[int_order] io
        ON iom.[order_id] = io.[order_id]
    WHERE io.[order_dt] < @PurgeDate;

    SET @RC += @@ROWCOUNT;

    SET @Loop = 1;
    
    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize) 
        FROM [dbo].[int_order]
        WHERE [order_dt] < @PurgeDate;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END

    IF (@RC <> 0)
    SET @hl7MonitorRowsPurged = @RC;
END
