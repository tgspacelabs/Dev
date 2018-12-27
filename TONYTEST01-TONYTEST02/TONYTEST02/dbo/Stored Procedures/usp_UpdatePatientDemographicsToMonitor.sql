CREATE PROCEDURE [dbo].[usp_UpdatePatientDemographicsToMonitor]
(
@patient_id UNIQUEIDENTIFIER

)
as
begin
	UPDATE 
                                                                    int_patient_monitor 
                                                                    SET  
                                                                    monitor_status ='UPD' 
                                                                    WHERE 
                                                                    patient_id = @patient_id
                                                                    AND 
                                                                    active_sw = 1
end

