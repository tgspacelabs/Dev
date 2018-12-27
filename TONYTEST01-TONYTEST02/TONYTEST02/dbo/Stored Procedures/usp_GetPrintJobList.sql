CREATE PROCEDURE [dbo].[usp_GetPrintJobList]
(
@filters NVARCHAR(MAX),
@FromDate NVARCHAR(MAX),
@ToDate NVARCHAR(MAX)
)
as
begin
declare @Query  NVARCHAR(MAX)='SELECT 
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
								where int_print_job.job_net_dt BETWEEN '
					
                                         set @Query = @Query + '''' + @FromDate + ''''
                                                    set @Query = @Query +' and '
                                                    set @Query = @Query + '''' + @ToDate + ''''
                                                    
                                         if(len(@filters) > 0 )
                                                            set @Query = @Query + ' and '
                                                            set @Query = @Query + @filters
                                                            
                                                            exec(@Query)
end

