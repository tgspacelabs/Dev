CREATE TABLE [dbo].[AlarmRetrieved] (
    [AlarmID]         INT           NOT NULL,
    [Annotation]      VARCHAR (120) NOT NULL,
    [Retrieved]       TINYINT       NOT NULL,
    [CreatedDateTime] DATETIME2 (7) CONSTRAINT [DF_AlarmRetrieved_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_AlarmRetrieved_AlarmID] PRIMARY KEY CLUSTERED ([AlarmID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_AlarmRetrieved_CreatedDateTime]
    ON [dbo].[AlarmRetrieved]([CreatedDateTime] ASC);

