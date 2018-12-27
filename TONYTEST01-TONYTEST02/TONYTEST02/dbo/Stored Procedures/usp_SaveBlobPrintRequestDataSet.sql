

CREATE PROCEDURE [dbo].[usp_SaveBlobPrintRequestDataSet]
	(@PrintRequestDataSetEntries [dbo].[PrintRequestDataSetEntriesType] READONLY,
	 @PrintRequestDataSet [dbo].[PrintRequestDataType] READONLY,
	 @BlobDataSet [dbo].[BlobDataType] READONLY)
AS
BEGIN

	SET NOCOUNT ON

	INSERT INTO [dbo].[PrintJobs] ([Id], [TopicSessionId], [FeedTypeId])
	SELECT [PrintJobId] AS [Id], [TopicSessionId], [FeedTypeId]
	FROM
		(SELECT DISTINCT [PrintJobId], [TopicSessionId], [FeedTypeId] FROM @PrintRequestDataSetEntries
		WHERE NOT EXISTS(SELECT * FROM [PrintJobs] WHERE [PrintJobs].[Id]=[PrintJobId])) [NewPrintJobs]

	INSERT INTO [dbo].[PrintRequests] ([Id], [PrintJobId], [RequestTypeEnumValue], [RequestTypeEnumId], [TimestampUTC])
	SELECT [PrintRequestId] AS [Id], [PrintJobId], [RequestTypeEnumValue], [RequestTypeEnumId], [TimestampUTC] FROM @PrintRequestDataSetEntries

	INSERT INTO [dbo].[PrintRequestData]
	SELECT * FROM @PrintRequestDataSet

	INSERT INTO [dbo].[PrintBlobData]
	SELECT * FROM @BlobDataSet

END



