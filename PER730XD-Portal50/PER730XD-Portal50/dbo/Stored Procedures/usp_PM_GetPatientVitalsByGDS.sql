
-------------------------------------------------------

--====================================================================================================================
--=================================================usp_PM_GetPatientVitals==================================
-----------------------------------------------------------------------------------------------
-- =======================================================================
-- Purpose: Retrieves Patient Vital information from the copied ET Vitals data.
-- @gdsCodes: The alarm id associated with the print job
-- @patientId: The patient Id associated with the patient vitals to return
-- @startTimeUTC: The start time in UTC to start grabbing vitals from
-- @endTimeUTC:  The end time in UTC to finish grabbing vitals from
CREATE PROCEDURE [dbo].[usp_PM_GetPatientVitalsByGDS]
  (
  @gdsCodes [dbo].[GdsCodes] READONLY, 
  @patientId UNIQUEIDENTIFIER,
  @startTimeUTC DATETIME,
  @endTimeUTC DATETIME
  )
AS
BEGIN  
        SELECT Vitals.GDSCode
           , Vitals.Name
           , Vitals.Value
           , Vitals.ResultTimeUTC
        FROM (SELECT Vitals.[GDSCode]
          ,    Vitals.[Name]
          ,    Vitals.[Value]
          ,    Vitals.[ResultTimeUTC]
        FROM int_print_job_et_vitals Vitals 
             INNER JOIN (SELECT * FROM @gdsCodes)Codes ON Codes.GdsCode = Vitals.GDSCode
        WHERE Vitals.PatientId = @patientId
              AND Vitals.ResultTimeUTC >= @startTimeUTC
              AND Vitals.ResultTimeUTC <= @endTimeUTC

        UNION ALL

        SELECT  
            GdsCodeMap.GdsCode AS [GDSCode], 
            [VitalsData].[Name] as [Name],
            [VitalsData].[Value]  as [Value],
            [VitalsData].[TimestampUTC] as [ResultTimeUTC] 
        FROM VitalsData 
        INNER JOIN GdsCodeMap ON   GdsCodeMap.GdsCode IN (SELECT * from @gdsCodes) 
                                    AND GdsCodeMap.FeedTypeId = [VitalsData].[FeedTypeId] 
                                    AND GdsCodeMap.[Name] = [VitalsData].[Name]  
        where 
          [VitalsData].TopicSessionId in (select Id from TopicSessions where PatientSessionId in ( select DISTINCT PatientSessionId from PatientSessionsMap where PatientId = @patientId ))
            AND    [VitalsData].[TimestampUTC]  >= @startTimeUTC
            AND [VitalsData].[TimestampUTC]  <= @endTimeUTC

        UNION ALL

        SELECT  
            GdsCodeMap.GdsCode AS [GDSCode], 
            [LiveData].[Name] as [Name],
            [LiveData].[Value]  as [Value],
            [LiveData].[TimestampUTC] as [ResultTimeUTC] 
        FROM 
             [LiveData]
             INNER JOIN GdsCodeMap ON   GdsCodeMap.GdsCode IN (SELECT * from @gdsCodes) 
                                            AND GdsCodeMap.FeedTypeId = [LiveData].[FeedTypeId] 
                                            AND GdsCodeMap.[Name] = [LiveData].[Name]  
             where 
              [LiveData].TopicInstanceId in (select TopicInstanceId from TopicSessions where PatientSessionId in ( select DISTINCT PatientSessionId from PatientSessionsMap where PatientId = @patientId ) AND [TopicSessions].EndTimeUTC IS NULL)
                AND    [LiveData].[TimestampUTC]  >= @startTimeUTC
                AND [LiveData].[TimestampUTC]  <= @endTimeUTC

    ) AS Vitals
END

