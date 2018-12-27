
CREATE PROCEDURE [dbo].[usp_SaveVitalsDataSet]
	(@vitalsData dbo.NameValueDataSetType READONLY)
AS
BEGIN

	SET NOCOUNT ON

	INSERT INTO dbo.VitalsData
	(SetId, Name, Value, TopicSessionId, FeedTypeId, TimestampUTC)
	SELECT SetId, Name, Value, TopicSessionId, FeedTypeId, TimestampUTC
	FROM @vitalsData

END

