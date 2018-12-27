CREATE TABLE [dbo].[StatusData] (
    [Id]    UNIQUEIDENTIFIER NOT NULL,
    [SetId] UNIQUEIDENTIFIER NOT NULL,
    [Name]  VARCHAR (25)     NOT NULL,
    [Value] VARCHAR (25)     NULL,
    CONSTRAINT [PK_StatusData_Id] PRIMARY KEY NONCLUSTERED ([Id] ASC)
);


GO
CREATE CLUSTERED INDEX [IX_StatusDataSetId]
    ON [dbo].[StatusData]([SetId] ASC);


GO
CREATE NONCLUSTERED INDEX [_dta_index_StatusData_5_1751677288__K2_K3_1_4_f2]
    ON [dbo].[StatusData]([SetId] ASC, [Name] ASC)
    INCLUDE([Id], [Value]) WHERE ([StatusData].[Name] IN ('lead1Index', 'lead2Index'));


GO
CREATE NONCLUSTERED INDEX [_dta_index_StatusData_5_1751677288__K3_2_4]
    ON [dbo].[StatusData]([Name] ASC)
    INCLUDE([SetId], [Value]);

