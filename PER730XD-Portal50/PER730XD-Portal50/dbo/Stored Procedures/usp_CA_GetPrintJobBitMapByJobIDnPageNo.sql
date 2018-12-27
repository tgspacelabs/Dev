create proc [dbo].[usp_CA_GetPrintJobBitMapByJobIDnPageNo]
(
@print_job_id UNIQUEIDENTIFIER,
@page_number int
)
as
begin
Select 
        byte_height, 
        bitmap_height, 
        bitmap_width, 
        print_bitmap, 
        recording_time
From 
        int_print_job
Where 
        print_job_id= @print_job_id
    and 
        page_number = @page_number
end
