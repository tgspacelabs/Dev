

/*[usp_HL7_GetAttendingHcpData] used to get attending HCP data*/
CREATE PROCEDURE [dbo].[usp_HL7_GetAttendingHcpData]
    (
     @patient_id UNIQUEIDENTIFIER
    )
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [hcpMap].[hcp_xid] [hcpID],
        [hcp].[last_nm] [hcpLastName],
        [hcp].[first_nm] [hcpFirstName],
        [hcp].[middle_nm] [hcpMiddleName]
    FROM
        [dbo].[int_hcp] [hcp],
        [dbo].[int_hcp_map] [hcpMap],
        [dbo].[int_encounter] [enc],
        [dbo].[int_encounter_map] [encMap]
    WHERE
        [hcp].[hcp_id] = [hcpMap].[hcp_id]
        AND [enc].[patient_id] = @patient_id
        AND [enc].[encounter_id] = [encMap].[encounter_id]
        AND [encMap].[seq_no] = 1
        AND [encMap].[status_cd] = 'C'
        AND [enc].[attend_hcp_id] = [hcp].[hcp_id];	
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Get attending HCP data.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_HL7_GetAttendingHcpData';

