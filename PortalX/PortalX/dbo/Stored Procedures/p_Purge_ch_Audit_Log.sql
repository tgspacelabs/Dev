CREATE PROCEDURE [dbo].[p_Purge_ch_Audit_Log]
    (
     @FChunkSize INT,
     @PurgeDate DATETIME,
     @ChAuditDataPurged INT OUTPUT
    )
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @RC INT = 0;
    DECLARE @Loop INT = 1;

    --Purge data from int_audit_log too on 2/28/08
    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize)
            [ial]
        FROM
            [dbo].[int_audit_log] AS [ial]
        WHERE
            [audit_dt] < @PurgeDate;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END;

    SET @Loop = 1;

    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize)
            [ald]
        FROM
            [dbo].[AuditLogData] AS [ald]
        WHERE
            [DateTime] < @PurgeDate;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END;

    IF (@RC <> 0)
        SET @ChAuditDataPurged = @RC;
END;
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'CH Audit Logs purge.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'p_Purge_ch_Audit_Log';

