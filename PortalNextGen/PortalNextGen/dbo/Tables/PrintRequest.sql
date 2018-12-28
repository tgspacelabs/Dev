CREATE TABLE [dbo].[PrintRequest] (
    [PrintRequestID]       INT           IDENTITY (1, 1) NOT NULL,
    [PrintJobID]           INT           NOT NULL,
    [RequestTypeEnumID]    INT           NOT NULL,
    [RequestTypeEnumValue] INT           NOT NULL,
    [Timestamp]            DATETIME2 (7) NOT NULL,
    [CreatedDateTime]      DATETIME2 (7) CONSTRAINT [DF_PrintRequest_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_PrintRequest_PrintRequestID] PRIMARY KEY CLUSTERED ([PrintRequestID] ASC),
    CONSTRAINT [FK_PrintRequest_PrintJob_PrintJobID] FOREIGN KEY ([PrintJobID]) REFERENCES [dbo].[PrintJob] ([PrintJobID])
);


GO
CREATE NONCLUSTERED INDEX [FK_PrintRequest_PrintJob_PrintJobID]
    ON [dbo].[PrintRequest]([PrintJobID] ASC);

