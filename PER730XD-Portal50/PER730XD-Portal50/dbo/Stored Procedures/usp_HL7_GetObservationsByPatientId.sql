

/*[usp_HL7_GetObservationsByPatientId] will retreive the  patient observations by patient id
@PatientID is mandatory,@StartTime and @EndTime are passed it will return the observations between the given time span */
CREATE PROCEDURE [dbo].[usp_HL7_GetObservationsByPatientId](@patient_id UNIQUEIDENTIFIER, @StartTime DATETIME, @EndTime DATETIME, @StartTimeUtc DATETIME, @EndTimeUtc DATETIME)  
AS
BEGIN
    SET NOCOUNT ON;

        SELECT DISTINCT
        Code.code_id AS CodeId, 
        Code.code AS Code, 
        Code.short_dsc AS Descr, 
        Code.int_keystone_cd AS Units,
        Result.result_value AS ResultValue, 
        Result.value_type_cd AS ValueTypeCd,
        Result.status_cid AS ResultStatus, 
        Result.probability AS Probability, 
        Result.reference_range_id AS ReferenceRange, 
        Result.abnormal_nature_cd AS AbnormalNatureCd, 
        Result.abnormal_cd AS AbnormalCd, 
        Result.result_dt AS ResultTime
        FROM  int_result AS Result 
        INNER JOIN int_misc_code AS Code 
            ON Result.test_cid = Code.code_id
        WHERE (Result.patient_id = @patient_id) 
        AND (Result.result_dt BETWEEN @StartTime AND @EndTime)
        AND Result.result_value IS NOT NULL
        
        UNION ALL
        
        SELECT 
        GdsCodeMap.CodeId
        ,GdsCodeMap.GdsCode AS Code
        ,GdsCodeMap.[Description] as Descr
        ,GdsCodeMap.Units
        ,VitalsData.Value AS ResultValue
        ,'' AS ValueTypeCd
        ,NULL AS ResultStatus
        ,NULL AS Probability
        ,NULL AS ReferenceRange
        ,NULL AS AbnormalNatureCd
        ,NULL AS AbnormalCd
        ,dbo.fnUtcDateTimeToLocalTime(TimestampUTC) as ResultTime
        FROM VitalsData
            INNER JOIN GdsCodeMap on GdsCodeMap.FeedTypeId = VitalsData.FeedTypeId and GdsCodeMap.Name = VitalsData.Name
            INNER JOIN v_PatientTopicSessions on VitalsData.TopicSessionId = v_PatientTopicSessions.TopicSessionId
            WHERE PatientId =@patient_id
            and TimestampUTC BETWEEN @StartTimeUtc AND @EndTimeUtc


    SET NOCOUNT OFF;
END
