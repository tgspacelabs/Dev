

CREATE PROCEDURE [dbo].[usp_SaveEventsDataSet]
    (
     @eventsData [dbo].EventDataType READONLY
    )
AS
BEGIN
    SET NOCOUNT ON;

    INSERT  INTO [dbo].[EventsData]
            ([Id],
             [CategoryValue],
             [Type],
             [Subtype],
             [Value1],
             [Value2],
             [status],
             [valid_leads],
             [TopicSessionId],
             [FeedTypeId],
             [TimeStampUTC]
	        )
    SELECT
        [Id],
        [CategoryValue],
        [Type],
        [Subtype],
        [Value1],
        [Value2],
        [status],
        [valid_leads],
        [TopicSessionId],
        [FeedTypeId],
        [TimeStampUTC]
    FROM
        @eventsData;

END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_SaveEventsDataSet';

