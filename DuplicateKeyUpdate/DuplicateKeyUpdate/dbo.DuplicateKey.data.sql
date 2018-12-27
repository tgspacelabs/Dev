SET IDENTITY_INSERT [dbo].[DuplicateKey] ON
INSERT INTO [dbo].[DuplicateKey] ([DuplicateKeyID], [FirstName], [LastName]) VALUES (1, N'Tony', N'Green')
INSERT INTO [dbo].[DuplicateKey] ([DuplicateKeyID], [FirstName], [LastName]) VALUES (2, N'Mickey', N'Mouse')
INSERT INTO [dbo].[DuplicateKey] ([DuplicateKeyID], [FirstName], [LastName]) VALUES (3, N'Daffy', N'Duck')
INSERT INTO [dbo].[DuplicateKey] ([DuplicateKeyID], [FirstName], [LastName]) VALUES (4, N'Tony', N'Green')
SET IDENTITY_INSERT [dbo].[DuplicateKey] OFF
