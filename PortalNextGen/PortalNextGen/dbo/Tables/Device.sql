CREATE TABLE [dbo].[Device] (
    [DeviceID]        INT           NOT NULL,
    [Name]            VARCHAR (50)  NOT NULL,
    [Description]     VARCHAR (50)  NOT NULL,
    [Room]            VARCHAR (12)  NOT NULL,
    [CreatedDateTime] DATETIME2 (7) CONSTRAINT [DF_Device_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_Device_DeviceID] PRIMARY KEY CLUSTERED ([DeviceID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_Device_DeviceID_Name_Room]
    ON [dbo].[Device]([DeviceID] ASC);

