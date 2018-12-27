
CREATE PROCEDURE [dbo].[usp_IcsPrintSvc_GetActivePrintItem]
  (
  @FActivePrintJobId UNIQUEIDENTIFIER,
  @NullBooleanTrue   TINYINT
  )
AS
BEGIN
 SELECT    print_job_id, page_number, end_of_job_sw
 FROM      int_print_job
 WHERE     print_job_id = @FActivePrintJobId  and print_sw = @NullBooleanTrue
 ORDER BY  page_number
END

