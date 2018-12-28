CREATE TABLE [dbo].[Setting] (
    [SettingID]             INT           IDENTITY (1, 1) NOT NULL,
    [UserID]                INT           NOT NULL,
    [ConfigurationName]     VARCHAR (40)  NOT NULL,
    [ConfigurationXmlValue] XML           NOT NULL,
    [CreatedDateTime]       DATETIME2 (7) CONSTRAINT [DF_UserSetting_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    [ModifiedDateTime]      DATETIME2 (7) NOT NULL,
    CONSTRAINT [PK_Setting_SettingID] PRIMARY KEY CLUSTERED ([SettingID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_Setting_UserID_ConfigurationName]
    ON [dbo].[Setting]([UserID] ASC, [ConfigurationName] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_Setting_User_UserID]
    ON [dbo].[Setting]([UserID] ASC);

