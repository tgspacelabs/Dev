--USE [portal]
--GO

--/****** Object:  StoredProcedure [dbo].[usp_SaveEventsDataSetX]    Script Date: 5/18/2015 11:56:45 AM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO

CREATE PROCEDURE [dbo].[usp_SaveEventsDataSetX]
    (@eventsData dbo.EventDataType READONLY)
AS
BEGIN
    SET NOCOUNT ON

    INSERT INTO dbo.EventsDataX
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
