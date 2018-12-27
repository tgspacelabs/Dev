
/*[usp_HL7_GetAttendingHcpData] used to get attending HCP data*/
CREATE PROCEDURE [dbo].[usp_HL7_GetAttendingHcpData](@patient_id UNIQUEIDENTIFIER)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
    hcpMap.hcp_xid hcpID ,
    last_nm hcpLastName,
    first_nm hcpFirstName, 
    middle_nm hcpMiddleName 
    FROM int_hcp hcp,
    int_hcp_map hcpMap, 
    int_encounter enc, 
    int_encounter_map encMap 
    WHERE hcp.hcp_id=hcpMap.hcp_id 
    AND enc.patient_id =@patient_id 
    AND enc.encounter_Id  = encMap.Encounter_Id 
    AND encMap.seq_no=1 
    AND encMap.status_cd = 'C' 
    And enc.attend_hcp_id = hcp.hcp_id    
    SET NOCOUNT OFF;
END
