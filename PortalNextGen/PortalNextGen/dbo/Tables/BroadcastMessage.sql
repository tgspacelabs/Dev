CREATE TABLE [dbo].[BroadcastMessage] (
    [BroadcastMessageID] INT            IDENTITY (1, 1) NOT NULL,
    [timer_msg]          NVARCHAR (255) NULL,
    [login_msg]          NVARCHAR (255) NULL,
    [log_out_minutes]    INT            NULL,
    [keep_out]           INT            NULL,
    [disable_autoprocs]  INT            NULL,
    [CreatedDateTime]    DATETIME2 (7)  CONSTRAINT [DF_BroadcastMessage_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_BroadcastMessage_BroadcastMessageID] PRIMARY KEY CLUSTERED ([BroadcastMessageID] ASC)
);

