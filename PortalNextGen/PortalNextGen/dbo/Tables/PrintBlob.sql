CREATE TABLE [dbo].[PrintBlob] (
    [PrintBlobID]     INT             IDENTITY (1, 1) NOT NULL,
    [PrintRequestID]  INT             NOT NULL,
    [NumberOfBytes]   INT             NOT NULL,
    [Value]           VARBINARY (MAX) NOT NULL,
    [CreatedDateTime] DATETIME2 (7)   CONSTRAINT [DF_PrintBlob_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_PrintBlob_PrintBlobID] PRIMARY KEY CLUSTERED ([PrintBlobID] ASC),
    CONSTRAINT [FK_PrintBlob_PrintRequest_PrintRequestID] FOREIGN KEY ([PrintRequestID]) REFERENCES [dbo].[PrintRequest] ([PrintRequestID])
);


GO
CREATE NONCLUSTERED INDEX [FK_PrintBlob_PrintRequest_PrintRequestID]
    ON [dbo].[PrintBlob]([PrintRequestID] ASC);

