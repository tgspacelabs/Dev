CREATE TABLE [dbo].[ApplicationSettings] (
    [ApplicationType] VARCHAR (50)   NOT NULL,
    [InstanceId]      VARCHAR (50)   NOT NULL,
    [Key]             VARCHAR (50)   NOT NULL,
    [Value]           VARCHAR (5000) NULL,
    CONSTRAINT [PK_ApplicationSettings_ApplicationType_InstanceId_Key] PRIMARY KEY CLUSTERED ([ApplicationType] ASC, [InstanceId] ASC, [Key] ASC)
);

