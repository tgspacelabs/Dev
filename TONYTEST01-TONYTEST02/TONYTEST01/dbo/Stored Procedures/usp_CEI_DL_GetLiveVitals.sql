


CREATE PROCEDURE [dbo].[usp_CEI_DL_GetLiveVitals]
AS
BEGIN
       SET NOCOUNT ON;
              SELECT 
              v_livevitalsdata.Name, 
              v_livevitalsdata.ResultValue, 
              v_livevitalsdata.GdsCode,
              int_misc_code.int_keystone_cd AS UOM,
              int_misc_code.short_dsc AS Short_Desc,
              v_livevitalsdata.PatientId, 
              PATDATA.MRN_ID AS ID1, 
              PATDATA.ACCOUNT_ID AS ID2,  
              PATDATA.UNIT_CODE AS organization_cd, 
              PATDATA.PATIENT_NAME, 
              PATDATA.MONITOR_NAME, 
              PATDATA.MONITOR_NAME AS NodeId 
              FROM v_livevitalsdata 
              INNER JOIN
              (SELECT TopicInstanceId,Max(DateTimeStampUTC) MaxVitalTime
                     FROM v_liveVitalsData GROUP BY TopicInstanceId) AS MaxLiveVital
              ON  MaxLiveVital.TopicInstanceId=v_liveVitalsData.TopicInstanceId
              AND MaxLiveVital.MaxVitalTime=v_liveVitalsData.DateTimeStampUTC
              LEFT OUTER JOIN v_PatientSessions AS PATDATA 
                     ON     PATDATA.PATIENT_ID = v_livevitalsdata.PatientId
              INNER JOIN int_misc_code  
                     ON int_misc_code.code = v_livevitalsdata.GdsCode
              WHERE v_livevitalsdata.GdsCode IS NOT NULL 
              AND int_misc_code.method_cd = 'GDS'
       
       SET NOCOUNT OFF;
END

