create proc [dbo].[usp_CA_Get12LeadPrintJobByPatientnReportIDs]
(            
@patient_id UNIQUEIDENTIFIER,
@report_id UNIQUEIDENTIFIER
)
as
begin
Select 
report_data 
FROM 
int_12lead_report 
WHERE 
patient_id = @patient_id 
AND 
report_id = @report_id
end
