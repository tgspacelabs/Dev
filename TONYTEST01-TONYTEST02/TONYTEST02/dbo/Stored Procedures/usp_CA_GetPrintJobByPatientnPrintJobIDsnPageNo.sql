CREATE PROCEDURE [dbo].[usp_CA_GetPrintJobByPatientnPrintJobIDsnPageNo]
(
@patient_id UNIQUEIDENTIFIER,
@print_job_id UNIQUEIDENTIFIER,
@page_number int
)
as
begin
Select 
		descr, 
		sweep_speed,
		duration, 
		num_channels, 
		recording_time, 
		job_net_dt, 
		job_type, 
		page_number, 
		annotation1, 
		annotation2, 
		annotation3, 
		annotation4
From 
		int_print_job
Where 
					patient_id= @patient_id 
and 
					print_job_id = @print_job_id 
and 
					page_number = @page_number

/* This will need to be added back when UVSL print job are handled by DataLoader

UNION ALL

SELECT 
		[descr], 
		[sweep_speed],
		[duration], 
		[num_channels], 
		[recording_time], 
		[job_net_dt], 
		[job_type], 
		[page_number], 
		[annotation1], 
		[annotation2], 
		[annotation3], 
		[annotation4]
FROM 
		[dbo].[v_PrintJobs]
WHERE 
					[patient_id] = @patient_id 
and 
					[print_job_id] = @print_job_id 
and 
					[page_number] = @page_number
*/

ORDER BY 
		[job_net_dt]
END

