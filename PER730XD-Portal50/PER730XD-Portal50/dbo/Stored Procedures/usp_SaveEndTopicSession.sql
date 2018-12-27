
CREATE PROCEDURE [dbo].[usp_SaveEndTopicSession]
    (@endTopicSessionData dbo.TopicSessionDataType READONLY)
AS
BEGIN
    
    SET NOCOUNT ON

    MERGE INTO [dbo].[TopicSessions] AS [Target]
        USING @endTopicSessionData AS [Source]
        ON [Source].[Id] = [Target].[Id]
        WHEN NOT MATCHED BY TARGET
            THEN INSERT ([Id], [EndTimeUTC])
                 VALUES
                 (
                    [Source].[Id],
                    [Source].[EndTimeUTC]
                 )
        WHEN MATCHED
            THEN UPDATE SET [Target].[EndTimeUTC] = [Source].[EndTimeUTC]
    ;

END
