CREATE PROCEDURE [dbo].[usp_CA_Get12LeadPrintJobByPatientnPrintJobsIDs]
(
@patient_id UNIQUEIDENTIFIER,
@print_job_id UNIQUEIDENTIFIER)
as
begin
Select 
twelve_lead_data 
FROM 
int_print_job 
WHERE 
patient_id = @patient_id 
AND 
print_job_id = @print_job_id
end

