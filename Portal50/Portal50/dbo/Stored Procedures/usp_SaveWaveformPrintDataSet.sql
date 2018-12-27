

CREATE PROCEDURE [dbo].[usp_SaveWaveformPrintDataSet]
	(@WaveformPrintDataSet [dbo].[WaveformPrintDataType] READONLY)
AS
BEGIN

	SET NOCOUNT ON

	INSERT INTO [dbo].[WaveformPrintData]
	SELECT * FROM @WaveformPrintDataSet

END
