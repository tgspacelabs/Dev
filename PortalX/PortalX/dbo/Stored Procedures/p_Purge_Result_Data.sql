CREATE PROCEDURE [dbo].[p_Purge_Result_Data]
    (
     @FChunkSize INT,
     @PurgeDate DATETIME,
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
            [ir]
        FROM
            [dbo].[int_result] AS [ir]
        WHERE
            [ir].[obs_start_dt] < @PurgeDate;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END;

    DELETE
        [iol]
    FROM
        [dbo].[int_order_line] AS [iol]
        INNER JOIN [dbo].[int_order] AS [io] ON [iol].[order_id] = [io].[order_id]
    WHERE
        [io].[order_dt] < @PurgeDate;

    SET @RC += @@ROWCOUNT;

    DELETE
        [iom]
    FROM
        [dbo].[int_order_map] AS [iom]
        INNER JOIN [dbo].[int_order] AS [io] ON [iom].[order_id] = [io].[order_id]
    WHERE
        [io].[order_dt] < @PurgeDate;

    SET @RC += @@ROWCOUNT;

    SET @Loop = 1;
    
    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize)
            [io]
        FROM
            [dbo].[int_order] AS [io]
        WHERE
            [order_dt] < @PurgeDate;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END;

    IF (@RC <> 0)
        SET @HL7MonitorRowsPurged = @RC;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Purge old int_results data.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'p_Purge_Result_Data';

