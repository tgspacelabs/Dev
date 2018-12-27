
CREATE PROCEDURE [dbo].[p_Purge_Print_Job_Data]
    (
     @FChunkSize INT,
     @PurgeDate DATETIME,
     @PrintJobsPurged INT OUTPUT
    )
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @RC INT = 0;
    DECLARE @Loop INT = 1;
    
    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize)
            [ipjw]
        FROM
            [dbo].[int_print_job_waveform] [ipjw]
        WHERE
            [ipjw].[row_dt] < @PurgeDate;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END;

    SET @Loop = 1;
    
    WHILE (@Loop > 0)
    BEGIN
        DELETE TOP (@FChunkSize)
            [ipj]
        FROM
            [dbo].[int_print_job] [ipj]
        WHERE
            [ipj].[row_dt] < @PurgeDate;

        SET @Loop = @@ROWCOUNT;
        SET @RC += @Loop;
    END;

    IF (@RC <> 0)
        SET @PrintJobsPurged = @RC;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'p_Purge_Print_Job_Data';

