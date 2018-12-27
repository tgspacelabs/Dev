CREATE proc [dbo].[usp_CA_GetPrintJobsListByPatientIDnStartnEndDt]
(
@patient_id UNIQUEIDENTIFIER,
@startDt NVARCHAR(MAX)
)
as
begin    
        Select 
                print_job_id, 
                descr, 
                recording_time, 
                job_net_dt, 
                job_type, 
                page_number 
        From 
        int_print_job 
        Where 
        patient_id= @patient_id 
        AND 
        job_net_dt >= @startDt         
        AND 
        page_number= 1
UNION 
        Select 
                print_job_id, 
                descr, 
                recording_time,
                job_net_dt, 
                job_type, 
                page_number 
        From 
        int_print_job 
        Where 
        patient_id= @patient_id 
        AND 
        job_net_dt >= @startDt         
        AND 
        page_number=
        (
            Select 
            count(*) 
            From 
            int_print_job as print1 
            Where 
            print1.print_job_id=int_print_job.print_job_id
        ) 
Order by job_net_dt desc,
print_job_id
end
