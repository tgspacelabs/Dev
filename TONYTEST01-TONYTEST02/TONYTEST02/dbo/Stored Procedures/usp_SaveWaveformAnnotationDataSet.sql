

CREATE PROCEDURE [dbo].[usp_SaveWaveformAnnotationDataSet]
	(@WaveformAnnotationDataSet [dbo].[WaveformAnnotationDataType] READONLY)
AS
BEGIN

	SET NOCOUNT ON

	INSERT INTO [dbo].[WaveformAnnotationData]
	SELECT * FROM @WaveformAnnotationDataSet

END

