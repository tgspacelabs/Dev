CREATE TABLE [dbo].[PrintRequestData] (
    [PrintRequestDataID] INT           IDENTITY (1, 1) NOT NULL,
    [PrintRequestID]     INT           NOT NULL,
    [Name]               VARCHAR (50)  NULL,
    [Value]              VARCHAR (MAX) NULL,
    [CreatedDateTime]    DATETIME2 (7) CONSTRAINT [DF_PrintRequestData_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_PrintRequestData_PrintRequestDataID] PRIMARY KEY CLUSTERED ([PrintRequestDataID] ASC),
    CONSTRAINT [FK_PrintRequestData_PrintRequest_PrintRequestID] FOREIGN KEY ([PrintRequestID]) REFERENCES [dbo].[PrintRequest] ([PrintRequestID])
);


GO
CREATE NONCLUSTERED INDEX [FK_PrintRequestData_PrintRequest_PrintRequestID]
    ON [dbo].[PrintRequestData]([PrintRequestID] ASC);

