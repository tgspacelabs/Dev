
CREATE PROCEDURE [dbo].[usp_CA_GetLegacyPatientWaveForms] 
(
@patient_id UNIQUEIDENTIFIER, 
@channelIds [dbo].[StringList] READONLY,
@start_ft bigint, 
@end_ft bigint
)
AS
BEGIN
    SELECT  wfrm.start_ft
            ,wfrm.end_ft
            ,wfrm.start_dt
            ,wfrm.end_dt
            ,wfrm.compress_method
            ,CAST(wfrm.waveform_data AS VARBINARY(MAX)) as waveform_data
            ,pc.channel_type_id as channel_id
        FROM 
        dbo.int_waveform wfrm WITH (NOLOCK)
        INNER JOIN 
        int_patient_channel pc ON wfrm.patient_channel_id = pc.patient_channel_id
        INNER JOIN
        int_patient_monitor pm ON pc.patient_monitor_id = pm.patient_monitor_id
        INNER JOIN
        int_encounter pe ON pm.encounter_id = pe.encounter_id
        WHERE 
        (wfrm.patient_id = @patient_id) AND
        (pc.channel_type_id IN (SELECT * FROM @channelIds)) AND
        (@start_ft < wfrm.end_ft) AND
        (@end_ft >= wfrm.start_ft)
    ORDER BY [start_ft]
END
