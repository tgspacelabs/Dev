
CREATE VIEW [dbo].[v_StitchedPatients]
AS
SELECT
    [pat].[PATIENT_ID],
    [pat].[PATIENT_NAME],
    [pat].[FIRST_NAME],
    [pat].[MIDDLE_NAME],
    [pat].[LAST_NAME],
    [pat].[MONITOR_NAME],
    [pat].[ACCOUNT_ID],
    [pat].[MRN_ID],
    [pat].[UNIT_ID],
    [pat].[UNIT_NAME],
    [pat].[UNIT_CODE],
    [pat].[FACILITY_ID],
    [pat].[FACILITY_NAME],
    [pat].[FACILITY_CODE],
    [pat].[DOB],
    [Admit].[LocalDateTime] AS [ADMIT_TIME],
    [Discharged].[LocalDateTime] AS [DISCHARGED_TIME],
    [pat].[PATIENT_MONITOR_ID],
    [pat].[STATUS]
FROM
    (SELECT
        [vps].[PATIENT_ID],
        [vps].[PATIENT_NAME],
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
        MIN([vps].[ADMIT_TIME_UTC]) AS [ADMIT_TIME_UTC],
        MAX([vps].[DISCHARGED_TIME_UTC]) AS [DISCHARGED_TIME_UTC],
        [vps].[PATIENT_MONITOR_ID],
        [vps].[STATUS]
     FROM
        [dbo].[v_PatientSessions] AS [vps]
     GROUP BY
        [vps].[PATIENT_ID],
        [vps].[PATIENT_NAME],
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
        [vps].[STATUS]
    ) AS [pat]
    CROSS APPLY [dbo].[fntUtcDateTimeToLocalTime]([pat].[ADMIT_TIME_UTC]) AS [Admit]
    CROSS APPLY [dbo].[fntUtcDateTimeToLocalTime]([pat].[DISCHARGED_TIME_UTC]) AS [Discharged];

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'<View description here>', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_StitchedPatients';

