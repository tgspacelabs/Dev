CREATE TABLE [dbo].[MonitorX] (
    [Name]            VARCHAR (20)  NOT NULL,
    [DataLoader]      VARCHAR (10)  NOT NULL,
    [CreatedDateTime] DATETIME2 (7) CONSTRAINT [DF_MonitorX_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_MonitorX_Name] PRIMARY KEY CLUSTERED ([Name] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_MonitorX_DataLoader]
    ON [dbo].[MonitorX]([DataLoader] ASC);

