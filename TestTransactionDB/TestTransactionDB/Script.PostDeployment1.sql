/*
Post-Deployment Script Template                            
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.        
 Use SQLCMD syntax to include a file in the post-deployment script.            
 Example:      :r .\myfile.sql                                
 Use SQLCMD syntax to reference a variable in the post-deployment script.        
 Example:      :setvar TableName MyTable                            
               SELECT * FROM [$(TableName)]                    
--------------------------------------------------------------------------------------
*/


--TRUNCATE TABLE [dbo].[EventsDataX];
--GO

SET IDENTITY_INSERT [dbo].[EventsDataX] ON 
GO

INSERT [dbo].[EventsDataX] ([TimeStampUTC], [Id], [CategoryValue], [Type], [Subtype], [Value1], [Value2], [Status], [ValidLeads], [TopicSessionId], [FeedTypeId], [Sequence]) VALUES (CAST(N'2015-11-04 01:35:02.680' AS DateTime), N'6ca51466-e75c-49e3-a92a-c3449a284d8d', 1, 0, 0, 0, 0, 0, 0, N'97b0cea6-4563-4162-93d1-0895c6567a1a', N'004b8425-b277-46ca-9600-e344957dd97b', 1)
GO
INSERT [dbo].[EventsDataX] ([TimeStampUTC], [Id], [CategoryValue], [Type], [Subtype], [Value1], [Value2], [Status], [ValidLeads], [TopicSessionId], [FeedTypeId], [Sequence]) VALUES (CAST(N'2015-11-04 01:35:04.283' AS DateTime), N'4f63655d-0014-463a-82c8-408156cbf8f9', 2, 0, 0, 0, 0, 0, 0, N'13b03830-55e4-44e2-8483-75cfec6f577f', N'182e8dfe-75cd-4428-9efe-34495724de8e', 2)
GO
INSERT [dbo].[EventsDataX] ([TimeStampUTC], [Id], [CategoryValue], [Type], [Subtype], [Value1], [Value2], [Status], [ValidLeads], [TopicSessionId], [FeedTypeId], [Sequence]) VALUES (CAST(N'2015-11-04 01:35:04.883' AS DateTime), N'3e68d3ec-fdec-40ff-a71f-fcd40b983b12', 3, 0, 0, 0, 0, 0, 0, N'65774303-c946-40cf-bfe2-4996ab45d613', N'004287e7-59c6-4a23-b5bf-1f74201ada3f', 3)
GO
INSERT [dbo].[EventsDataX] ([TimeStampUTC], [Id], [CategoryValue], [Type], [Subtype], [Value1], [Value2], [Status], [ValidLeads], [TopicSessionId], [FeedTypeId], [Sequence]) VALUES (CAST(N'2015-11-04 01:35:05.477' AS DateTime), N'f8771f9d-e99d-49be-85e1-ce7caf21ab3d', 4, 0, 0, 0, 0, 0, 0, N'b3507c22-e5ae-4492-8bef-ebb1e4e40d28', N'2d0f5c68-7fab-42b9-b611-7021ea460ba7', 4)
GO
INSERT [dbo].[EventsDataX] ([TimeStampUTC], [Id], [CategoryValue], [Type], [Subtype], [Value1], [Value2], [Status], [ValidLeads], [TopicSessionId], [FeedTypeId], [Sequence]) VALUES (CAST(N'2015-11-04 01:35:07.057' AS DateTime), N'dd7b88f0-d59e-49e1-8d64-00efa0692724', 4, 0, 0, 0, 0, 0, 0, N'a5e15778-ce7f-4903-82e8-981415dfff17', N'57f7d906-6f0b-489a-9c69-6cb64a0d896f', 5)
GO
INSERT [dbo].[EventsDataX] ([TimeStampUTC], [Id], [CategoryValue], [Type], [Subtype], [Value1], [Value2], [Status], [ValidLeads], [TopicSessionId], [FeedTypeId], [Sequence]) VALUES (CAST(N'2015-11-04 01:35:09.360' AS DateTime), N'8deae7c2-6f35-42b9-ad6d-d3bd5d842267', 3, 0, 0, 0, 0, 0, 0, N'a0788e56-0bae-46ba-b57c-7ee4a6b722aa', N'1506c712-a856-4f48-a59f-55839e274b0c', 6)
GO
INSERT [dbo].[EventsDataX] ([TimeStampUTC], [Id], [CategoryValue], [Type], [Subtype], [Value1], [Value2], [Status], [ValidLeads], [TopicSessionId], [FeedTypeId], [Sequence]) VALUES (CAST(N'2015-11-04 01:35:09.823' AS DateTime), N'20a0a795-5d62-41ab-97a6-8aeae004e387', 2, 0, 0, 0, 0, 0, 0, N'704c917c-7fad-416a-8f6f-177aa176e61d', N'392ed54f-e038-4ffd-9b65-70dd13ea94d1', 7)
GO
INSERT [dbo].[EventsDataX] ([TimeStampUTC], [Id], [CategoryValue], [Type], [Subtype], [Value1], [Value2], [Status], [ValidLeads], [TopicSessionId], [FeedTypeId], [Sequence]) VALUES (CAST(N'2015-11-04 01:35:10.903' AS DateTime), N'9cae0092-ce8e-47ca-9aff-5ac9f2eb473d', 1, 0, 0, 0, 0, 0, 0, N'2b1bc1e7-02d5-4ef2-a2d8-e5d459f3d309', N'436c5262-b07b-455b-a88d-06c3a053334f', 8)
GO
INSERT [dbo].[EventsDataX] ([TimeStampUTC], [Id], [CategoryValue], [Type], [Subtype], [Value1], [Value2], [Status], [ValidLeads], [TopicSessionId], [FeedTypeId], [Sequence]) VALUES (CAST(N'2015-11-04 01:35:11.977' AS DateTime), N'8975cef7-7b1e-4493-aec3-4266e91f4f08', 6, 0, 0, 0, 0, 0, 0, N'a4b74ba2-4f35-40f6-971b-8b54013be8cf', N'11f6c3be-8fcc-41a2-b69a-075ea147d834', 9)
GO
INSERT [dbo].[EventsDataX] ([TimeStampUTC], [Id], [CategoryValue], [Type], [Subtype], [Value1], [Value2], [Status], [ValidLeads], [TopicSessionId], [FeedTypeId], [Sequence]) VALUES (CAST(N'2015-11-04 01:35:13.103' AS DateTime), N'c9a8c123-580d-4a00-9d3f-a89f8eff9318', 5, 0, 0, 0, 0, 0, 0, N'69ad8872-61e6-4b80-a364-800eac69ce34', N'a0707819-de26-4f5e-9a74-c5ed71b28ffe', 10)
GO
INSERT [dbo].[EventsDataX] ([TimeStampUTC], [Id], [CategoryValue], [Type], [Subtype], [Value1], [Value2], [Status], [ValidLeads], [TopicSessionId], [FeedTypeId], [Sequence]) VALUES (CAST(N'2015-11-04 01:35:14.430' AS DateTime), N'7f42a567-50f8-4d5a-9ca7-039488e2c095', 7, 0, 0, 0, 0, 0, 0, N'0fab62a9-0275-49f4-adcd-8e05f87b01fb', N'fb2da5d6-35cb-46e3-8117-655752c4c314', 11)
GO
INSERT [dbo].[EventsDataX] ([TimeStampUTC], [Id], [CategoryValue], [Type], [Subtype], [Value1], [Value2], [Status], [ValidLeads], [TopicSessionId], [FeedTypeId], [Sequence]) VALUES (CAST(N'2015-11-04 01:35:14.877' AS DateTime), N'544727e5-9d58-4e53-b397-e33e6a99d80e', 8, 0, 0, 0, 0, 0, 0, N'2f0b6401-f016-43b9-b3c3-40db46910738', N'389b6e1c-b8ae-4b32-a73e-ef5c175a1c85', 12)
GO
INSERT [dbo].[EventsDataX] ([TimeStampUTC], [Id], [CategoryValue], [Type], [Subtype], [Value1], [Value2], [Status], [ValidLeads], [TopicSessionId], [FeedTypeId], [Sequence]) VALUES (CAST(N'2015-11-04 01:35:16.130' AS DateTime), N'cebfa94f-8146-4f0e-af25-6e8d694b566d', 9, 0, 0, 0, 0, 0, 0, N'faa30839-71d0-4b61-82ad-a358c3651d5e', N'4127f22e-d426-4602-9e96-febb7601d65b', 13)
GO
INSERT [dbo].[EventsDataX] ([TimeStampUTC], [Id], [CategoryValue], [Type], [Subtype], [Value1], [Value2], [Status], [ValidLeads], [TopicSessionId], [FeedTypeId], [Sequence]) VALUES (CAST(N'2015-11-04 01:35:20.110' AS DateTime), N'3d0d2acb-1148-4241-b40c-42c49362c8d0', 4, 0, 0, 0, 0, 0, 0, N'5444223d-a0aa-43a8-bae8-7a1a405055c0', N'dcdc3f21-39c4-4c67-83cb-ad80bbc67879', 14)
GO
INSERT [dbo].[EventsDataX] ([TimeStampUTC], [Id], [CategoryValue], [Type], [Subtype], [Value1], [Value2], [Status], [ValidLeads], [TopicSessionId], [FeedTypeId], [Sequence]) VALUES (CAST(N'2015-11-04 01:35:21.097' AS DateTime), N'0b1352f9-06ea-4c84-b0b1-d000879583f7', 5, 0, 0, 0, 0, 0, 0, N'c4437ee8-ff27-4301-858f-f86a5c992d4d', N'293e68d0-3188-4d3d-80af-76e3b1ad7d2c', 15)
GO
INSERT [dbo].[EventsDataX] ([TimeStampUTC], [Id], [CategoryValue], [Type], [Subtype], [Value1], [Value2], [Status], [ValidLeads], [TopicSessionId], [FeedTypeId], [Sequence]) VALUES (CAST(N'2015-11-04 01:35:22.840' AS DateTime), N'2c4840ff-f1c2-455f-adc4-5298abb56d37', 6, 0, 0, 0, 0, 0, 0, N'19d81a15-d255-43e8-a6f0-d0f716c70469', N'eff78970-e472-40e4-8730-91bc5b625fb3', 16)
GO
INSERT [dbo].[EventsDataX] ([TimeStampUTC], [Id], [CategoryValue], [Type], [Subtype], [Value1], [Value2], [Status], [ValidLeads], [TopicSessionId], [FeedTypeId], [Sequence]) VALUES (CAST(N'2015-11-04 01:35:25.430' AS DateTime), N'f9daf9a8-62c5-4292-8c99-045f5d1016fe', 7, 0, 0, 0, 0, 0, 0, N'293a148c-1961-484c-b707-013fffcbecd1', N'7e5a9f71-3cd6-4d5d-91d5-c3614bd14ff3', 17)
GO
INSERT [dbo].[EventsDataX] ([TimeStampUTC], [Id], [CategoryValue], [Type], [Subtype], [Value1], [Value2], [Status], [ValidLeads], [TopicSessionId], [FeedTypeId], [Sequence]) VALUES (CAST(N'2015-11-04 01:35:26.393' AS DateTime), N'0a5d3c05-5050-4f85-a788-a75a658625de', 8, 0, 0, 0, 0, 0, 0, N'f5514451-51fc-46b6-89a2-ef9b727281af', N'65f2b42c-bfd8-4a07-9ec0-6e40c2c12e63', 18)
GO
INSERT [dbo].[EventsDataX] ([TimeStampUTC], [Id], [CategoryValue], [Type], [Subtype], [Value1], [Value2], [Status], [ValidLeads], [TopicSessionId], [FeedTypeId], [Sequence]) VALUES (CAST(N'2015-11-04 01:35:28.200' AS DateTime), N'e8e71f81-a6d5-4993-b527-8077cf566b7f', 9, 0, 0, 0, 0, 0, 0, N'b4df6ca6-2d6d-4add-8102-355ff6f987fd', N'bce5fa1f-7cdb-4e5f-b786-0f56e3fe75ba', 19)
GO

SET IDENTITY_INSERT [dbo].[EventsDataX] OFF
GO
