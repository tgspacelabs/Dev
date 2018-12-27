



CREATE PROCEDURE [dbo].[usp_CEI_DL_GetLiveVitals]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [Name],
        [ResultValue],
        [GdsCode],
        [int_keystone_cd] AS [UOM],
        [short_dsc] AS [Short_Desc],
        [PatientId],
        [PATDATA].[MRN_ID] AS [ID1],
        [PATDATA].[ACCOUNT_ID] AS [ID2],
        [PATDATA].[UNIT_CODE] AS [organization_cd],
        [PATDATA].[PATIENT_NAME],
        [PATDATA].[MONITOR_NAME],
        [PATDATA].[MONITOR_NAME] AS [NodeId]
    FROM
        [dbo].[v_LiveVitalsData]
        INNER JOIN (SELECT
                        [TopicInstanceId],
                        MAX([DateTimeStampUTC]) [MaxVitalTime]
                    FROM
                        [dbo].[v_LiveVitalsData]
                    GROUP BY
                        [TopicInstanceId]
                   ) AS [MaxLiveVital] ON [MaxLiveVital].[TopicInstanceId] = [v_LiveVitalsData].[TopicInstanceId]
                                          AND [MaxLiveVital].[MaxVitalTime] = [DateTimeStampUTC]
        LEFT OUTER JOIN [dbo].[v_PatientSessions] AS [PATDATA] ON [PATDATA].[PATIENT_ID] = [PatientId]
        INNER JOIN [dbo].[int_misc_code] ON [code] = [GdsCode]
    WHERE
        [GdsCode] IS NOT NULL
        AND [method_cd] = 'GDS';
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_CEI_DL_GetLiveVitals';

