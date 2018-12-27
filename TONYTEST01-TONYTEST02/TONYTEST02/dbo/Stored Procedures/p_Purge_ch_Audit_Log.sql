
/* CH Audit Logs purge */
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
        DELETE TOP (@FChunkSize) [dbo].[int_audit_log]
        WHERE [audit_dt] < @PurgeDate;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END

    SET @Loop = 1;

    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize) [dbo].[AuditLogData]
        WHERE [DateTime] < @PurgeDate;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END

    IF (@RC <> 0)
    SET @ChAuditDataPurged = @RC;
END

