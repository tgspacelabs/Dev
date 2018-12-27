
CREATE PROCEDURE [dbo].[usp_IcsPrintSvc_LoadPrintItems]
	(
	@NullBooleanTrue TINYINT
	)
AS
BEGIN
	SET NOCOUNT ON;

     SELECT   print_job_id, page_number, end_of_job_sw
     FROM     [dbo].int_print_job
     WHERE    print_sw = @NullBooleanTrue
     ORDER BY job_net_dt, print_job_id, page_number
END

