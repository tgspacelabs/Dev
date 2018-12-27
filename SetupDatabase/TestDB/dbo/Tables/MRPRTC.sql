CREATE TABLE [dbo].[MRPRTC] (
    [Type]     VARCHAR (10) NOT NULL,
    [SourceID] INT          NOT NULL,
    [TargetID] INT          NOT NULL,
    CONSTRAINT [PK_MRPRTC_Type_SourceID_TargetID] PRIMARY KEY CLUSTERED ([Type] ASC, [SourceID] ASC, [TargetID] ASC) WITH (FILLFACTOR = 100)
);

