
CREATE VIEW [dbo].[v_StitchedPatients]
WITH SCHEMABINDING
AS
SELECT
    [vps].[patient_id],
    [vps].[patient_name],
    [vps].[FIRST_NAME],
    [vps].[MIDDLE_NAME],
    [vps].[LAST_NAME],
    [vps].[MONITOR_NAME],
    [vps].[ACCOUNT_ID],
    [vps].[MRN_ID],
    [vps].[UNIT_ID],
    [vps].[UNIT_NAME],
    [vps].[UNIT_CODE],
    [vps].[FACILITY_ID],
    [vps].[FACILITY_NAME],
    [vps].[FACILITY_CODE],
    [vps].[DOB],
    MIN([ADMIT_TIME].[LocalDateTime]) AS [ADMIT_TIME],
    MAX([DISCHARGED_TIME].[LocalDateTime]) AS [DISCHARGED_TIME],
    [vps].[PATIENT_MONITOR_ID],
    [vps].[STATUS]
FROM [dbo].[v_PatientSessions] AS [vps]
    CROSS APPLY [dbo].[fntUtcDateTimeToLocalTime]([vps].[ADMIT_TIME_UTC]) AS [ADMIT_TIME]
    CROSS APPLY [dbo].[fntUtcDateTimeToLocalTime]([vps].[DISCHARGED_TIME_UTC]) AS [DISCHARGED_TIME]
GROUP BY [vps].[patient_id],
         [vps].[patient_name],
         [vps].[FIRST_NAME],
         [vps].[MIDDLE_NAME],
         [vps].[LAST_NAME],
         [vps].[MONITOR_NAME],
         [vps].[ACCOUNT_ID],
         [vps].[MRN_ID],
         [vps].[UNIT_ID],
         [vps].[UNIT_NAME],
         [vps].[UNIT_CODE],
         [vps].[FACILITY_ID],
         [vps].[FACILITY_NAME],
         [vps].[FACILITY_CODE],
         [vps].[DOB],
         [vps].[PATIENT_MONITOR_ID],
         [vps].[STATUS];

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'<View description here>', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_StitchedPatients';

