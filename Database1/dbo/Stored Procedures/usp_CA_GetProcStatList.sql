﻿
CREATE PROCEDURE [dbo].[usp_CA_GetProcStatList]
    (
     @PatientID DPATIENT_ID,
     @TimeTagType INT,
     @StartTime BIGINT,
     @EndTime BIGINT
    )
AS
BEGIN	
    --SET NOCOUNT ON;

    SELECT
        [param_ft],
        [value1],
        CAST(224 AS SMALLINT) AS [sample_rate],
        [patient_channel_id]
    FROM
        [dbo].[int_param_timetag]
    WHERE
        [patient_id] = @PatientID
        AND [timetag_type] = @TimeTagType
        AND ([param_ft] BETWEEN @StartTime AND @EndTime)
    ORDER BY
        [param_ft];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_CA_GetProcStatList';

