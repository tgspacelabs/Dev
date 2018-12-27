


CREATE PROCEDURE [dbo].[GetRawECGData] (@PatientID dPATIENT_ID, 
                                        @ChannelTypeID dCHANNEL_TYPE_ID, 
                                        @StartTime BIGINT, 
                                        @EndTime BIGINT)
AS
BEGIN

	DECLARE @ChannelIds AS [dbo].[StringList]

	INSERT INTO @ChannelIds ([Item])
		VALUES (@ChannelTypeID)
	
	EXEC [dbo].[usp_CA_GetPatientWaveforms] @patient_id=@PatientID, @channelIds=@ChannelIds, @start_ft=@StartTime, @end_ft=@EndTime	
    
END

