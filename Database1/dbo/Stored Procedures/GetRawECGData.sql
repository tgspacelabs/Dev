



CREATE PROCEDURE [dbo].[GetRawECGData]
    (
     @PatientID DPATIENT_ID,
     @ChannelTypeID DCHANNEL_TYPE_ID,
     @StartTime BIGINT,
     @EndTime BIGINT
    )
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ChannelIds AS [dbo].[StringList];

    INSERT  INTO @ChannelIds
            ([Item])
    VALUES
            (@ChannelTypeID);
	
    EXEC [dbo].[usp_CA_GetPatientWaveForms] @patient_id = @PatientID, @channelIds = @ChannelIds, @start_ft = @StartTime, @end_ft = @EndTime;	
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetRawECGData';

