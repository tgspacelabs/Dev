
CREATE PROCEDURE [dbo].[usp_GetPrintJobList]
    (
     @filters NVARCHAR(MAX),
     @FromDate NVARCHAR(MAX),
     @ToDate NVARCHAR(MAX)
    )
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Query NVARCHAR(MAX)= 'SELECT 
                    int_print_job.print_sw as ''Print'', 
                    int_print_job.printer_name as Printer,
                    int_print_job.descr as ''Description'',
                    int_print_job.page_number as Pages,
                    int_print_job.row_dt as ''Date'',
                    int_mrn_map.mrn_xid as Patient,
                    int_print_job.status_code as ''Status'',
                    int_print_job.status_msg as ''Message'',
                    int_print_job.job_type,
                    int_mrn_map.patient_id  
                    FROM 
                    int_print_job 
                    INNER JOIN int_mrn_map 
                                ON int_print_job.patient_id = int_mrn_map.patient_id 
					where int_print_job.job_net_dt BETWEEN ';
					
    SET @Query = @Query + '''' + @FromDate + '''';
    SET @Query = @Query + ' and ';
    SET @Query = @Query + '''' + @ToDate + '''';
                                                    
    IF (LEN(@filters) > 0)
        SET @Query = @Query + ' and ';
    SET @Query = @Query + @filters;
                                                            
    EXEC(@Query);
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_GetPrintJobList';

