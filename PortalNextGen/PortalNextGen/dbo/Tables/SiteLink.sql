CREATE TABLE [dbo].[SiteLink] (
    [SiteLinkID]      INT            IDENTITY (1, 1) NOT NULL,
    [LinkID]          INT            NOT NULL,
    [GroupName]       NVARCHAR (100) NOT NULL,
    [GroupRank]       INT            NOT NULL,
    [display_name]    NVARCHAR (100) NOT NULL,
    [DisplayRank]     INT            NOT NULL,
    [Url]             NVARCHAR (100) NULL,
    [CreatedDateTime] DATETIME2 (7)  CONSTRAINT [DF_SiteLink_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_SiteLink_SiteLinkID] PRIMARY KEY CLUSTERED ([SiteLinkID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_SiteLink_LinkID_GroupRank_DisplayRank]
    ON [dbo].[SiteLink]([LinkID] ASC, [GroupRank] ASC, [DisplayRank] ASC);

