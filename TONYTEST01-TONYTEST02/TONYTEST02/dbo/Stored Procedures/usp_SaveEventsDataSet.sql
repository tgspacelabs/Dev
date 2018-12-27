
CREATE PROCEDURE [dbo].[usp_SaveEventsDataSet]
	(@eventsData dbo.EventDataType READONLY)
AS
BEGIN

	SET NOCOUNT ON

	INSERT INTO dbo.EventsData
	(
		Id, 
		CategoryValue, 
		[Type], 
		Subtype, 
		Value1, 
		Value2, 
		[status], 
		valid_leads,
		TopicSessionId,
		FeedTypeId,
		TimeStampUTC
	)
	SELECT 
		Id, 
		CategoryValue, 
		[Type], 
		Subtype, 
		Value1, 
		Value2, 
		[status], 
		valid_leads,
		TopicSessionId,
		FeedTypeId,
		TimeStampUTC
	FROM @eventsData

END

